const pool = require("../config/database");

async function check() {
  try {
    const [tables] = await pool.query("SHOW TABLES LIKE 'community_roles'");
    console.log("Tables found:", tables);
    process.exit(0);
  } catch (err) {
    console.error("Error:", err.message);
    process.exit(1);
  }
}

check();
