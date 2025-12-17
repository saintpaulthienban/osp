// Script to add data_scope and is_super_admin to users table
const db = require("../src/config/database");

async function addUserScopeFields() {
  try {
    console.log("🚀 Bắt đầu cập nhật bảng users...");

    // Add data_scope column
    console.log("📋 Thêm cột data_scope...");
    await db.query(`
      ALTER TABLE users 
      ADD COLUMN IF NOT EXISTS data_scope ENUM('all', 'community', 'own') 
      DEFAULT 'community' 
      COMMENT 'Data access scope: all=see all, community=assigned communities only, own=own data only'
    `);

    // Add is_super_admin column
    console.log("📋 Thêm cột is_super_admin...");
    await db.query(`
      ALTER TABLE users 
      ADD COLUMN IF NOT EXISTS is_super_admin TINYINT(1) 
      DEFAULT 0 
      COMMENT 'Super admin bypasses all permission checks'
    `);

    // Add indexes
    console.log("🔍 Tạo indexes...");
    await db.query(
      `ALTER TABLE users ADD INDEX IF NOT EXISTS idx_data_scope (data_scope)`
    );
    await db.query(
      `ALTER TABLE users ADD INDEX IF NOT EXISTS idx_super_admin (is_super_admin)`
    );

    // Update existing admin users
    console.log("🔧 Cập nhật admin users...");
    await db.query(`UPDATE users SET data_scope = 'all' WHERE is_admin = 1`);

    // Set main admin as super admin
    await db.query(`
      UPDATE users 
      SET is_super_admin = 1 
      WHERE username = 'admin' AND is_admin = 1
    `);

    // Show updated users
    const [users] = await db.query(`
      SELECT id, username, is_admin, is_super_admin, data_scope 
      FROM users 
      ORDER BY is_admin DESC, id
    `);

    console.log("\n✅ Cập nhật thành công!");
    console.log("\n👥 Danh sách users:");
    console.table(users);

    process.exit(0);
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
    console.error(error);
    process.exit(1);
  }
}

addUserScopeFields();
