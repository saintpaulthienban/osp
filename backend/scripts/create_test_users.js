/**
 * Script tạo test users với các data_scope khác nhau
 * Chạy: node scripts/create_test_users.js
 */

const db = require("../src/config/database");
const crypto = require("crypto");

// Simple hash function (trong production nên dùng bcrypt)
function hashPassword(password) {
  return crypto.createHash("sha256").update(password).digest("hex");
}

async function createTestUsers() {
  console.log("\n=== TẠO TEST USERS ===\n");

  try {
    const hashedPassword = hashPassword("test123");

    // 1. User với data_scope='all' (không phải super admin)
    console.log("1. Tạo user: viewer_all (data_scope='all')...");
    const [result1] = await db.query(
      `INSERT INTO users (username, password, email, is_admin, is_super_admin, data_scope, created_at)
       VALUES (?, ?, ?, 0, 0, 'all', NOW())
       ON DUPLICATE KEY UPDATE 
       password = VALUES(password),
       data_scope = VALUES(data_scope),
       is_admin = 0,
       is_super_admin = 0`,
      ["viewer_all", hashedPassword, "viewer_all@test.com"]
    );
    const viewerAllId =
      result1.insertId ||
      (
        await db.query("SELECT id FROM users WHERE username = 'viewer_all'")
      )[0][0].id;

    // Assign một số permissions cho viewer_all
    const viewPermissions = [
      "sisters.view_list",
      "sisters.view_detail",
      "communities.view_list",
      "communities.view_detail",
      "missions.view_list",
      "education.view_list",
      "health.view_basic",
    ];

    for (const permName of viewPermissions) {
      const [perm] = await db.query(
        "SELECT id FROM permissions WHERE name = ?",
        [permName]
      );
      if (perm.length > 0) {
        await db.query(
          `INSERT IGNORE INTO user_permissions (user_id, permission_id, granted_by)
           VALUES (?, ?, 1)`,
          [viewerAllId, perm[0].id]
        );
      }
    }
    console.log(`   ✓ Created/Updated user: viewer_all (ID: ${viewerAllId})`);
    console.log(`   ✓ Assigned ${viewPermissions.length} view permissions`);
    console.log();

    // 2. User với data_scope='community'
    console.log("2. Tạo user: editor_community (data_scope='community')...");
    const [result2] = await db.query(
      `INSERT INTO users (username, password, email, is_admin, is_super_admin, data_scope, created_at)
       VALUES (?, ?, ?, 0, 0, 'community', NOW())
       ON DUPLICATE KEY UPDATE 
       password = VALUES(password),
       data_scope = VALUES(data_scope),
       is_admin = 0,
       is_super_admin = 0`,
      ["editor_community", hashedPassword, "editor_community@test.com"]
    );
    const editorCommunityId =
      result2.insertId ||
      (
        await db.query(
          "SELECT id FROM users WHERE username = 'editor_community'"
        )
      )[0][0].id;

    // Assign nhiều permissions hơn cho editor
    const editorPermissions = [
      "sisters.view_list",
      "sisters.view_detail",
      "sisters.update_basic",
      "communities.view_list",
      "communities.view_detail",
      "communities.update",
      "missions.view_list",
      "missions.create",
      "missions.update",
      "education.view_list",
      "education.create",
      "education.update",
      "health.view_basic",
      "health.create",
    ];

    for (const permName of editorPermissions) {
      const [perm] = await db.query(
        "SELECT id FROM permissions WHERE name = ?",
        [permName]
      );
      if (perm.length > 0) {
        await db.query(
          `INSERT IGNORE INTO user_permissions (user_id, permission_id, granted_by)
           VALUES (?, ?, 1)`,
          [editorCommunityId, perm[0].id]
        );
      }
    }
    console.log(
      `   ✓ Created/Updated user: editor_community (ID: ${editorCommunityId})`
    );
    console.log(`   ✓ Assigned ${editorPermissions.length} permissions`);

    // Gán 2-3 communities cho user này
    const [communities] = await db.query("SELECT id FROM communities LIMIT 3");
    if (communities.length > 0) {
      for (const comm of communities) {
        await db.query(
          `INSERT IGNORE INTO user_communities (user_id, community_id, is_primary, granted_by)
           VALUES (?, ?, ?, 1)`,
          [editorCommunityId, comm.id, comm.id === communities[0].id ? 1 : 0]
        );
      }
      console.log(`   ✓ Assigned ${communities.length} communities`);
    }
    console.log();

    // 3. User với data_scope='own'
    console.log("3. Tạo user: limited_own (data_scope='own')...");
    const [result3] = await db.query(
      `INSERT INTO users (username, password, email, is_admin, is_super_admin, data_scope, created_at)
       VALUES (?, ?, ?, 0, 0, 'own', NOW())
       ON DUPLICATE KEY UPDATE 
       password = VALUES(password),
       data_scope = VALUES(data_scope),
       is_admin = 0,
       is_super_admin = 0`,
      ["limited_own", hashedPassword, "limited_own@test.com"]
    );
    const limitedOwnId =
      result3.insertId ||
      (
        await db.query("SELECT id FROM users WHERE username = 'limited_own'")
      )[0][0].id;

    // Assign chỉ view permissions
    const ownPermissions = [
      "sisters.view_list",
      "communities.view_list",
      "missions.view_list",
    ];

    for (const permName of ownPermissions) {
      const [perm] = await db.query(
        "SELECT id FROM permissions WHERE name = ?",
        [permName]
      );
      if (perm.length > 0) {
        await db.query(
          `INSERT IGNORE INTO user_permissions (user_id, permission_id, granted_by)
           VALUES (?, ?, 1)`,
          [limitedOwnId, perm[0].id]
        );
      }
    }
    console.log(`   ✓ Created/Updated user: limited_own (ID: ${limitedOwnId})`);
    console.log(`   ✓ Assigned ${ownPermissions.length} limited permissions`);
    console.log();

    // Tổng kết
    console.log("=== TỔNG KẾT ===");
    console.log("✅ Đã tạo 3 test users:");
    console.log("   1. viewer_all / test123");
    console.log("      - data_scope: 'all' (xem tất cả)");
    console.log("      - Chỉ có quyền xem, không sửa");
    console.log();
    console.log("   2. editor_community / test123");
    console.log(
      "      - data_scope: 'community' (chỉ xem communities được gán)"
    );
    console.log("      - Có quyền xem và sửa");
    console.log("      - Đã gán 3 communities");
    console.log();
    console.log("   3. limited_own / test123");
    console.log("      - data_scope: 'own' (chỉ xem data của chính mình)");
    console.log("      - Rất hạn chế");
    console.log();
    console.log("📝 Để test:");
    console.log("   POST /api/auth/login với username/password trên");
    console.log("   Dùng token để gọi các API và xem kết quả khác nhau");
    console.log();
  } catch (error) {
    console.error("❌ LỖI:", error.message);
    throw error;
  } finally {
    await db.end();
  }
}

createTestUsers().catch((err) => {
  console.error("Fatal error:", err);
  process.exit(1);
});
