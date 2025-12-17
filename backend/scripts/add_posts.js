// backend/scripts/add_posts.js
const mysql = require("mysql2/promise");
require("dotenv").config();

const posts = [
  {
    title: "Thông báo lịch tĩnh tâm năm 2024",
    category: "thong-bao",
    summary:
      "Kính gửi quý chị em, Ban tổ chức xin thông báo về lịch tĩnh tâm năm 2024.",
    is_important: 1,
    view_count: 320,
  },
  {
    title: "Kỷ niệm 50 năm thành lập Hội Dòng",
    category: "su-kien",
    summary: "Mừng kỷ niệm 50 năm ngày thành lập Hội Dòng Mến Thánh Giá.",
    is_important: 1,
    view_count: 456,
  },
  {
    title: "Hướng dẫn quy trình xin phép nghỉ",
    category: "huong-dan",
    summary: "Quy trình và thủ tục xin phép nghỉ cho các nữ tu trong Hội Dòng.",
    is_important: 0,
    view_count: 178,
  },
  {
    title: "Chia sẻ kinh nghiệm truyền giáo tại vùng cao",
    category: "chia-se",
    summary:
      "Những câu chuyện cảm động từ chuyến truyền giáo tại vùng cao Tây Bắc.",
    is_important: 0,
    view_count: 234,
  },
  {
    title: "Thông báo về việc đóng quỹ hàng tháng",
    category: "thong-bao",
    summary: "Nhắc nhở các cộng đoàn về việc đóng quỹ hàng tháng.",
    is_important: 0,
    view_count: 89,
  },
  {
    title: "Chương trình đào tạo Huấn luyện viên 2024",
    category: "su-kien",
    summary: "Khóa đào tạo dành cho các Huấn luyện viên trong Hội Dòng.",
    is_important: 0,
    view_count: 145,
  },
  {
    title: "Cập nhật nội quy sinh hoạt cộng đoàn",
    category: "huong-dan",
    summary: "Một số điều chỉnh trong nội quy sinh hoạt cộng đoàn.",
    is_important: 0,
    view_count: 267,
  },
  {
    title: "Lễ khấn trọn đời - Khóa 2024",
    category: "su-kien",
    summary: "Thông tin về lễ khấn trọn đời của 5 nữ tu khóa 2024.",
    is_important: 1,
    view_count: 389,
  },
  {
    title: "Suy tư mùa Vọng: Chờ đợi trong hy vọng",
    category: "chia-se",
    summary: "Bài suy tư về ý nghĩa của việc chờ đợi trong mùa Vọng.",
    is_important: 0,
    view_count: 198,
  },
  {
    title: "Thông tin liên hệ các cộng đoàn",
    category: "khac",
    summary: "Danh sách thông tin liên hệ cập nhật của các cộng đoàn.",
    is_important: 0,
    view_count: 156,
  },
];

(async () => {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  console.log("Adding 10 sample posts...");

  for (let i = 0; i < posts.length; i++) {
    const p = posts[i];
    await conn.execute(
      `INSERT INTO posts (title, category, summary, content, is_pinned, is_important, tags, attachments, author_id, view_count, status, created_at, updated_at) 
       VALUES (?, ?, ?, ?, 0, ?, '[]', '[]', 1, ?, 'published', NOW(), NOW())`,
      [
        p.title,
        p.category,
        p.summary,
        "<p>" + p.summary + "</p>",
        p.is_important,
        p.view_count,
      ]
    );
    console.log("✓ Created:", p.title);
  }

  const [rows] = await conn.execute(
    "SELECT COUNT(*) as total FROM posts WHERE deleted_at IS NULL"
  );
  console.log("\nTotal posts:", rows[0].total);
  await conn.end();
  process.exit(0);
})();
