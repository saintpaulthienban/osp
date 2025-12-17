const db = require("../config/database");

(async () => {
  try {
    console.log(
      "=== ĐỒNG BỘ current_community_id TỪ community_assignments ===\n"
    );

    // 1. Show current state
    const [before] = await db.query(
      "SELECT COUNT(*) as total FROM sisters WHERE current_community_id IS NOT NULL"
    );
    console.log(
      `Trước khi update: ${before[0].total} sisters có current_community_id`
    );

    // 2. Update current_community_id from current assignments
    const [result] = await db.query(`
      UPDATE sisters s
      INNER JOIN community_assignments ca ON s.id = ca.sister_id
      SET s.current_community_id = ca.community_id
      WHERE (ca.end_date IS NULL OR ca.end_date >= CURDATE())
    `);

    console.log(`✅ Đã cập nhật ${result.affectedRows} sisters`);

    // 3. Show after state
    const [after] = await db.query(
      "SELECT COUNT(*) as total FROM sisters WHERE current_community_id IS NOT NULL"
    );
    console.log(
      `Sau khi update: ${after[0].total} sisters có current_community_id`
    );

    // 4. Show updated sisters
    console.log("\n=== NỮ TU ĐÃ CẬP NHẬT ===");
    const [updated] = await db.query(`
      SELECT 
        s.id,
        s.saint_name,
        s.birth_name,
        s.code,
        s.current_community_id,
        c.name as community_name
      FROM sisters s
      LEFT JOIN communities c ON s.current_community_id = c.id
      WHERE s.current_community_id IS NOT NULL
      ORDER BY s.current_community_id, s.id
    `);
    console.table(updated);

    // 5. Count by community
    console.log("\n=== THỐNG KÊ THEO CỘNG ĐOÀN ===");
    const [stats] = await db.query(`
      SELECT 
        c.id,
        c.name,
        COUNT(s.id) as sister_count
      FROM communities c
      LEFT JOIN sisters s ON s.current_community_id = c.id
      GROUP BY c.id, c.name
      ORDER BY sister_count DESC, c.name
    `);
    console.table(stats);

    console.log(
      "\n✅ Hoàn tất! Bây giờ scope filter sẽ hoạt động với current_community_id"
    );

    process.exit(0);
  } catch (err) {
    console.error("❌ Error:", err.message);
    console.error(err.stack);
    process.exit(1);
  }
})();
