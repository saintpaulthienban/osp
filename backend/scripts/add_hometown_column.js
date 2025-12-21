// Add hometown (quê quán) column to sisters table
const mysql = require("mysql2/promise");

async function addHometownColumn() {
  let connection;
  try {
    connection = await mysql.createConnection({
      host: "localhost",
      user: "root",
      password: "",
      database: "hr_records"
    });
    console.log("✅ Connected to database");

    // Check if column exists
    const [columns] = await connection.query(`
      SELECT COLUMN_NAME 
      FROM INFORMATION_SCHEMA.COLUMNS 
      WHERE TABLE_SCHEMA = 'hr_records' 
        AND TABLE_NAME = 'sisters' 
        AND COLUMN_NAME = 'hometown'
    `);

    if (columns.length > 0) {
      console.log("ℹ️  Column 'hometown' already exists");
      return;
    }

    // Add hometown column after place_of_birth
    await connection.query(`
      ALTER TABLE sisters 
      ADD COLUMN hometown VARCHAR(150) NULL 
      AFTER place_of_birth
    `);

    console.log("✅ Added 'hometown' column to sisters table");
    console.log("📍 Position: after 'place_of_birth'");
    console.log("📝 Type: VARCHAR(150) NULL");

  } catch (error) {
    console.error("❌ Error:", error.message);
    throw error;
  } finally {
    if (connection) {
      await connection.end();
      console.log("🔌 Disconnected");
    }
  }
}

addHometownColumn();
