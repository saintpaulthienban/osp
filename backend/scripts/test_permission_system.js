// Test script for permission system
const db = require("../src/config/database");

async function testPermissionSystem() {
  try {
    console.log("🧪 BẮT ĐẦU TEST HỆ THỐNG PHÂN QUYỀN\n");

    // 1. Check permissions
    console.log("📋 1. KIỂM TRA PERMISSIONS");
    const [permissions] = await db.query(
      "SELECT COUNT(*) as total FROM permissions"
    );
    console.log(`   ✓ Tổng số permissions: ${permissions[0].total}`);

    const [modules] = await db.query(
      "SELECT DISTINCT module, COUNT(*) as count FROM permissions GROUP BY module ORDER BY module"
    );
    console.log("   📦 Permissions theo module:");
    modules.forEach((m) =>
      console.log(`      - ${m.module}: ${m.count} quyền`)
    );

    // 2. Check users table structure
    console.log("\n👥 2. KIỂM TRA CẤU TRÚC BẢNG USERS");
    const [columns] = await db.query(`
      SELECT COLUMN_NAME, DATA_TYPE, COLUMN_DEFAULT
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_NAME = 'users' 
      AND COLUMN_NAME IN ('is_admin', 'is_super_admin', 'data_scope')
      ORDER BY ORDINAL_POSITION
    `);
    columns.forEach((col) => {
      console.log(
        `   ✓ ${col.COLUMN_NAME}: ${col.DATA_TYPE} (default: ${
          col.COLUMN_DEFAULT || "none"
        })`
      );
    });

    // 3. Check admin user
    console.log("\n🔐 3. KIỂM TRA ADMIN USER");
    const [admins] = await db.query(`
      SELECT id, username, is_admin, is_super_admin, data_scope
      FROM users
      WHERE is_admin = 1
    `);
    if (admins.length > 0) {
      console.log("   ✓ Admin users:");
      admins.forEach((admin) => {
        console.log(
          `      - ${admin.username}: super_admin=${admin.is_super_admin}, scope=${admin.data_scope}`
        );
      });
    } else {
      console.log("   ❌ Không tìm thấy admin user!");
    }

    // 4. Check admin permissions
    console.log("\n🔑 4. KIỂM TRA QUYỀN CỦA ADMIN");
    if (admins.length > 0) {
      const adminId = admins[0].id;
      const [adminPerms] = await db.query(
        `
        SELECT COUNT(*) as total
        FROM user_permissions
        WHERE user_id = ?
      `,
        [adminId]
      );
      console.log(`   ✓ Admin có ${adminPerms[0].total} quyền`);

      // Check if has all permissions
      const [allPerms] = await db.query(
        "SELECT COUNT(*) as total FROM permissions"
      );
      if (adminPerms[0].total === allPerms[0].total) {
        console.log("   ✓ Admin có TẤT CẢ các quyền");
      } else {
        console.log(
          `   ⚠️  Admin chưa có đủ quyền (có ${adminPerms[0].total}/${allPerms[0].total})`
        );
      }
    }

    // 5. Check user_communities table
    console.log("\n🏘️  5. KIỂM TRA BẢNG USER_COMMUNITIES");
    const [ucTables] = await db.query("SHOW TABLES LIKE 'user_communities'");
    if (ucTables.length > 0) {
      console.log("   ✓ Bảng user_communities tồn tại");
      const [ucCount] = await db.query(
        "SELECT COUNT(*) as total FROM user_communities"
      );
      console.log(`   ✓ Số lượng assignments: ${ucCount[0].total}`);
    } else {
      console.log("   ❌ Bảng user_communities chưa tồn tại!");
    }

    // 6. Test sample permission check
    console.log("\n🧪 6. TEST PERMISSION CHECK MẪU");
    if (admins.length > 0) {
      const adminId = admins[0].id;

      // Check specific permission
      const [hasPerm] = await db.query(
        `
        SELECT p.name
        FROM permissions p
        INNER JOIN user_permissions up ON up.permission_id = p.id
        WHERE up.user_id = ? AND p.name = 'sisters.view_list'
      `,
        [adminId]
      );

      if (hasPerm.length > 0) {
        console.log('   ✓ Admin có quyền "sisters.view_list"');
      } else {
        console.log('   ❌ Admin KHÔNG có quyền "sisters.view_list"');
      }
    }

    // 7. Summary
    console.log("\n📊 TÓM TẮT:");
    console.log(`   Permissions: ${permissions[0].total}`);
    console.log(`   Modules: ${modules.length}`);
    console.log(`   Admin users: ${admins.length}`);
    console.log(
      `   User communities table: ${ucTables.length > 0 ? "Có" : "Không"}`
    );

    console.log("\n✅ HOÀN THÀNH TEST!\n");

    process.exit(0);
  } catch (error) {
    console.error("\n❌ LỖI:", error.message);
    console.error(error);
    process.exit(1);
  }
}

testPermissionSystem();
