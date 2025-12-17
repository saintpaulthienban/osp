// Check permissions table structure
const mysql = require("mysql2/promise");
require("dotenv").config();

async function checkTable() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  try {
    const [columns] = await connection.query("DESCRIBE permissions");
    console.log("📋 Permissions table structure:");
    console.table(columns);

    const [data] = await connection.query("SELECT * FROM permissions LIMIT 5");
    console.log("\n📦 Sample data:");
    console.table(data);
  } catch (error) {
    console.error("❌ Error:", error.message);
  } finally {
    await connection.end();
  }
}

checkTable();
