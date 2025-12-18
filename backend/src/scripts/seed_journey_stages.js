const pool = require("../config/database");

const stages = [
  {
    code: "aspirant",
    name: "Ứng sinh",
    display_order: 1,
    color: "#17a2b8",
  },
  {
    code: "pre_aspirant",
    name: "Tiền ứng sinh",
    display_order: 2,
    color: "#20c997",
  },
  {
    code: "postulant",
    name: "Tập sinh",
    display_order: 3,
    color: "#28a745",
  },
  {
    code: "novice",
    name: "Tập sinh viện",
    display_order: 4,
    color: "#ffc107",
  },
  {
    code: "temporary_vows",
    name: "Khấn tạm",
    display_order: 5,
    color: "#fd7e14",
  },
  {
    code: "perpetual_vows",
    name: "Khấn trọn",
    display_order: 6,
    color: "#dc3545",
  },
  {
    code: "de_tu",
    name: "Đệ tử",
    display_order: 7,
    color: "#6f42c1",
  },
  {
    code: "formation",
    name: "Đào tạo",
    display_order: 8,
    color: "#007bff",
  },
  {
    code: "mission",
    name: "Sứ vụ",
    display_order: 9,
    color: "#e83e8c",
  },
  {
    code: "sabbatical",
    name: "Nghỉ phép",
    display_order: 10,
    color: "#6c757d",
  },
];

async function seedJourneyStages() {
  try {
    console.log("Starting to seed journey stages...");

    for (const stage of stages) {
      // Check if stage already exists
      const [existing] = await pool.query(
        "SELECT id FROM journey_stages WHERE code = ?",
        [stage.code]
      );

      if (existing.length > 0) {
        // Update existing stage
        await pool.query(
          "UPDATE journey_stages SET name = ?, display_order = ?, color = ?, updated_at = NOW() WHERE code = ?",
          [stage.name, stage.display_order, stage.color, stage.code]
        );
        console.log(`✓ Updated stage: ${stage.code} - ${stage.name}`);
      } else {
        // Insert new stage
        await pool.query(
          "INSERT INTO journey_stages (code, name, display_order, color, is_active) VALUES (?, ?, ?, ?, 1)",
          [stage.code, stage.name, stage.display_order, stage.color]
        );
        console.log(`✓ Created stage: ${stage.code} - ${stage.name}`);
      }
    }

    console.log("\n✓ All journey stages seeded successfully!");

    // Show current stages
    const [results] = await pool.query(
      "SELECT * FROM journey_stages ORDER BY display_order"
    );
    console.log("\nCurrent journey stages:");
    console.table(results);

    process.exit(0);
  } catch (error) {
    console.error("Error seeding journey stages:", error);
    process.exit(1);
  }
}

seedJourneyStages();
