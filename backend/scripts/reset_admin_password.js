const mysql = require("mysql2/promise");
const bcrypt = require("bcryptjs");
const path = require("path");
const dotenv = require("dotenv");

dotenv.config({ path: path.resolve(__dirname, "../.env") });

const { DB_HOST, DB_PORT, DB_USER, DB_PASSWORD, DB_NAME } = process.env;

async function main() {
  const config = {
    host: DB_HOST,
    port: Number(DB_PORT) || 3306,
    user: DB_USER,
    password: DB_PASSWORD,
    database: DB_NAME,
  };

  try {
    const connection = await mysql.createConnection(config);
    console.log("Connected to MySQL server.");

    const newPassword = "123456";
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Update admin password
    const [result] = await connection.execute(
      "UPDATE users SET password = ? WHERE username = 'admin'",
      [hashedPassword]
    );

    if (result.affectedRows > 0) {
      console.log(`✅ Đã reset mật khẩu admin thành: ${newPassword}`);
    } else {
      console.log("⚠️ Không tìm thấy user admin trong database");
    }

    await connection.end();
  } catch (err) {
    console.error("❌ Lỗi khi reset mật khẩu admin:", err);
    process.exit(1);
  }
}

main();
