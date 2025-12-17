const db = require("../config/database");
const bcrypt = require("bcryptjs");

(async () => {
  try {
    console.log("=== TẠO USER TEST VỚI COMMUNITY SCOPE ===\n");

    // 1. Get a community to assign
    const [communities] = await db.query(
      "SELECT id, name FROM communities ORDER BY id LIMIT 5"
    );

    if (communities.length === 0) {
      console.error("❌ Không có cộng đoàn nào trong database");
      process.exit(1);
    }

    console.log("Các cộng đoàn có sẵn:");
    console.table(communities);

    const testCommunityId = communities[0].id; // Chọn cộng đoàn đầu tiên
    const testCommunityName = communities[0].name;

    // 2. Check if test user already exists
    const [existingUsers] = await db.query(
      "SELECT id FROM users WHERE username = ?",
      ["test_community_user"]
    );

    let userId;

    if (existingUsers.length > 0) {
      console.log("\n⚠️ User 'test_community_user' đã tồn tại");
      userId = existingUsers[0].id;

      // Update existing user
      await db.query(
        `UPDATE users 
         SET data_scope = 'community', 
             is_super_admin = 0, 
             is_admin = 0,
             password = ?
         WHERE id = ?`,
        [bcrypt.hashSync("123456", 10), userId]
      );
      console.log("✅ Đã cập nhật user với data_scope='community'");
    } else {
      // Create new user
      const hashedPassword = bcrypt.hashSync("123456", 10);

      const [result] = await db.query(
        `INSERT INTO users (username, email, password, full_name, data_scope, is_admin, is_super_admin, is_active)
         VALUES (?, ?, ?, ?, 'community', 0, 0, 1)`,
        [
          "test_community_user",
          "test_community@example.com",
          hashedPassword,
          "Test Community User",
        ]
      );

      userId = result.insertId;
      console.log(`\n✅ Đã tạo user mới với ID: ${userId}`);
    }

    // 3. Clear existing community assignments for this user
    await db.query("DELETE FROM user_communities WHERE user_id = ?", [userId]);

    // 4. Get an admin user for granted_by
    const [adminUsers] = await db.query(
      "SELECT id FROM users WHERE is_admin = 1 LIMIT 1"
    );
    const grantedBy = adminUsers.length > 0 ? adminUsers[0].id : userId;

    // 5. Assign user to test community
    await db.query(
      `INSERT INTO user_communities (user_id, community_id, granted_by)
       VALUES (?, ?, ?)`,
      [userId, testCommunityId, grantedBy]
    );

    console.log(
      `✅ Đã gán user vào cộng đoàn: ${testCommunityName} (ID: ${testCommunityId})`
    );

    // 6. Count sisters in this community
    const [sisterCount] = await db.query(
      `SELECT COUNT(*) as total 
       FROM sisters 
       WHERE current_community_id = ?`,
      [testCommunityId]
    );

    const [assignedSisterCount] = await db.query(
      `SELECT COUNT(DISTINCT s.id) as total 
       FROM sisters s
       INNER JOIN community_assignments ca ON s.id = ca.sister_id
       WHERE ca.community_id = ?
         AND (ca.end_date IS NULL OR ca.end_date >= CURDATE())`,
      [testCommunityId]
    );

    console.log(
      `\nSố nữ tu có current_community_id = ${testCommunityId}: ${sisterCount[0].total}`
    );
    console.log(
      `Số nữ tu được gán vào cộng đoàn ${testCommunityId}: ${assignedSisterCount[0].total}`
    );

    // 7. Show final user info
    const [finalUser] = await db.query(
      `SELECT u.id, u.username, u.full_name, u.email, u.data_scope, u.is_admin, u.is_super_admin,
              GROUP_CONCAT(c.name SEPARATOR ', ') as communities
       FROM users u
       LEFT JOIN user_communities uc ON u.id = uc.user_id
       LEFT JOIN communities c ON uc.community_id = c.id
       WHERE u.id = ?
       GROUP BY u.id`,
      [userId]
    );

    console.log("\n=== THÔNG TIN USER TEST ===");
    console.table(finalUser);

    console.log("\n=== HƯỚNG DẪN TEST ===");
    console.log("1. Login vào ứng dụng với:");
    console.log("   Username: test_community_user");
    console.log("   Password: 123456");
    console.log(
      `2. Vào trang Nữ tu, bạn chỉ nên thấy ${sisterCount[0].total} nữ tu của cộng đoàn "${testCommunityName}"`
    );
    console.log("3. Kiểm tra logs trong terminal backend để xem scope filter");

    process.exit(0);
  } catch (err) {
    console.error("❌ Error:", err.message);
    console.error(err.stack);
    process.exit(1);
  }
})();
