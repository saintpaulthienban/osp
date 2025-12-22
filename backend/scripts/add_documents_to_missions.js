// Script to add documents column to missions table
const pool = require("../src/config/database");

async function addDocumentsColumn() {
  let connection;
  try {
    connection = await pool.getConnection();

    console.log("Checking if documents column exists in missions table...");

    // Check if column exists
    const [columns] = await connection.query(
      `SELECT COLUMN_NAME 
       FROM INFORMATION_SCHEMA.COLUMNS 
       WHERE TABLE_SCHEMA = DATABASE() 
       AND TABLE_NAME = 'missions' 
       AND COLUMN_NAME = 'documents'`
    );

    if (columns.length > 0) {
      console.log("Column 'documents' already exists in missions table.");
      return;
    }

    console.log("Adding 'documents' column to missions table...");

    // Add documents column (JSON type to store array of document objects)
    await connection.query(`
      ALTER TABLE missions 
      ADD COLUMN documents JSON NULL 
      COMMENT 'JSON array of attached documents'
    `);

    console.log("✅ Successfully added 'documents' column to missions table!");
  } catch (error) {
    console.error("❌ Error:", error.message);
    throw error;
  } finally {
    if (connection) {
      connection.release();
    }
    process.exit(0);
  }
}

addDocumentsColumn();
