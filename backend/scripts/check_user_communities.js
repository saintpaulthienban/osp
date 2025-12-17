const db = require("../config/database");

(async () => {
  try {
    console.log("🔍 Checking user_communities table...\n");

    // Check if table exists
    const [tables] = await db.query("SHOW TABLES LIKE 'user_communities'");

    if (tables.length === 0) {
      console.log("❌ Table user_communities does NOT exist");
      console.log("\n💡 You need to create this table:");
      console.log(`
CREATE TABLE user_communities (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY unique_user_community (user_id, community_id),
  KEY idx_user_id (user_id),
  KEY idx_community_id (community_id),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (community_id) REFERENCES communities(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
`);
    } else {
      console.log("✅ Table user_communities exists\n");

      // Show schema
      const [schema] = await db.query("DESCRIBE user_communities");
      console.log("Schema:");
      console.table(schema);

      // Show sample data
      const [rows] = await db.query("SELECT * FROM user_communities LIMIT 5");
      console.log("\nSample data:");
      if (rows.length === 0) {
        console.log("(No data yet)");
      } else {
        console.table(rows);
      }

      // Show count
      const [count] = await db.query(
        "SELECT COUNT(*) as total FROM user_communities"
      );
      console.log(`\nTotal records: ${count[0].total}`);
    }

    process.exit(0);
  } catch (err) {
    console.error("❌ Error:", err.message);
    process.exit(1);
  }
})();
