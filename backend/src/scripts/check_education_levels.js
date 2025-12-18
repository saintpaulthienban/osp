// Check education levels in database
const pool = require("../config/database");

async function checkEducationLevels() {
  const connection = await pool.getConnection();

  try {
    console.log("\n=== Education Levels in Database ===\n");
    const [levels] = await connection.query(
      "SELECT * FROM education_levels ORDER BY display_order"
    );
    console.table(levels);

    console.log("\n=== Education Records with Levels ===\n");
    const [educations] = await connection.query(
      "SELECT id, sister_id, level, institution, major FROM education LIMIT 10"
    );
    console.table(educations);
  } catch (error) {
    console.error("Error:", error);
  } finally {
    connection.release();
    process.exit(0);
  }
}

checkEducationLevels();
