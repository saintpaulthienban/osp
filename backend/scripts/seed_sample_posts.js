// backend/scripts/seed_sample_posts.js
// Tạo 10 bài đăng mẫu

const mysql = require("mysql2/promise");
require("dotenv").config();

const samplePosts = [
  {
    title: "Thông báo lịch tĩnh tâm năm 2024",
    category: "thong-bao",
    summary:
      "Kính gửi quý chị em, Ban tổ chức xin thông báo về lịch tĩnh tâm năm 2024.",
    content:
      "<p>Kính gửi quý chị em trong Hội Dòng,</p><p>Ban tổ chức xin trân trọng thông báo về lịch tĩnh tâm năm 2024. Chương trình sẽ diễn ra từ ngày 15-20/01/2024 tại Trung tâm Mục vụ.</p><p>Mọi chị em vui lòng đăng ký trước ngày 10/01/2024.</p>",
    is_pinned: 0,
    is_important: 1,
    tags: JSON.stringify(["tĩnh tâm", "thông báo"]),
    view_count: 320,
    status: "published",
  },
  {
    title: "Kỷ niệm 50 năm thành lập Hội Dòng",
    category: "su-kien",
    summary: "Mừng kỷ niệm 50 năm ngày thành lập Hội Dòng Mến Thánh Giá.",
    content:
      "<p>Hội Dòng Mến Thánh Giá vui mừng kỷ niệm 50 năm ngày thành lập (1974-2024).</p><p>Lễ mừng sẽ được tổ chức long trọng vào ngày 19/03/2024 với sự tham dự của Đức Giám Mục giáo phận.</p>",
    is_pinned: 0,
    is_important: 1,
    tags: JSON.stringify(["kỷ niệm", "50 năm"]),
    view_count: 456,
    status: "published",
  },
  {
    title: "Hướng dẫn quy trình xin phép nghỉ",
    category: "huong-dan",
    summary: "Quy trình và thủ tục xin phép nghỉ cho các nữ tu trong Hội Dòng.",
    content:
      "<p>Để đảm bảo tính kỷ luật và trật tự, các nữ tu cần tuân thủ quy trình xin phép nghỉ như sau:</p><ol><li>Nộp đơn xin phép trước 7 ngày</li><li>Được Bề trên Cộng đoàn ký duyệt</li><li>Báo cáo với Văn phòng Hội Dòng</li></ol>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["hướng dẫn", "quy trình"]),
    view_count: 178,
    status: "published",
  },
  {
    title: "Chia sẻ kinh nghiệm truyền giáo tại vùng cao",
    category: "chia-se",
    summary:
      "Những câu chuyện cảm động từ chuyến truyền giáo tại vùng cao Tây Bắc.",
    content:
      "<p>Sau 3 tháng làm việc tại vùng cao Tây Bắc, nhóm truyền giáo đã có nhiều trải nghiệm đáng nhớ.</p><p>Bà con dân tộc thiểu số rất thật thà và hiếu khách. Cuộc sống tuy khó khăn nhưng tình yêu thương luôn tràn đầy.</p>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["truyền giáo", "vùng cao"]),
    view_count: 234,
    status: "published",
  },
  {
    title: "Thông báo về việc đóng quỹ hàng tháng",
    category: "thong-bao",
    summary: "Nhắc nhở các cộng đoàn về việc đóng quỹ hàng tháng.",
    content:
      "<p>Kính gửi các Bề trên Cộng đoàn,</p><p>Văn phòng Hội Dòng xin nhắc nhở về việc đóng quỹ hàng tháng. Hạn chót nộp quỹ tháng này là ngày 25.</p><p>Xin vui lòng chuyển khoản theo thông tin đã cung cấp.</p>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["quỹ", "thông báo"]),
    view_count: 89,
    status: "published",
  },
  {
    title: "Chương trình đào tạo Huấn luyện viên 2024",
    category: "su-kien",
    summary: "Khóa đào tạo dành cho các Huấn luyện viên trong Hội Dòng.",
    content:
      "<p>Hội Dòng sẽ tổ chức khóa đào tạo Huấn luyện viên từ ngày 01-15/02/2024.</p><p>Nội dung bao gồm:</p><ul><li>Phương pháp huấn luyện mới</li><li>Tâm lý học phát triển</li><li>Kỹ năng đồng hành thiêng liêng</li></ul>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["đào tạo", "huấn luyện"]),
    view_count: 145,
    status: "published",
  },
  {
    title: "Cập nhật nội quy sinh hoạt cộng đoàn",
    category: "huong-dan",
    summary:
      "Một số điều chỉnh trong nội quy sinh hoạt cộng đoàn áp dụng từ tháng 1/2024.",
    content:
      "<p>Để phù hợp với tình hình mới, Ban lãnh đạo Hội Dòng đã điều chỉnh một số nội dung trong Nội quy sinh hoạt cộng đoàn.</p><p>Các điều chỉnh chính:</p><ol><li>Giờ kinh sáng: 5h30</li><li>Giờ cơm tối: 18h00</li><li>Giờ chầu Thánh Thể: Thứ Năm 19h00</li></ol>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["nội quy", "cộng đoàn"]),
    view_count: 267,
    status: "published",
  },
  {
    title: "Lễ khấn trọn đời - Khóa 2024",
    category: "su-kien",
    summary: "Thông tin về lễ khấn trọn đời của 5 nữ tu khóa 2024.",
    content:
      "<p>Hội Dòng vui mừng thông báo về Lễ Khấn Trọn Đời của 5 nữ tu khóa 2024.</p><p>Lễ sẽ được cử hành vào lúc 9h00 ngày 25/03/2024 tại Nhà Mẹ.</p><p>Kính mời quý cha, quý khách và gia đình các tân khấn sinh đến tham dự.</p>",
    is_pinned: 0,
    is_important: 1,
    tags: JSON.stringify(["khấn dòng", "lễ"]),
    view_count: 389,
    status: "published",
  },
  {
    title: "Suy tư mùa Vọng: Chờ đợi trong hy vọng",
    category: "chia-se",
    summary: "Bài suy tư về ý nghĩa của việc chờ đợi trong mùa Vọng.",
    content:
      "<p>Mùa Vọng là thời gian đặc biệt để chúng ta chuẩn bị tâm hồn đón Chúa.</p><p>Chờ đợi không phải là thụ động, mà là chủ động chuẩn bị tâm hồn, làm mới đời sống thiêng liêng, và mở rộng tâm hồn đón nhận ân sủng.</p>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["mùa vọng", "suy tư"]),
    view_count: 198,
    status: "published",
  },
  {
    title: "Thông tin liên hệ các cộng đoàn",
    category: "khac",
    summary:
      "Danh sách thông tin liên hệ cập nhật của các cộng đoàn trong Hội Dòng.",
    content:
      "<p>Danh sách thông tin liên hệ các cộng đoàn đã được cập nhật.</p><p>Quý chị em có thể tải file đính kèm để xem chi tiết.</p><p>Mọi thay đổi vui lòng báo về Văn phòng Hội Dòng.</p>",
    is_pinned: 0,
    is_important: 0,
    tags: JSON.stringify(["liên hệ", "cộng đoàn"]),
    view_count: 156,
    status: "published",
  },
];

