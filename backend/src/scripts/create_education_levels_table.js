// src/scripts/create_education_levels_table.js
const pool = require("../config/database");

async function createEducationLevelsTable() {
  const connection = await pool.getConnection();

  try {
    console.log("Creating education_levels table...");

    // Create education_levels table
    await connection.query(`
      CREATE TABLE IF NOT EXISTS education_levels (
        id INT AUTO_INCREMENT PRIMARY KEY,
        code VARCHAR(50) NOT NULL UNIQUE,
        name VARCHAR(100) NOT NULL,
        description TEXT,
        display_order INT DEFAULT 0,
        color VARCHAR(20) DEFAULT '#6c757d',
        is_active BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      )
    `);

    console.log("Table created successfully!");

    // Check if there are any existing levels
    const [existing] = await connection.query(
      "SELECT COUNT(*) as count FROM education_levels"
    );

    if (existing[0].count === 0) {
      console.log("Inserting default education levels...");

      // Insert default levels
      const defaultLevels = [
        {
          code: "secondary",
          name: "Trung học",
          display_order: 1,
          color: "#6c757d",
        },
        {
          code: "high_school",
          name: "Phổ thông",
          display_order: 2,
          color: "#17a2b8",
        },
        {
          code: "vocational",
          name: "Trung cấp",
          display_order: 3,
          color: "#20c997",
        },
        {
          code: "college",
          name: "Cao đẳng",
          display_order: 4,
          color: "#fd7e14",
        },
        {
          code: "bachelor",
          name: "Đại học",
          display_order: 5,
          color: "#0d6efd",
        },
        { code: "master", name: "Thạc sĩ", display_order: 6, color: "#6f42c1" },
        {
          code: "doctorate",
          name: "Tiến sĩ",
          display_order: 7,
          color: "#dc3545",
        },
        {
          code: "certificate",
          name: "Chứng chỉ",
          display_order: 8,
          color: "#ffc107",
        },
        { code: "other", name: "Khác", display_order: 99, color: "#adb5bd" },
      ];

      for (const level of defaultLevels) {
        await connection.query(
          `INSERT INTO education_levels (code, name, display_order, color) VALUES (?, ?, ?, ?)`,
          [level.code, level.name, level.display_order, level.color]
        );
        console.log(`  - Added level: ${level.name}`);
      }

      console.log(`Inserted ${defaultLevels.length} default education levels.`);
    } else {
      console.log(`Table already has ${existing[0].count} levels.`);
    }

    console.log("Done!");
  } catch (error) {
    console.error("Error:", error);
    throw error;
  } finally {
    connection.release();
  }
}

createEducationLevelsTable()
  .then(() => process.exit(0))
  .catch((err) => {
    console.error(err);
    process.exit(1);
  });
