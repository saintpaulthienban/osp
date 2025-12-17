// Script to run migration
const mysql = require("mysql2/promise");
const fs = require("fs");
const path = require("path");
require("dotenv").config();

async function runMigration() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
    multipleStatements: true,
  });

  try {
    console.log("📦 Reading migration file...");
    const migrationSQL = fs.readFileSync(
      path.join(__dirname, "../db/migrations/add_permission_system.sql"),
      "utf8"
    );

    console.log("🚀 Running migration...");
    await connection.query(migrationSQL);

    console.log("✅ Migration completed successfully!");
  } catch (error) {
    console.error("❌ Migration failed:", error.message);
    throw error;
  } finally {
    await connection.end();
  }
}

runMigration();
