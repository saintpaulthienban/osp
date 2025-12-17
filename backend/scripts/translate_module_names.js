const mysql = require("mysql2/promise");
require("dotenv").config();

async function translateModuleNames() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  try {
    console.log("🌐 Chuyển tên module sang tiếng Việt...\n");

    const moduleTranslations = {
      sisters: "Nữ tu",
      communities: "Cộng đoàn",
      journey: "Hành trình ơn gọi",
      health: "Sức khỏe",
      education: "Học vấn",
      missions: "Sứ vụ",
      evaluations: "Đánh giá",
      reports: "Báo cáo",
      users: "Người dùng",
      settings: "Cài đặt",
      departure: "Nghỉ việc",
      training: "Đào tạo",
      community_assignment: "Phân công cộng đoàn",
    };

    for (const [english, vietnamese] of Object.entries(moduleTranslations)) {
      const [result] = await connection.execute(
        "UPDATE permissions SET module = ? WHERE module = ?",
        [vietnamese, english]
      );

      if (result.affectedRows > 0) {
        console.log(
          `  ✓ ${english} → ${vietnamese} (${result.affectedRows} permissions)`
        );
      }
    }

    console.log("\n✅ Hoàn tất chuyển đổi tên module!\n");

    // Hiển thị danh sách permissions theo module tiếng Việt
    const [permissions] = await connection.execute(
      "SELECT module, COUNT(*) as count FROM permissions GROUP BY module ORDER BY module"
    );

    console.log("📋 Danh sách module sau khi chuyển đổi:");
    permissions.forEach((p) => {
      console.log(`   ${p.module}: ${p.count} quyền`);
    });
  } finally {
    await connection.end();
  }
}

translateModuleNames().catch(console.error);
