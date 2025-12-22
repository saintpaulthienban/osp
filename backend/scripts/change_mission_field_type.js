const pool = require("../src/config/database");

async function run() {
  const connection = await pool.getConnection();
  try {
    console.log(
      "Changing missions.field column type from ENUM to VARCHAR(100)..."
    );

    // Modify the column to VARCHAR(100) to allow any string value
    await connection.query(`
      ALTER TABLE missions 
      MODIFY COLUMN field VARCHAR(100) NOT NULL
    `);

    console.log("Success! missions.field is now VARCHAR(100).");
  } catch (error) {
    console.error("Error changing column type:", error);
  } finally {
    connection.release();
    process.exit();
  }
}

run();
