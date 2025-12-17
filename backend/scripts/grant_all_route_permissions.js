// Script to check all route permissions and grant missing ones to admin
const db = require("../src/config/database");

// All permissions required by routes
const ROUTE_PERMISSIONS = {
  // Sisters
  "sisters.view_list": "Xem danh sách nữ tu",
  "sisters.view_detail": "Xem chi tiết nữ tu",
  "sisters.create": "Thêm nữ tu",
  "sisters.update_basic": "Cập nhật thông tin cơ bản nữ tu",
  "sisters.delete": "Xóa nữ tu",
  "sisters.upload_avatar": "Upload ảnh đại diện",
  "sisters.upload_documents": "Upload tài liệu",

  // Health
  "health.view_list": "Xem danh sách sức khỏe",
  "health.view_basic": "Xem thông tin sức khỏe cơ bản",
  "health.view_full": "Xem đầy đủ thông tin sức khỏe",
  "health.create": "Thêm hồ sơ sức khỏe",
  "health.update": "Cập nhật hồ sơ sức khỏe",
  "health.delete": "Xóa hồ sơ sức khỏe",

  // Departures
  "departures.view_list": "Xem danh sách di vãng",
  "departures.view_detail": "Xem chi tiết di vãng",
  "departures.create": "Thêm hồ sơ di vãng",
  "departures.update": "Cập nhật hồ sơ di vãng",
  "departures.delete": "Xóa hồ sơ di vãng",

  // Evaluations
  "evaluations.view_list": "Xem danh sách đánh giá",
  "evaluations.view_detail": "Xem chi tiết đánh giá",
  "evaluations.create": "Thêm đánh giá",
  "evaluations.update": "Cập nhật đánh giá",
  "evaluations.delete": "Xóa đánh giá",

  // Missions
  "missions.view_list": "Xem danh sách sứ vụ",
  "missions.view_detail": "Xem chi tiết sứ vụ",
  "missions.create": "Thêm sứ vụ",
  "missions.update": "Cập nhật sứ vụ",
  "missions.delete": "Xóa sứ vụ",

  // Education
  "education.view_list": "Xem danh sách học vấn",
  "education.view_detail": "Xem chi tiết học vấn",
  "education.create": "Thêm học vấn",
  "education.update": "Cập nhật học vấn",
  "education.delete": "Xóa học vấn",

  // Training
  "training.view_list": "Xem danh sách đào tạo",
  "training.view_detail": "Xem chi tiết đào tạo",
  "training.create": "Thêm khóa đào tạo",
  "training.update": "Cập nhật khóa đào tạo",
  "training.delete": "Xóa khóa đào tạo",

  // Vocation Journey
  "vocation.view_list": "Xem danh sách hành trình",
  "vocation.view_detail": "Xem chi tiết hành trình",
  "vocation.create": "Thêm giai đoạn hành trình",
  "vocation.update": "Cập nhật hành trình",
  "vocation.delete": "Xóa hành trình",

  // Communities
  "communities.view_list": "Xem danh sách cộng đoàn",
  "communities.view_detail": "Xem chi tiết cộng đoàn",
  "communities.create": "Thêm cộng đoàn",
  "communities.update": "Cập nhật cộng đoàn",
  "communities.delete": "Xóa cộng đoàn",

  // Users
  "users.view_list": "Xem danh sách người dùng",
  "users.view_detail": "Xem chi tiết người dùng",
  "users.create": "Thêm người dùng",
  "users.update": "Cập nhật người dùng",
  "users.delete": "Xóa người dùng",
  "users.reset_password": "Đặt lại mật khẩu",

  // Reports
  "reports.view_dashboard": "Xem dashboard báo cáo",
  "reports.export": "Xuất báo cáo",
};

async function checkAndGrantPermissions() {
  try {
    console.log("=== Checking Route Permissions ===\n");

    let createdCount = 0;
    let existingCount = 0;
    let grantedCount = 0;

    for (const [name, display_name] of Object.entries(ROUTE_PERMISSIONS)) {
      // Check if permission exists
      const [existing] = await db.query(
        "SELECT id FROM permissions WHERE name = ?",
        [name]
      );

      let permId;
      if (existing.length > 0) {
        permId = existing[0].id;
        existingCount++;
      } else {
        // Create permission
        const module = name.split(".")[0];
        await db.query(
          "INSERT INTO permissions (name, display_name, description, module) VALUES (?, ?, ?, ?)",
          [name, display_name, display_name, module]
        );
        const [perm] = await db.query(
          "SELECT id FROM permissions WHERE name = ?",
          [name]
        );
        permId = perm[0].id;
        createdCount++;
        console.log(`✅ Created: ${name}`);
      }

      // Grant to admin (user_id: 18)
      const [granted] = await db.query(
        "SELECT * FROM user_permissions WHERE user_id = 18 AND permission_id = ?",
        [permId]
      );

      if (granted.length === 0) {
        await db.query(
          "INSERT INTO user_permissions (user_id, permission_id) VALUES (?, ?)",
          [18, permId]
        );
        grantedCount++;
        console.log(`  → Granted to admin: ${name}`);
      }
    }

    console.log("\n=== Summary ===");
    console.log(`Total permissions: ${Object.keys(ROUTE_PERMISSIONS).length}`);
    console.log(`Already existed: ${existingCount}`);
    console.log(`Newly created: ${createdCount}`);
    console.log(`Newly granted to admin: ${grantedCount}`);

    console.log(
      "\n✅ Admin now has all required route permissions. Please logout and login again!"
    );

    process.exit(0);
  } catch (error) {
    console.error("Error:", error.message);
    process.exit(1);
  }
}

checkAndGrantPermissions();