async function seedPosts() {
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "",
    database: process.env.DB_NAME || "hr_records",
  });

  try {
    console.log("🌱 Bắt đầu tạo bài đăng mẫu...\n");

    // Get admin user id
    const [users] = await connection.execute(
      "SELECT id FROM users WHERE role = 'admin' LIMIT 1"
    );
    const authorId = users.length > 0 ? users[0].id : 1;

    // Clear existing sample posts (keep first 3)
    await connection.execute("DELETE FROM posts WHERE id > 3");
    console.log("✓ Đã xóa các bài đăng mẫu cũ\n");

    // Insert new sample posts
    for (let i = 0; i < samplePosts.length; i++) {
      const post = samplePosts[i];
      const createdAt = new Date(Date.now() - i * 2 * 24 * 60 * 60 * 1000); // Mỗi bài cách nhau 2 ngày

      await connection.execute(
        `INSERT INTO posts (title, category, summary, content, is_pinned, is_important, tags, attachments, author_id, view_count, status, created_at, updated_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, '[]', ?, ?, ?, ?, ?)`,
        [
          post.title,
          post.category,
          post.summary,
          post.content,
          post.is_pinned,
          post.is_important,
          post.tags,
          authorId,
          post.view_count,
          post.status,
          createdAt,
          createdAt,
        ]
      );
      console.log(`✓ Đã tạo: "${post.title}"`);
    }

    // Count total posts
    const [countResult] = await connection.execute(
      "SELECT COUNT(*) as total FROM posts WHERE deleted_at IS NULL"
    );
    console.log(`\n✅ Hoàn tất! Tổng số bài đăng: ${countResult[0].total}`);
  } catch (error) {
    console.error("❌ Lỗi:", error.message);
  } finally {
    await connection.end();
    process.exit();
  }
}

seedPosts();
