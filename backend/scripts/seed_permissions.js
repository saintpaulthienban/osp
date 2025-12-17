// Script to seed all permissions into database
const db = require("../src/config/database");

const permissions = [
  // Module: Sisters (Nữ Tu)
  {
    name: "sisters.view_list",
    display_name: "Xem danh sách nữ tu",
    module: "sisters",
    description: "Xem danh sách nữ tu",
  },
  {
    name: "sisters.view_detail",
    display_name: "Xem chi tiết hồ sơ",
    module: "sisters",
    description: "Xem chi tiết hồ sơ nữ tu",
  },
  {
    name: "sisters.create",
    display_name: "Tạo hồ sơ mới",
    module: "sisters",
    description: "Tạo hồ sơ nữ tu mới",
  },
  {
    name: "sisters.update_basic",
    display_name: "Sửa thông tin cơ bản",
    module: "sisters",
    description: "Sửa thông tin cơ bản",
  },
  {
    name: "sisters.update_sensitive",
    display_name: "Sửa thông tin nhạy cảm",
    module: "sisters",
    description: "Sửa CMND, hộ chiếu...",
  },
  {
    name: "sisters.delete",
    display_name: "Xóa hồ sơ",
    module: "sisters",
    description: "Xóa hồ sơ nữ tu",
  },
  {
    name: "sisters.upload_avatar",
    display_name: "Upload ảnh",
    module: "sisters",
    description: "Upload ảnh chân dung",
  },
  {
    name: "sisters.upload_documents",
    display_name: "Upload tài liệu",
    module: "sisters",
    description: "Upload tài liệu",
  },
  {
    name: "sisters.export_excel",
    display_name: "Xuất Excel",
    module: "sisters",
    description: "Xuất danh sách Excel",
  },
  {
    name: "sisters.export_pdf",
    display_name: "Xuất PDF",
    module: "sisters",
    description: "Xuất hồ sơ PDF",
  },
  {
    name: "sisters.print",
    display_name: "In hồ sơ",
    module: "sisters",
    description: "In hồ sơ nữ tu",
  },

  // Module: Vocation Journey (Hành Trình)
  {
    name: "vocation.view",
    display_name: "Xem hành trình",
    module: "vocation",
    description: "Xem hành trình ơn gọi",
  },
  {
    name: "vocation.create",
    display_name: "Thêm mốc",
    module: "vocation",
    description: "Thêm mốc hành trình",
  },
  {
    name: "vocation.update",
    display_name: "Sửa mốc",
    module: "vocation",
    description: "Sửa mốc hành trình",
  },
  {
    name: "vocation.delete",
    display_name: "Xóa mốc",
    module: "vocation",
    description: "Xóa mốc hành trình",
  },

  // Module: Communities (Cộng Đoàn)
  {
    name: "communities.view_list",
    display_name: "Xem danh sách",
    module: "communities",
    description: "Xem danh sách cộng đoàn",
  },
  {
    name: "communities.view_detail",
    display_name: "Xem chi tiết",
    module: "communities",
    description: "Xem chi tiết cộng đoàn",
  },
  {
    name: "communities.create",
    display_name: "Tạo mới",
    module: "communities",
    description: "Tạo cộng đoàn mới",
  },
  {
    name: "communities.update",
    display_name: "Sửa thông tin",
    module: "communities",
    description: "Sửa thông tin cộng đoàn",
  },
  {
    name: "communities.delete",
    display_name: "Xóa",
    module: "communities",
    description: "Xóa cộng đoàn",
  },
  {
    name: "communities.assign_sister",
    display_name: "Gán nữ tu",
    module: "communities",
    description: "Gán nữ tu vào cộng đoàn",
  },
  {
    name: "communities.remove_sister",
    display_name: "Gỡ nữ tu",
    module: "communities",
    description: "Gỡ nữ tu khỏi cộng đoàn",
  },
  {
    name: "communities.upload_decision",
    display_name: "Upload quyết định",
    module: "communities",
    description: "Upload quyết định bổ nhiệm",
  },

  // Module: Missions (Sứ Vụ)
  {
    name: "missions.view",
    display_name: "Xem sứ vụ",
    module: "missions",
    description: "Xem thông tin sứ vụ",
  },
  {
    name: "missions.create",
    display_name: "Thêm sứ vụ",
    module: "missions",
    description: "Thêm sứ vụ mới",
  },
  {
    name: "missions.update",
    display_name: "Sửa sứ vụ",
    module: "missions",
    description: "Sửa thông tin sứ vụ",
  },
  {
    name: "missions.delete",
    display_name: "Xóa sứ vụ",
    module: "missions",
    description: "Xóa sứ vụ",
  },

  // Module: Education (Học Vấn)
  {
    name: "education.view",
    display_name: "Xem học vấn",
    module: "education",
    description: "Xem thông tin học vấn",
  },
  {
    name: "education.create",
    display_name: "Thêm học vấn",
    module: "education",
    description: "Thêm học vấn mới",
  },
  {
    name: "education.update",
    display_name: "Sửa học vấn",
    module: "education",
    description: "Sửa thông tin học vấn",
  },
  {
    name: "education.delete",
    display_name: "Xóa học vấn",
    module: "education",
    description: "Xóa học vấn",
  },
  {
    name: "education.upload_certificate",
    display_name: "Upload bằng cấp",
    module: "education",
    description: "Upload file bằng cấp",
  },

  // Module: Training Courses (Thường Huấn)
  {
    name: "training.view",
    display_name: "Xem thường huấn",
    module: "training",
    description: "Xem thông tin thường huấn",
  },
  {
    name: "training.create",
    display_name: "Thêm khóa học",
    module: "training",
    description: "Thêm khóa học mới",
  },
  {
    name: "training.update",
    display_name: "Sửa khóa học",
    module: "training",
    description: "Sửa thông tin khóa học",
  },
  {
    name: "training.delete",
    display_name: "Xóa khóa học",
    module: "training",
    description: "Xóa khóa học",
  },

  // Module: Health Records (Sức Khỏe) - SENSITIVE
  {
    name: "health.view_basic",
    display_name: "Xem sức khỏe cơ bản",
    module: "health",
    description: "Xem thông tin sức khỏe cơ bản",
  },
  {
    name: "health.view_full",
    display_name: "Xem đầy đủ sức khỏe",
    module: "health",
    description: "Xem đầy đủ thông tin sức khỏe nhạy cảm",
  },
  {
    name: "health.update",
    display_name: "Cập nhật sức khỏe",
    module: "health",
    description: "Cập nhật thông tin sức khỏe",
  },
  {
    name: "health.add_record",
    display_name: "Thêm bản ghi",
    module: "health",
    description: "Thêm bản ghi khám bệnh",
  },
  {
    name: "health.update_record",
    display_name: "Sửa bản ghi",
    module: "health",
    description: "Sửa bản ghi khám bệnh",
  },
  {
    name: "health.delete_record",
    display_name: "Xóa bản ghi",
    module: "health",
    description: "Xóa bản ghi khám bệnh",
  },

  // Module: Evaluations (Đánh Giá)
  {
    name: "evaluations.view",
    display_name: "Xem đánh giá",
    module: "evaluations",
    description: "Xem phiếu đánh giá",
  },
  {
    name: "evaluations.create",
    display_name: "Tạo phiếu",
    module: "evaluations",
    description: "Tạo phiếu đánh giá mới",
  },
  {
    name: "evaluations.update",
    display_name: "Sửa phiếu",
    module: "evaluations",
    description: "Sửa phiếu đánh giá",
  },
  {
    name: "evaluations.delete",
    display_name: "Xóa phiếu",
    module: "evaluations",
    description: "Xóa phiếu đánh giá",
  },
  {
    name: "evaluations.export_pdf",
    display_name: "Xuất PDF",
    module: "evaluations",
    description: "Xuất phiếu PDF",
  },

  // Module: Departure Records (Tu Xuất)
  {
    name: "departures.view",
    display_name: "Xem tu xuất",
    module: "departures",
    description: "Xem thông tin tu xuất",
  },
  {
    name: "departures.create",
    display_name: "Ghi nhận",
    module: "departures",
    description: "Ghi nhận tu xuất",
  },
  {
    name: "departures.update",
    display_name: "Sửa thông tin",
    module: "departures",
    description: "Sửa thông tin tu xuất",
  },
  {
    name: "departures.delete",
    display_name: "Xóa bản ghi",
    module: "departures",
    description: "Xóa bản ghi tu xuất",
  },

  // Module: Reports (Báo Cáo)
  {
    name: "reports.view_dashboard",
    display_name: "Xem dashboard",
    module: "reports",
    description: "Xem dashboard tổng quan",
  },
  {
    name: "reports.view_by_age",
    display_name: "Báo cáo độ tuổi",
    module: "reports",
    description: "Xem báo cáo theo độ tuổi",
  },
  {
    name: "reports.view_by_stage",
    display_name: "Báo cáo giai đoạn",
    module: "reports",
    description: "Xem báo cáo theo giai đoạn",
  },
  {
    name: "reports.view_by_community",
    display_name: "Báo cáo cộng đoàn",
    module: "reports",
    description: "Xem báo cáo theo cộng đoàn",
  },
  {
    name: "reports.view_by_mission",
    display_name: "Báo cáo sứ vụ",
    module: "reports",
    description: "Xem báo cáo theo sứ vụ",
  },
  {
    name: "reports.view_by_education",
    display_name: "Báo cáo trình độ",
    module: "reports",
    description: "Xem báo cáo theo trình độ",
  },
  {
    name: "reports.export_excel",
    display_name: "Xuất Excel",
    module: "reports",
    description: "Xuất báo cáo Excel",
  },
  {
    name: "reports.export_pdf",
    display_name: "Xuất PDF",
    module: "reports",
    description: "Xuất báo cáo PDF",
  },

  // Module: Search (Tìm Kiếm)
  {
    name: "search.basic",
    display_name: "Tìm kiếm cơ bản",
    module: "search",
    description: "Sử dụng tìm kiếm cơ bản",
  },
  {
    name: "search.advanced",
    display_name: "Tìm kiếm nâng cao",
    module: "search",
    description: "Sử dụng tìm kiếm nâng cao",
  },
  {
    name: "search.export",
    display_name: "Xuất kết quả",
    module: "search",
    description: "Xuất kết quả tìm kiếm",
  },

  // Module: Users (Quản Lý User) - ADMIN ONLY
  {
    name: "users.view_list",
    display_name: "Xem danh sách",
    module: "users",
    description: "Xem danh sách người dùng",
  },
  {
    name: "users.view_detail",
    display_name: "Xem chi tiết",
    module: "users",
    description: "Xem chi tiết người dùng",
  },
  {
    name: "users.create",
    display_name: "Tạo user",
    module: "users",
    description: "Tạo người dùng mới",
  },
  {
    name: "users.update",
    display_name: "Sửa thông tin",
    module: "users",
    description: "Sửa thông tin người dùng",
  },
  {
    name: "users.delete",
    display_name: "Xóa user",
    module: "users",
    description: "Xóa người dùng",
  },
  {
    name: "users.reset_password",
    display_name: "Reset mật khẩu",
    module: "users",
    description: "Reset mật khẩu",
  },
  {
    name: "users.lock_unlock",
    display_name: "Khóa/Mở user",
    module: "users",
    description: "Khóa hoặc mở khóa",
  },
  {
    name: "users.assign_permissions",
    display_name: "Gán quyền",
    module: "users",
    description: "Gán quyền cho người dùng",
  },
  {
    name: "users.revoke_permissions",
    display_name: "Thu hồi quyền",
    module: "users",
    description: "Thu hồi quyền",
  },
  {
    name: "users.assign_communities",
    display_name: "Gán cộng đoàn",
    module: "users",
    description: "Gán vào cộng đoàn",
  },
  {
    name: "users.remove_communities",
    display_name: "Gỡ cộng đoàn",
    module: "users",
    description: "Gỡ khỏi cộng đoàn",
  },
  {
    name: "users.view_permissions",
    display_name: "Xem quyền",
    module: "users",
    description: "Xem quyền của user",
  },
  {
    name: "users.view_activity",
    display_name: "Xem lịch sử",
    module: "users",
    description: "Xem lịch sử hoạt động",
  },

  // Module: Audit Logs (ADMIN ONLY)
  {
    name: "audit.view",
    display_name: "Xem audit log",
    module: "audit",
    description: "Xem audit log hệ thống",
  },
  {
    name: "audit.export",
    display_name: "Xuất audit log",
    module: "audit",
    description: "Xuất audit log",
  },

  // Module: System (SUPER ADMIN ONLY)
  {
    name: "system.backup",
    display_name: "Backup DB",
    module: "system",
    description: "Sao lưu database",
  },
  {
    name: "system.restore",
    display_name: "Restore DB",
    module: "system",
    description: "Khôi phục database",
  },
  {
    name: "system.view_settings",
    display_name: "Xem cấu hình",
    module: "system",
    description: "Xem cấu hình hệ thống",
  },
  {
    name: "system.update_settings",
    display_name: "Sửa cấu hình",
    module: "system",
    description: "Sửa cấu hình hệ thống",
  },

  // Special Permission
  {
    name: "admin.full_access",
    display_name: "Quyền tối cao",
    module: "admin",
    description: "Quyền tối cao - bypass mọi kiểm tra",
  },

  // Module: Posts (Thông Tin / Bài đăng)
  {
    name: "posts.view",
    display_name: "Xem bài đăng",
    module: "posts",
    description: "Xem danh sách và chi tiết bài đăng",
  },
  {
    name: "posts.create",
    display_name: "Tạo bài đăng",
    module: "posts",
    description: "Tạo bài đăng mới",
  },
  {
    name: "posts.update",
    display_name: "Sửa bài đăng",
    module: "posts",
    description: "Chỉnh sửa bài đăng",
  },
  {
    name: "posts.delete",
    display_name: "Xóa bài đăng",
    module: "posts",
    description: "Xóa bài đăng",
  },
];

