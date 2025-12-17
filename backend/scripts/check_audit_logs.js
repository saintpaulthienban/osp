// backend/scripts/check_audit_logs.js
const mysql = require("mysql2/promise");
require("dotenv").config();

(async () => {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  // Check if audit_logs exists
  const [tables] = await conn.execute("SHOW TABLES LIKE 'audit_logs'");
  console.log("audit_logs exists:", tables.length > 0);

  if (tables.length === 0) {
    // Create audit_logs table
    console.log("Creating audit_logs table...");
    await conn.execute(`
      CREATE TABLE audit_logs (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT,
        action VARCHAR(255) NOT NULL,
        table_name VARCHAR(100),
        record_id INT,
        old_values JSON,
        new_values JSON,
        ip_address VARCHAR(45),
        user_agent TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
      )
    `);
    console.log("✓ audit_logs table created");

    // Insert some sample data
    await conn.execute(`
      INSERT INTO audit_logs (user_id, action, table_name, record_id, created_at) VALUES
      (1, 'Đăng nhập hệ thống', 'users', 1, NOW() - INTERVAL 1 HOUR),
      (1, 'Tạo mới bài đăng', 'posts', 1, NOW() - INTERVAL 2 HOUR),
      (1, 'Cập nhật thông tin nữ tu', 'sisters', 1, NOW() - INTERVAL 3 HOUR),
      (1, 'Tạo mới cộng đoàn', 'communities', 1, NOW() - INTERVAL 4 HOUR),
      (1, 'Xóa bài đăng', 'posts', 2, NOW() - INTERVAL 5 HOUR)
    `);
    console.log("✓ Sample audit logs inserted");
  }

  // Check total records
  const [count] = await conn.execute(
    "SELECT COUNT(*) as total FROM audit_logs"
  );
  console.log("Total audit logs:", count[0].total);

  await conn.end();
  process.exit(0);
})();
