const mysql = require("mysql2/promise");
const bcrypt = require("bcryptjs");
require("dotenv").config();

async function resetAndSeedDatabase() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hoidong_osp",
    multipleStatements: true,
  });

  try {
    console.log("🗑️  Bắt đầu xóa dữ liệu cũ...");

    // Disable foreign key checks
    await connection.execute("SET FOREIGN_KEY_CHECKS = 0");

    // Get all tables
    const [tables] = await connection.execute(
      `
      SELECT table_name FROM information_schema.tables 
      WHERE table_schema = ? AND table_type = 'BASE TABLE'
    `,
      [process.env.DB_NAME || "hoidong_osp"]
    );

    // Truncate all tables except migrations
    for (const table of tables) {
      const tableName = table.TABLE_NAME || table.table_name;
      if (tableName !== "migrations") {
        await connection.execute(`TRUNCATE TABLE \`${tableName}\``);
        console.log(`  ✓ Đã xóa dữ liệu bảng: ${tableName}`);
      }
    }

    // Re-enable foreign key checks
    await connection.execute("SET FOREIGN_KEY_CHECKS = 1");

    console.log("\n📝 Bắt đầu tạo dữ liệu mẫu...\n");

    // ============================================
    // 1. TẠO PERMISSIONS
    // ============================================
    console.log("1️⃣  Tạo permissions...");
    const permissionModules = [
      {
        module: "sisters",
        actions: ["view", "create", "edit", "delete", "export"],
      },
      {
        module: "communities",
        actions: ["view", "create", "edit", "delete", "assign"],
      },
      { module: "journey", actions: ["view", "create", "edit", "delete"] },
      { module: "health", actions: ["view", "create", "edit", "delete"] },
      { module: "education", actions: ["view", "create", "edit", "delete"] },
      {
        module: "missions",
        actions: ["view", "create", "edit", "delete", "assign"],
      },
      {
        module: "evaluations",
        actions: ["view", "create", "edit", "delete", "approve"],
      },
      { module: "reports", actions: ["view", "create", "export", "print"] },
      {
        module: "users",
        actions: [
          "view",
          "create",
          "edit",
          "delete",
          "manage_permissions",
          "assign_communities",
        ],
      },
      { module: "settings", actions: ["view", "edit", "backup", "audit"] },
    ];

    const displayNames = {
      "sisters.view": "Xem danh sách nữ tu",
      "sisters.create": "Thêm nữ tu mới",
      "sisters.edit": "Chỉnh sửa thông tin nữ tu",
      "sisters.delete": "Xóa nữ tu",
      "sisters.export": "Xuất dữ liệu nữ tu",
      "communities.view": "Xem danh sách cộng đoàn",
      "communities.create": "Thêm cộng đoàn mới",
      "communities.edit": "Chỉnh sửa cộng đoàn",
      "communities.delete": "Xóa cộng đoàn",
      "communities.assign": "Phân công nữ tu vào cộng đoàn",
      "journey.view": "Xem hành trình ơn gọi",
      "journey.create": "Thêm giai đoạn ơn gọi",
      "journey.edit": "Chỉnh sửa hành trình",
      "journey.delete": "Xóa giai đoạn",
      "health.view": "Xem hồ sơ sức khỏe",
      "health.create": "Thêm hồ sơ sức khỏe",
      "health.edit": "Chỉnh sửa sức khỏe",
      "health.delete": "Xóa hồ sơ sức khỏe",
      "education.view": "Xem thông tin học vấn",
      "education.create": "Thêm bằng cấp",
      "education.edit": "Chỉnh sửa học vấn",
      "education.delete": "Xóa bằng cấp",
      "missions.view": "Xem sứ vụ",
      "missions.create": "Tạo sứ vụ mới",
      "missions.edit": "Chỉnh sửa sứ vụ",
      "missions.delete": "Xóa sứ vụ",
      "missions.assign": "Phân công sứ vụ",
      "evaluations.view": "Xem đánh giá",
      "evaluations.create": "Tạo đánh giá",
      "evaluations.edit": "Chỉnh sửa đánh giá",
      "evaluations.delete": "Xóa đánh giá",
      "evaluations.approve": "Phê duyệt đánh giá",
      "reports.view": "Xem báo cáo",
      "reports.create": "Tạo báo cáo",
      "reports.export": "Xuất báo cáo",
      "reports.print": "In báo cáo",
      "users.view": "Xem danh sách người dùng",
      "users.create": "Tạo tài khoản mới",
      "users.edit": "Chỉnh sửa người dùng",
      "users.delete": "Xóa người dùng",
      "users.manage_permissions": "Quản lý phân quyền",
      "users.assign_communities": "Gán cộng đoàn cho người dùng",
      "settings.view": "Xem cài đặt",
      "settings.edit": "Thay đổi cài đặt",
      "settings.backup": "Sao lưu & khôi phục",
      "settings.audit": "Xem nhật ký hoạt động",
    };

    for (const pm of permissionModules) {
      for (const action of pm.actions) {
        const name = `${pm.module}.${action}`;
        const displayName = displayNames[name] || name;
        await connection.execute(
          `INSERT INTO permissions (name, display_name, description, module, is_active) 
           VALUES (?, ?, ?, ?, 1)`,
          [name, displayName, `Quyền ${displayName.toLowerCase()}`, pm.module]
        );
      }
    }
    console.log("  ✓ Đã tạo permissions");

    // ============================================
    // 2. TẠO USERS
    // ============================================
    console.log("2️⃣  Tạo users...");
    const hashedPassword = await bcrypt.hash("123456", 10);

    const users = [
      {
        username: "admin",
        email: "admin@osp.vn",
        full_name: "Quản trị viên",
        is_admin: 1,
        is_super_admin: 1,
        data_scope: "all",
      },
      {
        username: "superior",
        email: "superior@osp.vn",
        full_name: "Bề trên Tổng quyền",
        is_admin: 0,
        is_super_admin: 0,
        data_scope: "all",
      },
      {
        username: "secretary",
        email: "secretary@osp.vn",
        full_name: "Thư ký",
        is_admin: 0,
        is_super_admin: 0,
        data_scope: "all",
      },
      {
        username: "user_sg",
        email: "user_sg@osp.vn",
        full_name: "Người dùng Sài Gòn",
        is_admin: 0,
        is_super_admin: 0,
        data_scope: "community",
      },
      {
        username: "user_dn",
        email: "user_dn@osp.vn",
        full_name: "Người dùng Đà Nẵng",
        is_admin: 0,
        is_super_admin: 0,
        data_scope: "community",
      },
      {
        username: "user_hn",
        email: "user_hn@osp.vn",
        full_name: "Người dùng Hà Nội",
        is_admin: 0,
        is_super_admin: 0,
        data_scope: "community",
      },
    ];

    for (const user of users) {
      await connection.execute(
        `INSERT INTO users (username, password, email, full_name, is_admin, is_super_admin, data_scope, is_active) 
         VALUES (?, ?, ?, ?, ?, ?, ?, 1)`,
        [
          user.username,
          hashedPassword,
          user.email,
          user.full_name,
          user.is_admin,
          user.is_super_admin,
          user.data_scope,
        ]
      );
    }
    console.log("  ✓ Đã tạo 6 users (password: 123456)");

    // ============================================
    // 3. TẠO COMMUNITIES
    // ============================================
    console.log("3️⃣  Tạo communities...");
    const communities = [
      {
        code: "MH",
        name: "Nhà Mẹ - Thủ Đức",
        address: "123 Đường Võ Văn Ngân, Thủ Đức, TP.HCM",
        phone: "028-1234567",
        email: "nhame@osp.vn",
      },
      {
        code: "SG01",
        name: "Cộng đoàn Sài Gòn 1",
        address: "456 Đường Nguyễn Văn Trỗi, Quận 3, TP.HCM",
        phone: "028-2345678",
        email: "sg01@osp.vn",
      },
      {
        code: "SG02",
        name: "Cộng đoàn Sài Gòn 2",
        address: "789 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM",
        phone: "028-3456789",
        email: "sg02@osp.vn",
      },
      {
        code: "DN01",
        name: "Cộng đoàn Đà Nẵng",
        address: "12 Đường Trần Phú, Hải Châu, Đà Nẵng",
        phone: "0236-123456",
        email: "dn01@osp.vn",
      },
      {
        code: "HN01",
        name: "Cộng đoàn Hà Nội",
        address: "34 Đường Hoàng Diệu, Ba Đình, Hà Nội",
        phone: "024-1234567",
        email: "hn01@osp.vn",
      },
      {
        code: "CT01",
        name: "Cộng đoàn Cần Thơ",
        address: "56 Đường 30/4, Ninh Kiều, Cần Thơ",
        phone: "0292-123456",
        email: "ct01@osp.vn",
      },
    ];

    for (const comm of communities) {
      await connection.execute(
        `INSERT INTO communities (code, name, address, phone, email, status) VALUES (?, ?, ?, ?, ?, 'active')`,
        [comm.code, comm.name, comm.address, comm.phone, comm.email]
      );
    }
    console.log("  ✓ Đã tạo 6 cộng đoàn");

    // ============================================
    // 4. TẠO SISTERS
    // ============================================
    console.log("4️⃣  Tạo sisters...");
    const sisters = [
      {
        code: "SR001",
        saint_name: "Maria",
        birth_name: "Nguyễn Thị Mai",
        dob: "1985-03-15",
        pob: "TP.HCM",
        status: "active",
        current_stage: "perpetual_vows",
      },
      {
        code: "SR002",
        saint_name: "Anna",
        birth_name: "Trần Thị Hoa",
        dob: "1990-07-22",
        pob: "Đà Nẵng",
        status: "active",
        current_stage: "perpetual_vows",
      },
      {
        code: "SR003",
        saint_name: "Teresa",
        birth_name: "Lê Thị Lan",
        dob: "1988-11-08",
        pob: "Hà Nội",
        status: "active",
        current_stage: "temporary_vows",
      },
      {
        code: "SR004",
        saint_name: "Rosa",
        birth_name: "Phạm Thị Cúc",
        dob: "1992-05-30",
        pob: "Cần Thơ",
        status: "active",
        current_stage: "perpetual_vows",
      },
      {
        code: "SR005",
        saint_name: "Clara",
        birth_name: "Hoàng Thị Đào",
        dob: "1987-09-12",
        pob: "Huế",
        status: "active",
        current_stage: "temporary_vows",
      },
      {
        code: "SR006",
        saint_name: "Agnes",
        birth_name: "Vũ Thị Hồng",
        dob: "1995-01-25",
        pob: "Hải Phòng",
        status: "active",
        current_stage: "novice",
      },
      {
        code: "SR007",
        saint_name: "Monica",
        birth_name: "Đặng Thị Tuyết",
        dob: "1993-04-18",
        pob: "Bình Dương",
        status: "active",
        current_stage: "perpetual_vows",
      },
      {
        code: "SR008",
        saint_name: "Lucia",
        birth_name: "Bùi Thị Nga",
        dob: "1989-08-05",
        pob: "Đồng Nai",
        status: "active",
        current_stage: "temporary_vows",
      },
      {
        code: "SR009",
        saint_name: "Catherine",
        birth_name: "Ngô Thị Linh",
        dob: "1991-12-10",
        pob: "Vũng Tàu",
        status: "active",
        current_stage: "perpetual_vows",
      },
      {
        code: "SR010",
        saint_name: "Theresa",
        birth_name: "Đinh Thị Phương",
        dob: "1986-06-28",
        pob: "Nha Trang",
        status: "active",
        current_stage: "temporary_vows",
      },
      {
        code: "SR011",
        saint_name: "Bernadette",
        birth_name: "Lý Thị Thảo",
        dob: "1994-02-14",
        pob: "Đà Lạt",
        status: "active",
        current_stage: "novice",
      },
      {
        code: "SR012",
        saint_name: "Josephine",
        birth_name: "Hồ Thị Yến",
        dob: "1988-10-03",
        pob: "Quảng Nam",
        status: "active",
        current_stage: "temporary_vows",
      },
      {
        code: "SR013",
        saint_name: "Magdalene",
        birth_name: "Cao Thị Xuân",
        dob: "1996-07-17",
        pob: "Bắc Ninh",
        status: "active",
        current_stage: "postulant",
      },
      {
        code: "SR014",
        saint_name: "Veronica",
        birth_name: "Tạ Thị Thu",
        dob: "1990-03-25",
        pob: "Nam Định",
        status: "active",
        current_stage: "temporary_vows",
      },
      {
        code: "SR015",
        saint_name: "Elizabeth",
        birth_name: "Dương Thị Hạnh",
        dob: "1985-11-20",
        pob: "Thanh Hóa",
        status: "active",
        current_stage: "perpetual_vows",
      },
    ];

    for (const sister of sisters) {
      await connection.execute(
        `INSERT INTO sisters (code, saint_name, birth_name, date_of_birth, place_of_birth, status, current_stage, created_by) 
         VALUES (?, ?, ?, ?, ?, ?, ?, 1)`,
        [
          sister.code,
          sister.saint_name,
          sister.birth_name,
          sister.dob,
          sister.pob,
          sister.status,
          sister.current_stage,
        ]
      );
    }
    console.log("  ✓ Đã tạo 15 nữ tu");

    // ============================================
    // 5. TẠO COMMUNITY ASSIGNMENTS
    // ============================================
    console.log("5️⃣  Tạo community assignments...");
    const assignments = [
      {
        sister_id: 1,
        community_id: 1,
        role: "superior",
        start_date: "2020-01-01",
      },
      {
        sister_id: 2,
        community_id: 1,
        role: "deputy",
        start_date: "2020-01-01",
      },
      {
        sister_id: 3,
        community_id: 1,
        role: "member",
        start_date: "2021-06-01",
      },
      {
        sister_id: 4,
        community_id: 2,
        role: "superior",
        start_date: "2019-09-01",
      },
      {
        sister_id: 5,
        community_id: 2,
        role: "member",
        start_date: "2020-03-01",
      },
      {
        sister_id: 6,
        community_id: 2,
        role: "member",
        start_date: "2022-01-01",
      },
      {
        sister_id: 7,
        community_id: 3,
        role: "superior",
        start_date: "2021-01-01",
      },
      {
        sister_id: 8,
        community_id: 3,
        role: "member",
        start_date: "2021-01-01",
      },
      {
        sister_id: 9,
        community_id: 4,
        role: "superior",
        start_date: "2020-06-01",
      },
      {
        sister_id: 10,
        community_id: 4,
        role: "member",
        start_date: "2020-06-01",
      },
      {
        sister_id: 11,
        community_id: 5,
        role: "superior",
        start_date: "2022-01-01",
      },
      {
        sister_id: 12,
        community_id: 5,
        role: "member",
        start_date: "2022-01-01",
      },
      {
        sister_id: 13,
        community_id: 6,
        role: "superior",
        start_date: "2021-09-01",
      },
      {
        sister_id: 14,
        community_id: 6,
        role: "member",
        start_date: "2021-09-01",
      },
      {
        sister_id: 15,
        community_id: 6,
        role: "member",
        start_date: "2023-01-01",
      },
    ];

    for (const asgn of assignments) {
      await connection.execute(
        `INSERT INTO community_assignments (sister_id, community_id, role, start_date) VALUES (?, ?, ?, ?)`,
        [asgn.sister_id, asgn.community_id, asgn.role, asgn.start_date]
      );
    }

    // Update current_community_id in sisters table
    await connection.execute(`
      UPDATE sisters s 
      SET current_community_id = (
        SELECT ca.community_id 
        FROM community_assignments ca 
        WHERE ca.sister_id = s.id AND ca.end_date IS NULL 
        ORDER BY ca.start_date DESC LIMIT 1
      )
    `);
    console.log(
      "  ✓ Đã tạo community assignments và cập nhật current_community_id"
    );

    // ============================================
    // 6. TẠO USER COMMUNITIES
    // ============================================
    console.log("6️⃣  Tạo user communities...");
    // user_sg (id=4) -> SG01 (id=2), SG02 (id=3)
    // user_dn (id=5) -> DN01 (id=4)
    // user_hn (id=6) -> HN01 (id=5)
    const userCommunities = [
      { user_id: 4, community_id: 2, is_primary: 1 },
      { user_id: 4, community_id: 3, is_primary: 0 },
      { user_id: 5, community_id: 4, is_primary: 1 },
      { user_id: 6, community_id: 5, is_primary: 1 },
    ];

    for (const uc of userCommunities) {
      await connection.execute(
        `INSERT INTO user_communities (user_id, community_id, is_primary) VALUES (?, ?, ?)`,
        [uc.user_id, uc.community_id, uc.is_primary]
      );
    }
    console.log("  ✓ Đã gán cộng đoàn cho users");

    // ============================================
    // 7. GÁN PERMISSIONS CHO ADMIN
    // ============================================
    console.log("7️⃣  Gán permissions cho admin...");
    const [allPermissions] = await connection.execute(
      "SELECT id FROM permissions"
    );
    for (const perm of allPermissions) {
      await connection.execute(
        "INSERT INTO user_permissions (user_id, permission_id) VALUES (1, ?)",
        [perm.id]
      );
    }
    console.log("  ✓ Admin có toàn quyền");

    // Gán quyền xem cho users khác
    const viewPermissions = [
      "sisters.view",
      "communities.view",
      "journey.view",
      "health.view",
      "education.view",
      "missions.view",
    ];
    const [viewPerms] = await connection.execute(
      `SELECT id FROM permissions WHERE name IN (${viewPermissions
        .map(() => "?")
        .join(",")})`,
      viewPermissions
    );
    for (let userId = 2; userId <= 6; userId++) {
      for (const perm of viewPerms) {
        await connection.execute(
          "INSERT INTO user_permissions (user_id, permission_id) VALUES (?, ?)",
          [userId, perm.id]
        );
      }
    }
    console.log("  ✓ Đã gán quyền xem cho users khác");

    // ============================================
    // 8. TẠO VOCATION JOURNEY
    // ============================================
    console.log("8️⃣  Tạo vocation journey...");
    const journeys = [
      {
        sister_id: 1,
        stage: "perpetual_vows",
        start_date: "2010-08-15",
        community_id: 1,
      },
      {
        sister_id: 2,
        stage: "perpetual_vows",
        start_date: "2015-08-15",
        community_id: 1,
      },
      {
        sister_id: 3,
        stage: "temporary_vows",
        start_date: "2020-08-15",
        community_id: 1,
      },
      {
        sister_id: 4,
        stage: "perpetual_vows",
        start_date: "2012-08-15",
        community_id: 2,
      },
      {
        sister_id: 5,
        stage: "temporary_vows",
        start_date: "2021-08-15",
        community_id: 2,
      },
      {
        sister_id: 6,
        stage: "novice",
        start_date: "2023-02-01",
        community_id: 2,
      },
      {
        sister_id: 7,
        stage: "perpetual_vows",
        start_date: "2014-08-15",
        community_id: 3,
      },
      {
        sister_id: 8,
        stage: "temporary_vows",
        start_date: "2022-08-15",
        community_id: 3,
      },
      {
        sister_id: 9,
        stage: "perpetual_vows",
        start_date: "2013-08-15",
        community_id: 4,
      },
      {
        sister_id: 10,
        stage: "temporary_vows",
        start_date: "2021-08-15",
        community_id: 4,
      },
      {
        sister_id: 11,
        stage: "novice",
        start_date: "2023-06-01",
        community_id: 5,
      },
      {
        sister_id: 12,
        stage: "temporary_vows",
        start_date: "2019-08-15",
        community_id: 5,
      },
      {
        sister_id: 13,
        stage: "postulant",
        start_date: "2024-01-15",
        community_id: 6,
      },
      {
        sister_id: 14,
        stage: "temporary_vows",
        start_date: "2020-08-15",
        community_id: 6,
      },
      {
        sister_id: 15,
        stage: "perpetual_vows",
        start_date: "2011-08-15",
        community_id: 6,
      },
    ];

    for (const j of journeys) {
      await connection.execute(
        `INSERT INTO vocation_journey (sister_id, stage, start_date, community_id) VALUES (?, ?, ?, ?)`,
        [j.sister_id, j.stage, j.start_date, j.community_id]
      );
    }
    console.log("  ✓ Đã tạo vocation journey");

    // ============================================
    // 9. TẠO HEALTH RECORDS
    // ============================================
    console.log("9️⃣  Tạo health records...");
    const healthRecords = [
      {
        sister_id: 1,
        general_health: "good",
        checkup_date: "2024-06-15",
        checkup_place: "Bệnh viện Thống Nhất",
      },
      {
        sister_id: 2,
        general_health: "good",
        checkup_date: "2024-06-15",
        checkup_place: "Bệnh viện Thống Nhất",
      },
      {
        sister_id: 3,
        general_health: "average",
        chronic_diseases: "Cao huyết áp nhẹ",
        checkup_date: "2024-05-20",
        checkup_place: "Bệnh viện Chợ Rẫy",
      },
      {
        sister_id: 5,
        general_health: "good",
        checkup_date: "2024-07-01",
        checkup_place: "Bệnh viện Đà Nẵng",
      },
      {
        sister_id: 7,
        general_health: "weak",
        chronic_diseases: "Tiểu đường type 2",
        checkup_date: "2024-04-10",
        checkup_place: "Bệnh viện 115",
      },
      {
        sister_id: 10,
        general_health: "good",
        checkup_date: "2024-08-05",
        checkup_place: "Bệnh viện Bạch Mai",
      },
    ];

    for (const hr of healthRecords) {
      await connection.execute(
        `INSERT INTO health_records (sister_id, general_health, chronic_diseases, checkup_date, checkup_place) 
         VALUES (?, ?, ?, ?, ?)`,
        [
          hr.sister_id,
          hr.general_health,
          hr.chronic_diseases || null,
          hr.checkup_date,
          hr.checkup_place,
        ]
      );
    }
    console.log("  ✓ Đã tạo health records");

    // ============================================
    // 10. TẠO EDUCATION RECORDS
    // ============================================
    console.log("🔟 Tạo education records...");
    const educations = [
      {
        sister_id: 1,
        level: "master",
        major: "Thần học",
        institution: "Học viện Công giáo Việt Nam",
      },
      {
        sister_id: 2,
        level: "bachelor",
        major: "Sư phạm",
        institution: "Đại học Sư phạm TP.HCM",
      },
      {
        sister_id: 4,
        level: "master",
        major: "Quản trị giáo dục",
        institution: "Đại học Giáo dục - ĐHQG Hà Nội",
      },
      {
        sister_id: 7,
        level: "bachelor",
        major: "Điều dưỡng",
        institution: "Đại học Y Dược TP.HCM",
      },
      {
        sister_id: 9,
        level: "doctorate",
        major: "Triết học",
        institution: "Đại học Gregorian, Roma",
      },
      {
        sister_id: 11,
        level: "bachelor",
        major: "Truyền thông",
        institution: "Đại học KHXH&NV TP.HCM",
      },
    ];

    for (const edu of educations) {
      await connection.execute(
        `INSERT INTO education (sister_id, level, major, institution) VALUES (?, ?, ?, ?)`,
        [edu.sister_id, edu.level, edu.major, edu.institution]
      );
    }
    console.log("  ✓ Đã tạo education records");

    // ============================================
    // 11. TẠO MISSIONS
    // ============================================
    console.log("1️⃣1️⃣ Tạo missions...");
    const missions = [
      {
        sister_id: 1,
        field: "education",
        specific_role: "Hiệu trưởng trường Mầm non",
        start_date: "2018-09-01",
      },
      {
        sister_id: 2,
        field: "education",
        specific_role: "Giáo viên Tiểu học",
        start_date: "2016-09-01",
      },
      {
        sister_id: 4,
        field: "education",
        specific_role: "Quản lý trường THCS",
        start_date: "2015-09-01",
      },
      {
        sister_id: 7,
        field: "healthcare",
        specific_role: "Điều dưỡng trưởng",
        start_date: "2019-01-01",
      },
      {
        sister_id: 9,
        field: "pastoral",
        specific_role: "Huấn luyện viên",
        start_date: "2017-01-01",
      },
      {
        sister_id: 11,
        field: "media",
        specific_role: "Biên tập viên",
        start_date: "2023-01-01",
      },
      {
        sister_id: 13,
        field: "social",
        specific_role: "Nhân viên xã hội",
        start_date: "2024-01-01",
      },
    ];

    for (const m of missions) {
      await connection.execute(
        `INSERT INTO missions (sister_id, field, specific_role, start_date) VALUES (?, ?, ?, ?)`,
        [m.sister_id, m.field, m.specific_role, m.start_date]
      );
    }
    console.log("  ✓ Đã tạo missions");

    // ============================================
    // 12. TẠO EVALUATIONS
    // ============================================
    console.log("1️⃣2️⃣ Tạo evaluations...");
    const evaluations = [
      {
        sister_id: 3,
        period: "2024-H1",
        evaluator_id: 1,
        spiritual: 8,
        community: 9,
        mission: 8,
        personality: 9,
        obedience: 9,
      },
      {
        sister_id: 5,
        period: "2024-H1",
        evaluator_id: 1,
        spiritual: 7,
        community: 8,
        mission: 8,
        personality: 8,
        obedience: 8,
      },
      {
        sister_id: 6,
        period: "2024-H1",
        evaluator_id: 1,
        spiritual: 8,
        community: 8,
        mission: 7,
        personality: 8,
        obedience: 9,
      },
      {
        sister_id: 8,
        period: "2024-H1",
        evaluator_id: 1,
        spiritual: 9,
        community: 9,
        mission: 9,
        personality: 9,
        obedience: 9,
      },
    ];

    for (const ev of evaluations) {
      await connection.execute(
        `INSERT INTO evaluations (sister_id, evaluation_period, evaluator_id, spiritual_life_score, community_life_score, mission_score, personality_score, obedience_score) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          ev.sister_id,
          ev.period,
          ev.evaluator_id,
          ev.spiritual,
          ev.community,
          ev.mission,
          ev.personality,
          ev.obedience,
        ]
      );
    }
    console.log("  ✓ Đã tạo evaluations");

    console.log("\n✅ HOÀN TẤT! Database đã được reset và tạo dữ liệu mẫu.\n");
    console.log("📋 Thông tin đăng nhập:");
    console.log(
      "   ┌──────────────┬──────────────┬─────────────────────────────────┐"
    );
    console.log(
      "   │ Username     │ Password     │ Mô tả                           │"
    );
    console.log(
      "   ├──────────────┼──────────────┼─────────────────────────────────┤"
    );
    console.log(
      "   │ admin        │ 123456       │ Quản trị viên (toàn quyền)      │"
    );
    console.log(
      "   │ superior     │ 123456       │ Bề trên Tổng quyền              │"
    );
    console.log(
      "   │ secretary    │ 123456       │ Thư ký                          │"
    );
    console.log(
      "   │ user_sg      │ 123456       │ Người dùng Sài Gòn (2 cộng đoàn)│"
    );
    console.log(
      "   │ user_dn      │ 123456       │ Người dùng Đà Nẵng              │"
    );
    console.log(
      "   │ user_hn      │ 123456       │ Người dùng Hà Nội               │"
    );
    console.log(
      "   └──────────────┴──────────────┴─────────────────────────────────┘"
    );
    console.log("\n📊 Dữ liệu mẫu:");
    console.log("   • 6 cộng đoàn (Nhà Mẹ, SG01, SG02, DN01, HN01, CT01)");
    console.log("   • 15 nữ tu với thông tin đầy đủ");
    console.log("   • Hồ sơ sức khỏe, học vấn, sứ vụ, đánh giá");
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
    throw error;
  } finally {
    await connection.end();
  }
}

resetAndSeedDatabase().catch(console.error);