async function seedPermissions() {
  try {
    console.log("🚀 Bắt đầu seed permissions...");

    // Check if permissions table exists
    const [tables] = await db.query("SHOW TABLES LIKE 'permissions'");
    if (tables.length === 0) {
      console.error("❌ Bảng permissions chưa tồn tại!");
      process.exit(1);
    }

    // Add columns if not exists
    console.log("📋 Kiểm tra cấu trúc bảng permissions...");
    await db.query(`
      ALTER TABLE permissions 
      ADD COLUMN IF NOT EXISTS is_active TINYINT(1) DEFAULT 1,
      ADD COLUMN IF NOT EXISTS sort_order INT DEFAULT 0
    `);

    // Insert or update permissions
    console.log("💾 Insert/Update permissions...");
    for (const perm of permissions) {
      await db.query(
        `
        INSERT INTO permissions (name, display_name, module, description, is_active)
        VALUES (?, ?, ?, ?, 1)
        ON DUPLICATE KEY UPDATE 
          display_name = VALUES(display_name),
          description = VALUES(description),
          is_active = 1
      `,
        [perm.name, perm.display_name, perm.module, perm.description]
      );
    }

    // Grant all permissions to admin users
    console.log("🔑 Gán tất cả quyền cho admin...");
    await db.query(`
      INSERT IGNORE INTO user_permissions (user_id, permission_id, granted_by)
      SELECT u.id, p.id, u.id
      FROM users u
      CROSS JOIN permissions p
      WHERE u.is_admin = 1
    `);

    // Show summary
    const [count] = await db.query("SELECT COUNT(*) as total FROM permissions");
    const [modules] = await db.query(
      "SELECT DISTINCT module FROM permissions ORDER BY module"
    );

    console.log("\n✅ Seed thành công!");
    console.log(`📊 Tổng số permissions: ${count[0].total}`);
    console.log(`📦 Số modules: ${modules.length}`);
    console.log("📋 Danh sách modules:");
    modules.forEach((m) => console.log(`   - ${m.module}`));

    process.exit(0);
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
    console.error(error);
    process.exit(1);
  }
}

seedPermissions();
