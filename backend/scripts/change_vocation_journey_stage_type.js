const pool = require("../src/config/database");

async function run() {
  try {
    console.log(
      "Changing vocation_journey.stage column type to VARCHAR(50)..."
    );
    await pool.query(
      "ALTER TABLE vocation_journey MODIFY COLUMN stage VARCHAR(50) NOT NULL"
    );
    console.log("Success!");
  } catch (error) {
    console.error("Error:", error);
  } finally {
    process.exit();
  }
}

run();
