const db = require("../config/database");

(async () => {
  try {
    console.log("=== KIỂM TRA SISTERS VÀ COMMUNITY ===\n");

    // 1. Check sisters table schema
    const [schema] = await db.query("DESCRIBE sisters");
    const hasCommunityCol = schema.find(
      (col) => col.Field === "current_community_id"
    );

    if (hasCommunityCol) {
      console.log("✅ Sisters table có cột 'current_community_id'");
      console.log(`   Type: ${hasCommunityCol.Type}`);
      console.log(`   Null: ${hasCommunityCol.Null}`);
      console.log(`   Default: ${hasCommunityCol.Default}`);
    } else {
      console.log("❌ Sisters table KHÔNG có cột 'current_community_id'");
    }

    // 2. Count sisters with current_community_id
    const [withCommunity] = await db.query(
      "SELECT COUNT(*) as total FROM sisters WHERE current_community_id IS NOT NULL"
    );
    const [totalSisters] = await db.query(
      "SELECT COUNT(*) as total FROM sisters"
    );

    console.log(`\nTổng số nữ tu: ${totalSisters[0].total}`);
    console.log(`Nữ tu có current_community_id: ${withCommunity[0].total}`);

    // 3. Check community_assignments
    const [assignments] = await db.query(`
      SELECT 
        COUNT(*) as total,
        COUNT(DISTINCT sister_id) as unique_sisters,
        COUNT(CASE WHEN end_date IS NULL OR end_date >= CURDATE() THEN 1 END) as current_assignments
      FROM community_assignments
    `);

    console.log("\nBảng community_assignments:");
    console.log(`  Tổng số assignments: ${assignments[0].total}`);
    console.log(`  Số nữ tu có assignment: ${assignments[0].unique_sisters}`);
    console.log(
      `  Assignments hiện tại: ${assignments[0].current_assignments}`
    );

    // 4. Show sample sisters with their community info
    console.log("\n=== 5 NỮ TU MẪU ===");
    const [samples] = await db.query(`
      SELECT 
        s.id,
        s.saint_name,
        s.birth_name,
        s.code,
        s.current_community_id,
        c.name as current_community_name,
        ca.community_id as assigned_community_id,
        c2.name as assigned_community_name,
        ca.role as role_in_community,
        ca.start_date,
        ca.end_date
      FROM sisters s
      LEFT JOIN communities c ON s.current_community_id = c.id
      LEFT JOIN community_assignments ca ON s.id = ca.sister_id 
        AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())
      LEFT JOIN communities c2 ON ca.community_id = c2.id
      ORDER BY s.id
      LIMIT 5
    `);
    console.table(samples);

    // 5. Recommendation
    console.log("\n=== KHUYẾN NGHỊ ===");
    if (
      withCommunity[0].total === 0 &&
      assignments[0].current_assignments > 0
    ) {
      console.log(
        "⚠️ Sisters KHÔNG có current_community_id nhưng CÓ community_assignments"
      );
      console.log("\nCó 2 giải pháp:");
      console.log(
        "1. CẬP NHẬT current_community_id cho sisters từ community_assignments:"
      );
      console.log("   UPDATE sisters s");
      console.log(
        "   INNER JOIN community_assignments ca ON s.id = ca.sister_id"
      );
      console.log("   SET s.current_community_id = ca.community_id");
      console.log("   WHERE ca.end_date IS NULL OR ca.end_date >= CURDATE()");
      console.log(
        "\n2. SỬA scopeHelper để JOIN với community_assignments thay vì dùng current_community_id"
      );
    } else if (
      withCommunity[0].total > 0 &&
      assignments[0].current_assignments === 0
    ) {
      console.log(
        "Sisters CÓ current_community_id nhưng KHÔNG CÓ community_assignments"
      );
      console.log("→ Scope filter có thể hoạt động với current_community_id");
    } else if (
      withCommunity[0].total > 0 &&
      assignments[0].current_assignments > 0
    ) {
      console.log(
        "Sisters CÓ CẢ current_community_id VÀ community_assignments"
      );
      console.log("→ Cần đồng bộ 2 nguồn dữ liệu này");
    } else {
      console.log("Sisters KHÔNG có thông tin cộng đoàn");
      console.log("→ Cần thêm dữ liệu community assignments");
    }

    process.exit(0);
  } catch (err) {
    console.error("❌ Error:", err.message);
    process.exit(1);
  }
})();
