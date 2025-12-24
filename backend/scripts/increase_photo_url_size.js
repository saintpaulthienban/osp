require("dotenv").config({
  path: require("path").resolve(__dirname, "../.env"),
});
const pool = require("../src/config/database");
const fs = require("fs");
const path = require("path");

async function increasePhotoUrlSize() {
  let connection;

  try {
    connection = await pool.getConnection();

    console.log("🔧 Starting photo_url column size increase...");

    // Read migration file
    const migrationPath = path.join(
      __dirname,
      "../db/migrations/increase_photo_url_size.sql"
    );
    const migrationSQL = fs.readFileSync(migrationPath, "utf8");

    // Execute migration
    await connection.query(migrationSQL);

    console.log(
      "✅ Successfully increased photo_url column size to VARCHAR(1000)"
    );

    // Verify the change
    const [columns] = await connection.query(`
      SELECT COLUMN_NAME, COLUMN_TYPE, CHARACTER_MAXIMUM_LENGTH 
      FROM INFORMATION_SCHEMA.COLUMNS 
      WHERE TABLE_NAME = 'sisters' 
      AND COLUMN_NAME = 'photo_url'
    `);

    console.log("📊 Updated column info:", columns[0]);
  } catch (error) {
    console.error("❌ Error increasing photo_url size:", error);
    throw error;
  } finally {
    if (connection) connection.release();
    process.exit(0);
  }
}

increasePhotoUrlSize();
