const db = require("../config/database");

(async () => {
  try {
    console.log("=== KIỂM TRA USER SCOPE ===\n");

    // 1. Check all users and their scopes
    console.log("1. Danh sách users và scope:");
    const [users] = await db.query(`
      SELECT id, username, email, is_admin, data_scope, is_super_admin
      FROM users
      ORDER BY id
    `);
    console.table(users);

    // 2. Check user community assignments
    console.log("\n2. Phân bổ cộng đoàn cho users:");
    const [assignments] = await db.query(`
      SELECT 
        uc.user_id,
        u.username,
        u.data_scope,
        uc.community_id,
        c.name as community_name
      FROM user_communities uc
      JOIN users u ON uc.user_id = u.id
      JOIN communities c ON uc.community_id = c.id
      ORDER BY uc.user_id, uc.community_id
    `);
    console.table(assignments);

    // 3. Check which sisters belong to which communities
    console.log("\n3. Nữ tu thuộc cộng đoàn nào (current assignments):");
    const [sisterCommunities] = await db.query(`
      SELECT 
        s.id as sister_id,
        s.saint_name,
        s.birth_name,
        s.code,
        s.current_community_id,
        c.name as current_community_name,
        ca.community_id as assigned_community_id,
        c2.name as assigned_community_name
      FROM sisters s
      LEFT JOIN communities c ON s.current_community_id = c.id
      LEFT JOIN community_assignments ca ON s.id = ca.sister_id 
        AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())
      LEFT JOIN communities c2 ON ca.community_id = c2.id
      ORDER BY s.id
      LIMIT 10
    `);
    console.table(sisterCommunities);

    // 4. Test specific case: User with community scope viewing sisters
    console.log("\n4. Test case cụ thể:");
    const testUserId = assignments.length > 0 ? assignments[0].user_id : null;

    if (testUserId) {
      const [testUser] = await db.query("SELECT * FROM users WHERE id = ?", [
        testUserId,
      ]);
      const [userComms] = await db.query(
        "SELECT community_id FROM user_communities WHERE user_id = ?",
        [testUserId]
      );

      console.log(`\nUser: ${testUser[0].username} (ID: ${testUserId})`);
      console.log(`Data scope: ${testUser[0].data_scope}`);
      console.log(
        `Assigned communities: [${userComms
          .map((c) => c.community_id)
          .join(", ")}]`
      );

      if (testUser[0].data_scope === "community" && userComms.length > 0) {
        const commIds = userComms.map((c) => c.community_id);

        // Count total sisters
        const [totalCount] = await db.query(
          "SELECT COUNT(*) as total FROM sisters"
        );
        console.log(`\nTổng số nữ tu trong DB: ${totalCount[0].total}`);

        // Count sisters in user's communities (via current_community_id)
        const [currentCommCount] = await db.query(
          `SELECT COUNT(*) as total FROM sisters 
           WHERE current_community_id IN (${commIds.join(",")})`,
          []
        );
        console.log(
          `Nữ tu có current_community_id trong [${commIds.join(", ")}]: ${
            currentCommCount[0].total
          }`
        );

        // Count sisters in user's communities (via community_assignments)
        const [assignedCommCount] = await db.query(
          `SELECT COUNT(DISTINCT s.id) as total 
           FROM sisters s
           INNER JOIN community_assignments ca ON s.id = ca.sister_id
           WHERE ca.community_id IN (${commIds.join(",")})
             AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())`,
          []
        );
        console.log(
          `Nữ tu được gán vào cộng đoàn [${commIds.join(", ")}]: ${
            assignedCommCount[0].total
          }`
        );

        console.log("\n⚠️ NẾU API VẪN TRẢ VỀ TẤT CẢ NỮ TU:");
        console.log(
          "   - Kiểm tra attachDataScope middleware có được gọi không"
        );
        console.log("   - Kiểm tra applyScopeFilter trong controller");
        console.log("   - Xem log request trong console khi gọi API");
      }
    }

    process.exit(0);
  } catch (err) {
    console.error("❌ Error:", err.message);
    process.exit(1);
  }
})();
