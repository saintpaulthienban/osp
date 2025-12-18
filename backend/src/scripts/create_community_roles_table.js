const pool = require("../config/database");

async function createCommunityRolesTable() {
  try {
    console.log("Creating community_roles table...");

    // Create table
    await pool.query(`
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

    console.log("Table created successfully!");

    // Insert default roles
    const defaultRoles = [
      {
        code: "superior",
        name: "Bề trên",
        display_order: 1,
        color: "#d63031",
        is_default: true,
      },
      {
        code: "assistant",
        name: "Phó bề trên",
        display_order: 2,
        color: "#2d3436",
        is_default: true,
      },
      {
        code: "secretary",
        name: "Thư ký",
        display_order: 3,
        color: "#6c5ce7",
        is_default: true,
      },
      {
        code: "treasurer",
        name: "Thủ quỹ",
        display_order: 4,
        color: "#e84393",
        is_default: true,
      },
      {
        code: "member",
        name: "Thành viên",
        display_order: 5,
        color: "#0984e3",
        is_default: true,
      },
    ];

    for (const role of defaultRoles) {
      const [existing] = await pool.query(
        "SELECT id FROM community_roles WHERE code = ?",
        [role.code]
      );

      if (existing.length === 0) {
        await pool.query(
          `INSERT INTO community_roles (code, name, display_order, color, is_default, is_active) 
           VALUES (?, ?, ?, ?, ?, TRUE)`,
          [
            role.code,
            role.name,
            role.display_order,
            role.color,
            role.is_default,
          ]
        );
        console.log(`✓ Created role: ${role.code} - ${role.name}`);
      } else {
        console.log(`✓ Role exists: ${role.code}`);
      }
    }

    // Show current roles
    const [roles] = await pool.query(
      "SELECT * FROM community_roles ORDER BY display_order"
    );
    console.log("\nCurrent community roles:");
    console.table(roles);

    process.exit(0);
  } catch (error) {
    console.error("Error:", error.message);
    process.exit(1);
  }
}

createCommunityRolesTable();
