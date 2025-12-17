// scripts/create_notifications_table.js
const mysql = require("mysql2/promise");
require("dotenv").config();

const createTable = async () => {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  try {
    console.log("🔄 Đang tạo bảng notifications...");

    // Tạo bảng notifications
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS notifications (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        type ENUM('info', 'warning', 'success', 'error', 'birthday', 'anniversary', 'reminder') DEFAULT 'info',
        title VARCHAR(255) NOT NULL,
        message TEXT,
        link VARCHAR(500),
        is_read TINYINT(1) DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        read_at TIMESTAMP NULL,
        INDEX idx_user_id (user_id),
        INDEX idx_is_read (is_read),
        INDEX idx_created_at (created_at)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    console.log("✅ Đã tạo bảng notifications");

    // Insert sample notifications cho admin (user_id = 1)
    console.log("🔄 Đang thêm thông báo mẫu...");

    const sampleNotifications = [
      [
        1,
        "info",
        "Chào mừng!",
        "Chào mừng bạn đến với hệ thống quản lý Hội Dòng OSP",
        "/dashboard",
        0,
      ],
      [
        1,
        "warning",
        "Nhắc nhở",
        "Có 3 hồ sơ nữ tu cần được cập nhật thông tin",
        "/nu-tu",
        0,
      ],
      [
        1,
        "success",
        "Báo cáo hoàn thành",
        "Báo cáo thống kê tháng 12 đã được tạo thành công",
        "/bao-cao",
        0,
      ],
      [
        1,
        "birthday",
        "Sinh nhật",
        "Hôm nay là sinh nhật của Sr. Maria Nguyễn",
        "/nu-tu/1",
        0,
      ],
      [
        1,
        "reminder",
        "Đánh giá định kỳ",
        "5 nữ tu cần được đánh giá trong tháng này",
        "/danh-gia",
        0,
      ],
    ];

    for (const notification of sampleNotifications) {
      await connection.execute(
        `INSERT INTO notifications (user_id, type, title, message, link, is_read)
         VALUES (?, ?, ?, ?, ?, ?)`,
        notification
      );
    }
    console.log("✅ Đã thêm 5 thông báo mẫu");

    // Verify
    const [rows] = await connection.execute(
      "SELECT COUNT(*) as count FROM notifications"
    );
    console.log(`✅ Tổng số thông báo: ${rows[0].count}`);

    console.log("\n🎉 Hoàn tất tạo bảng notifications!");
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
  } finally {
    await connection.end();
  }
};

createTable();
