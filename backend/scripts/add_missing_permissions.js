const mysql = require("mysql2/promise");
require("dotenv").config();

async function addMissingPermissions() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  try {
    console.log("🔍 Thêm permissions còn thiếu...\n");

    // Permissions cần thêm theo từng module
    const missingPermissions = [
      // Sisters - chi tiết hơn
      {
        name: "sisters.view_list",
        display_name: "Xem danh sách nữ tu",
        module: "sisters",
      },
      {
        name: "sisters.view_detail",
        display_name: "Xem chi tiết nữ tu",
        module: "sisters",
      },

      // Communities - chi tiết hơn
      {
        name: "communities.view_list",
        display_name: "Xem danh sách cộng đoàn",
        module: "communities",
      },
      {
        name: "communities.view_detail",
        display_name: "Xem chi tiết cộng đoàn",
        module: "communities",
      },

      // Journey - chi tiết hơn
      {
        name: "journey.view_list",
        display_name: "Xem danh sách hành trình",
        module: "journey",
      },
      {
        name: "journey.view_detail",
        display_name: "Xem chi tiết hành trình",
        module: "journey",
      },

      // Health - chi tiết hơn
      {
        name: "health.view_list",
        display_name: "Xem danh sách hồ sơ sức khỏe",
        module: "health",
      },
      {
        name: "health.view_detail",
        display_name: "Xem chi tiết hồ sơ sức khỏe",
        module: "health",
      },

      // Education - chi tiết hơn
      {
        name: "education.view_list",
        display_name: "Xem danh sách học vấn",
        module: "education",
      },
      {
        name: "education.view_detail",
        display_name: "Xem chi tiết học vấn",
        module: "education",
      },

      // Missions - chi tiết hơn
      {
        name: "missions.view_list",
        display_name: "Xem danh sách sứ vụ",
        module: "missions",
      },
      {
        name: "missions.view_detail",
        display_name: "Xem chi tiết sứ vụ",
        module: "missions",
      },

      // Evaluations - chi tiết hơn
      {
        name: "evaluations.view_list",
        display_name: "Xem danh sách đánh giá",
        module: "evaluations",
      },
      {
        name: "evaluations.view_detail",
        display_name: "Xem chi tiết đánh giá",
        module: "evaluations",
      },

      // Users - chi tiết hơn
      {
        name: "users.view_list",
        display_name: "Xem danh sách người dùng",
        module: "users",
      },
      {
        name: "users.view_detail",
        display_name: "Xem chi tiết người dùng",
        module: "users",
      },
      {
        name: "users.update",
        display_name: "Cập nhật người dùng",
        module: "users",
      },
      {
        name: "users.lock_unlock",
        display_name: "Khóa/Mở khóa người dùng",
        module: "users",
      },
      {
        name: "users.reset_password",
        display_name: "Đặt lại mật khẩu",
        module: "users",
      },
      {
        name: "users.assign_permissions",
        display_name: "Gán quyền",
        module: "users",
      },
      {
        name: "users.revoke_permissions",
        display_name: "Thu hồi quyền",
        module: "users",
      },
      {
        name: "users.view_permissions",
        display_name: "Xem quyền của người dùng",
        module: "users",
      },
      {
        name: "users.view_activity",
        display_name: "Xem hoạt động",
        module: "users",
      },
      {
        name: "users.remove_communities",
        display_name: "Xóa cộng đoàn khỏi người dùng",
        module: "users",
      },

      // Reports - chi tiết hơn
      {
        name: "reports.view_list",
        display_name: "Xem danh sách báo cáo",
        module: "reports",
      },
      {
        name: "reports.view_detail",
        display_name: "Xem chi tiết báo cáo",
        module: "reports",
      },

      // Departure records
      {
        name: "departure.view",
        display_name: "Xem hồ sơ nghỉ",
        module: "departure",
      },
      {
        name: "departure.create",
        display_name: "Tạo hồ sơ nghỉ",
        module: "departure",
      },
      {
        name: "departure.edit",
        display_name: "Chỉnh sửa hồ sơ nghỉ",
        module: "departure",
      },
      {
        name: "departure.delete",
        display_name: "Xóa hồ sơ nghỉ",
        module: "departure",
      },

      // Training courses
      {
        name: "training.view",
        display_name: "Xem khóa đào tạo",
        module: "training",
      },
      {
        name: "training.create",
        display_name: "Tạo khóa đào tạo",
        module: "training",
      },
      {
        name: "training.edit",
        display_name: "Chỉnh sửa khóa đào tạo",
        module: "training",
      },
      {
        name: "training.delete",
        display_name: "Xóa khóa đào tạo",
        module: "training",
      },

      // Community assignments
      {
        name: "community_assignment.view",
        display_name: "Xem phân công cộng đoàn",
        module: "community_assignment",
      },
      {
        name: "community_assignment.create",
        display_name: "Tạo phân công",
        module: "community_assignment",
      },
      {
        name: "community_assignment.edit",
        display_name: "Chỉnh sửa phân công",
        module: "community_assignment",
      },
      {
        name: "community_assignment.delete",
        display_name: "Xóa phân công",
        module: "community_assignment",
      },
    ];

    for (const perm of missingPermissions) {
      // Check if exists
      const [existing] = await connection.execute(
        "SELECT id FROM permissions WHERE name = ?",
        [perm.name]
      );

      if (existing.length === 0) {
        await connection.execute(
          `INSERT INTO permissions (name, display_name, description, module, is_active) 
           VALUES (?, ?, ?, ?, 1)`,
          [
            perm.name,
            perm.display_name,
            `Quyền ${perm.display_name.toLowerCase()}`,
            perm.module,
          ]
        );
        console.log(`  ✓ Đã thêm: ${perm.name}`);
      } else {
        console.log(`  - Đã có: ${perm.name}`);
      }
    }

    // Gán tất cả permissions mới cho admin
    console.log("\n📌 Gán permissions mới cho admin...");
    const [adminUser] = await connection.execute(
      "SELECT id FROM users WHERE username = ? LIMIT 1",
      ["admin"]
    );

    if (adminUser.length > 0) {
      const adminId = adminUser[0].id;
      const [allPerms] = await connection.execute("SELECT id FROM permissions");

      for (const perm of allPerms) {
        await connection.execute(
          "INSERT IGNORE INTO user_permissions (user_id, permission_id) VALUES (?, ?)",
          [adminId, perm.id]
        );
      }
      console.log(`  ✓ Admin có ${allPerms.length} permissions`);
    }

    console.log("\n✅ Hoàn tất!");
    console.log(
      "\n⚠️  Lưu ý: Admin cần đăng nhập lại để JWT được refresh với permissions mới!\n"
    );
  } finally {
    await connection.end();
  }
}

addMissingPermissions().catch(console.error);
