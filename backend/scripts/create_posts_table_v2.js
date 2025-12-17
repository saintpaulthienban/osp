// Create posts table - Direct execution
const db = require("../src/config/database");

async function run() {
  try {
    console.log("Creating posts table...");

    // Create table
    await db.query(`
      CREATE TABLE IF NOT EXISTS posts (
        id INT AUTO_INCREMENT PRIMARY KEY,
        title VARCHAR(200) NOT NULL,
        category ENUM('thong-bao', 'su-kien', 'huong-dan', 'chia-se', 'khac') NOT NULL DEFAULT 'thong-bao',
        summary TEXT,
        content LONGTEXT NOT NULL,
        is_pinned TINYINT(1) DEFAULT 0,
        is_important TINYINT(1) DEFAULT 0,
        tags JSON,
        attachments JSON,
        author_id INT,
        view_count INT DEFAULT 0,
        status ENUM('draft', 'published') DEFAULT 'published',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        deleted_at TIMESTAMP NULL,
        INDEX idx_category (category),
        INDEX idx_is_pinned (is_pinned),
        INDEX idx_is_important (is_important),
        INDEX idx_created_at (created_at),
        INDEX idx_deleted_at (deleted_at)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    console.log("✓ Table created");

    // Insert sample data
    const [existing] = await db.query("SELECT COUNT(*) as count FROM posts");
    if (existing[0].count === 0) {
      await db.query(`
        INSERT INTO posts (title, category, summary, content, is_pinned, is_important, tags, author_id, view_count) VALUES
        ('Thông báo quan trọng về lịch sinh hoạt tháng 12/2024', 'thong-bao', 
         'Kính gửi quý chị em trong Hội Dòng, Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024.', 
         '<p>Kính gửi quý chị em trong Hội Dòng,</p><p>Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024.</p>', 
         1, 1, '["thông báo", "lịch sinh hoạt"]', 1, 245),
        ('Mừng lễ Giáng sinh 2024', 'su-kien', 
         'Chương trình mừng lễ Giáng sinh sẽ được tổ chức vào ngày 24/12.', 
         '<p>Chương trình mừng lễ Giáng sinh 2024 sẽ được tổ chức vào ngày 24/12.</p>', 
         0, 0, '["giáng sinh", "sự kiện"]', 1, 189),
        ('Hướng dẫn sử dụng hệ thống mới', 'huong-dan', 
         'Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới trong hệ thống quản lý.', 
         '<p>Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới.</p>', 
         0, 0, '["hướng dẫn", "hệ thống"]', 1, 156)
      `);
      console.log("✓ Sample data inserted");
    } else {
      console.log("⚠ Sample data already exists");
    }

    console.log("\n✅ Done!");
    process.exit(0);
  } catch (error) {
    console.error("❌ Error:", error.message);
    process.exit(1);
  }
}

run();
