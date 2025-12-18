// src/scripts/add_missing_education_level.js
const pool = require("../config/database");

async function addMissingEducationLevel() {
  const connection = await pool.getConnection();

  try {
    console.log("Checking for missing education level: high_school...");

    // Check if high_school exists
    const [existing] = await connection.query(
      "SELECT * FROM education_levels WHERE code = 'high_school'"
    );

    if (existing.length === 0) {
      console.log("Adding missing level: Phổ thông (high_school)...");

      await connection.query(
        `INSERT INTO education_levels (code, name, display_order, color) VALUES (?, ?, ?, ?)`,
        ["high_school", "Phổ thông", 2, "#17a2b8"]
      );

      console.log("✓ Successfully added high_school level!");
    } else {
      console.log("✓ high_school level already exists.");
    }

    // Display all levels
    const [allLevels] = await connection.query(
      "SELECT id, code, name, display_order, color FROM education_levels ORDER BY display_order"
    );

    console.log("\n=== All Education Levels ===");
    console.table(allLevels);
  } catch (error) {
    console.error("Error:", error);
    throw error;
  } finally {
    connection.release();
    await pool.end();
  }
}

addMissingEducationLevel()
  .then(() => {
    console.log("\nDone!");
    process.exit(0);
  })
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
