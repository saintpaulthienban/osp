// src/config/initDatabase.js
// Auto-run migrations on server start

const pool = require("./database");

async function initCommunityRolesTable() {
  const connection = await pool.getConnection();
  try {
    console.log("[Migration] Checking community_roles table...");

    // Check if table exists
    const [tables] = await connection.query(
      "SHOW TABLES LIKE 'community_roles'"
    );

    if (tables.length === 0) {
      console.log("[Migration] Creating community_roles table...");

      // Create table
      await connection.query(`
        CREATE TABLE IF NOT EXISTS community_roles (
          id INT AUTO_INCREMENT PRIMARY KEY,
          code VARCHAR(50) NOT NULL UNIQUE,
          name VARCHAR(100) NOT NULL,
          description TEXT,
          display_order INT DEFAULT 0,
          color VARCHAR(20) DEFAULT '#6c757d',
          is_default BOOLEAN DEFAULT FALSE,
          is_active BOOLEAN DEFAULT TRUE,
          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
      `);

      console.log("[Migration] community_roles table created!");
    }

    // Check if default roles exist
    const [existingRoles] = await connection.query(
      "SELECT COUNT(*) as count FROM community_roles"
    );

    if (existingRoles[0].count === 0) {
      console.log("[Migration] Inserting default community roles...");

      const defaultRoles = [
        ["superior", "Bề trên", 1, "#d63031", true],
        ["assistant", "Phó bề trên", 2, "#2d3436", true],
        ["secretary", "Thư ký", 3, "#6c5ce7", true],
        ["treasurer", "Thủ quỹ", 4, "#e84393", true],
        ["member", "Thành viên", 5, "#0984e3", true],
      ];

      for (const role of defaultRoles) {
        await connection.query(
          `INSERT IGNORE INTO community_roles (code, name, display_order, color, is_default, is_active) 
           VALUES (?, ?, ?, ?, ?, TRUE)`,
          role
        );
      }

      console.log("[Migration] Default community roles inserted!");
    } else {
      console.log(
        `[Migration] community_roles table already has ${existingRoles[0].count} roles`
      );
    }
  } catch (error) {
    console.error("[Migration] Error initializing community_roles:", error.message);
  } finally {
    connection.release();
  }
}

async function initDatabase() {
  try {
    console.log("[Migration] Starting database initialization...");
    await initCommunityRolesTable();
    console.log("[Migration] Database initialization complete!");
  } catch (error) {
    console.error("[Migration] Database initialization failed:", error.message);
  }
}

module.exports = { initDatabase };
