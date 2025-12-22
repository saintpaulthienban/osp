// Script to add organization and address columns to missions table
const pool = require("../src/config/database");

async function addColumns() {
  let connection;
  try {
    connection = await pool.getConnection();

    console.log(
      "Checking if organization and address columns exist in missions table..."
    );

    // Check if columns exist
    const [columns] = await connection.query(
      `SELECT COLUMN_NAME 
       FROM INFORMATION_SCHEMA.COLUMNS 
       WHERE TABLE_SCHEMA = DATABASE() 
       AND TABLE_NAME = 'missions' 
       AND COLUMN_NAME IN ('organization', 'address')`
    );

    const existingColumns = columns.map((col) => col.COLUMN_NAME);
    const hasOrganization = existingColumns.includes("organization");
    const hasAddress = existingColumns.includes("address");

    if (hasOrganization && hasAddress) {
      console.log(
        "Columns 'organization' and 'address' already exist in missions table."
      );
      return;
    }

    // Add organization column if not exists
    if (!hasOrganization) {
      console.log("Adding 'organization' column to missions table...");
      await connection.query(`
        ALTER TABLE missions 
        ADD COLUMN organization VARCHAR(255) NULL 
        COMMENT 'Organization/Institution name'
        AFTER specific_role
      `);
      console.log("✅ Successfully added 'organization' column!");
    }

    // Add address column if not exists
    if (!hasAddress) {
      console.log("Adding 'address' column to missions table...");
      await connection.query(`
        ALTER TABLE missions 
        ADD COLUMN address TEXT NULL 
        COMMENT 'Address/Location'
        AFTER organization
      `);
      console.log("✅ Successfully added 'address' column!");
    }

    console.log("✅ Migration completed successfully!");
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

addColumns();
