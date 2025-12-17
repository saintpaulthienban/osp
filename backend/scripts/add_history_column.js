// Script to add history column to communities table
const mysql = require("mysql2/promise");
require("dotenv").config();

async function addHistoryColumn() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  try {
    // Check if column exists
    const [columns] = await connection.execute(
      "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'hr_records' AND TABLE_NAME = 'communities' AND COLUMN_NAME = 'history'"
    );

    if (columns.length > 0) {
      console.log('Column "history" already exists in communities table');
    } else {
      await connection.execute(
        "ALTER TABLE communities ADD COLUMN history TEXT NULL"
      );
      console.log('Successfully added "history" column to communities table');
    }
  } catch (error) {
    console.error("Error:", error.message);
  } finally {
    await connection.end();
  }
}

addHistoryColumn();
