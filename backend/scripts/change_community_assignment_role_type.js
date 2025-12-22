const pool = require("../src/config/database");

async function run() {
  try {
    console.log(
      "Changing community_assignments.role column type to VARCHAR(50)..."
    );
    await pool.query(
      "ALTER TABLE community_assignments MODIFY COLUMN role VARCHAR(50) NOT NULL"
    );
    console.log("Success!");
  } catch (error) {
    console.error("Error:", error);
  } finally {
    process.exit();
  }
}

run();
