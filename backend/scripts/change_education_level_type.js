const pool = require("../src/config/database");

async function run() {
  try {
    console.log("Changing education.level column type to VARCHAR(50)...");
    await pool.query(
      "ALTER TABLE education MODIFY COLUMN level VARCHAR(50) NOT NULL"
    );
    console.log("Success!");
  } catch (error) {
    console.error("Error:", error);
  } finally {
    process.exit();
  }
}

run();
