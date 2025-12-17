// Script tạo bảng system_settings và user_preferences
const mysql = require("mysql2/promise");
require("dotenv").config();

const createTables = async () => {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  try {
    console.log("🔄 Đang tạo bảng system_settings...");

    // Tạo bảng system_settings - lưu cài đặt hệ thống
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS system_settings (
        id INT AUTO_INCREMENT PRIMARY KEY,
        setting_key VARCHAR(100) NOT NULL UNIQUE,
        setting_value TEXT,
        setting_group VARCHAR(50) DEFAULT 'general',
        description VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX idx_setting_key (setting_key),
        INDEX idx_setting_group (setting_group)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    console.log("✅ Đã tạo bảng system_settings");

    // Tạo bảng user_preferences - lưu tùy chọn cá nhân
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS user_preferences (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id INT NOT NULL,
        preference_key VARCHAR(100) NOT NULL,
        preference_value TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        UNIQUE KEY unique_user_preference (user_id, preference_key),
        INDEX idx_user_id (user_id)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    console.log("✅ Đã tạo bảng user_preferences");

    // Tạo bảng backups - lưu thông tin backup
    await connection.execute(`
      CREATE TABLE IF NOT EXISTS backups (
        id INT AUTO_INCREMENT PRIMARY KEY,
        filename VARCHAR(255) NOT NULL,
        file_path VARCHAR(500) NOT NULL,
        file_size BIGINT DEFAULT 0,
        backup_type ENUM('manual', 'auto') DEFAULT 'manual',
        status ENUM('completed', 'failed', 'in_progress') DEFAULT 'completed',
        created_by INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        notes TEXT,
        INDEX idx_created_at (created_at)
      ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    `);
    console.log("✅ Đã tạo bảng backups");

    // Insert default settings
    console.log("🔄 Đang thêm cài đặt mặc định...");

    const defaultSettings = [
      // General settings
      ["siteName", "Hệ Thống Quản Lý Hội Dòng OSP", "general", "Tên hệ thống"],
      [
        "siteDescription",
        "Quản lý thông tin nữ tu và hoạt động của Hội Dòng",
        "general",
        "Mô tả hệ thống",
      ],
      ["timezone", "Asia/Ho_Chi_Minh", "general", "Múi giờ"],
      ["dateFormat", "DD/MM/YYYY", "general", "Định dạng ngày"],
      ["language", "vi", "general", "Ngôn ngữ"],
      ["congregationName", "Dòng Nữ Tu OSP", "general", "Tên Hội Dòng"],
      ["foundingDate", "", "general", "Ngày thành lập"],
      ["mainAddress", "", "general", "Địa chỉ chính"],
      ["phone", "", "general", "Số điện thoại"],
      ["email", "", "general", "Email"],
      ["website", "", "general", "Website"],

      // Email settings (system)
      ["smtpHost", "", "system", "SMTP Host"],
      ["smtpPort", "587", "system", "SMTP Port"],
      ["smtpUser", "", "system", "SMTP User"],
      ["smtpPassword", "", "system", "SMTP Password"],
      ["smtpSecure", "tls", "system", "SMTP Secure"],
      [
        "emailFromName",
        "Hệ Thống Quản Lý Hội Dòng",
        "system",
        "Email From Name",
      ],
      ["emailFromAddress", "", "system", "Email From Address"],

      // Security settings (system)
      ["sessionTimeout", "60", "system", "Session timeout (phút)"],
      ["minPasswordLength", "8", "system", "Độ dài tối thiểu mật khẩu"],
      ["requireStrongPassword", "true", "system", "Yêu cầu mật khẩu mạnh"],
      ["maxLoginAttempts", "5", "system", "Số lần đăng nhập tối đa"],
      ["lockoutDuration", "30", "system", "Thời gian khóa (phút)"],
      ["enableTwoFactor", "false", "system", "Bật xác thực 2 yếu tố"],

      // Cache settings (system)
      ["enableCache", "true", "system", "Bật cache"],
      ["cacheExpiry", "3600", "system", "Thời gian cache (giây)"],
    ];

    for (const [key, value, group, description] of defaultSettings) {
      await connection.execute(
        `INSERT INTO system_settings (setting_key, setting_value, setting_group, description)
         VALUES (?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)`,
        [key, value, group, description]
      );
    }
    console.log("✅ Đã thêm cài đặt mặc định");

    // Verify
    const [rows] = await connection.execute(
      "SELECT COUNT(*) as count FROM system_settings"
    );
    console.log(`✅ Tổng số cài đặt: ${rows[0].count}`);

    console.log("\n🎉 Hoàn tất tạo bảng settings!");
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
  } finally {
    await connection.end();
  }
};

createTables();
