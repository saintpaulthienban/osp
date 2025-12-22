const pool = require("../config/database");

const ensureDecisionFileColumn = async () => {
  try {
    console.log(
      "Checking decision_file_url column in community_assignments table..."
    );

    // Check if decision_file_url column exists
    const [columns] = await pool.query(
      `SHOW COLUMNS FROM community_assignments LIKE 'decision_file_url'`
    );

    if (columns.length === 0) {
      console.log("Adding decision_file_url column...");
      await pool.query(`
        ALTER TABLE community_assignments
        ADD COLUMN decision_file_url VARCHAR(500) NULL AFTER decision_number
      `);
      console.log("✓ decision_file_url column added successfully!");
    } else {
      console.log("✓ decision_file_url column already exists");
    }

    console.log("Migration complete!");
  } catch (error) {
    console.error("Migration error:", error);
  } finally {
    process.exit();
  }
};

ensureDecisionFileColumn();
