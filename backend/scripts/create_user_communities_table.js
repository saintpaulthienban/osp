// Create user_communities table
const db = require("../src/config/database");

async function createUserCommunitiesTable() {
  try {
    console.log("🚀 Tạo bảng user_communities...\n");

    // Create table
    await db.query(`
      CREATE TABLE IF NOT EXISTS user_communities (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        community_id INT UNSIGNED NOT NULL,
        is_primary TINYINT(1) DEFAULT 0 COMMENT 'Đánh dấu cộng đoàn chính',
        granted_by INT UNSIGNED NULL COMMENT 'ID admin gán',
        granted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
        
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
        FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE CASCADE,
        FOREIGN KEY (granted_by) REFERENCES users(id) ON DELETE SET NULL,
        
        UNIQUE KEY unique_user_community (user_id, community_id),
        INDEX idx_user_id (user_id),
        INDEX idx_community_id (community_id)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      COMMENT='Gán user vào cộng đoàn - xác định phạm vi dữ liệu'
    `);

    console.log("✅ Đã tạo bảng user_communities thành công!");

    // Show table structure
    const [columns] = await db.query(`
      SELECT COLUMN_NAME, DATA_TYPE, COLUMN_KEY
      FROM INFORMATION_SCHEMA.COLUMNS
      WHERE TABLE_NAME = 'user_communities'
      ORDER BY ORDINAL_POSITION
    `);

    console.log("\n📋 Cấu trúc bảng:");
    columns.forEach((col) => {
      console.log(
        `   - ${col.COLUMN_NAME}: ${col.DATA_TYPE} ${
          col.COLUMN_KEY ? `(${col.COLUMN_KEY})` : ""
        }`
      );
    });

    console.log("\n✅ Hoàn thành!\n");

    process.exit(0);
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
    console.error(error);
    process.exit(1);
  }
}

createUserCommunitiesTable();
