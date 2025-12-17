-- Migration: Create posts table
-- Run this script to create the posts table for the Thong Tin feature

CREATE TABLE IF NOT EXISTS posts (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  category ENUM('thong-bao', 'su-kien', 'huong-dan', 'chia-se', 'khac') NOT NULL DEFAULT 'thong-bao',
  summary TEXT,
  content LONGTEXT NOT NULL,
  is_pinned TINYINT(1) DEFAULT 0,
  is_important TINYINT(1) DEFAULT 0,
  tags JSON,
  attachments JSON,
  author_id INT,
  view_count INT DEFAULT 0,
  status ENUM('draft', 'published') DEFAULT 'published',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  deleted_at TIMESTAMP NULL,
  FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE SET NULL,
  INDEX idx_category (category),
  INDEX idx_is_pinned (is_pinned),
  INDEX idx_is_important (is_important),
  INDEX idx_created_at (created_at),
  INDEX idx_deleted_at (deleted_at),
  FULLTEXT INDEX idx_search (title, summary, content)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add posts permissions
INSERT INTO permissions (name, display_name, module, description, is_active, created_at, updated_at) VALUES
('posts.view', 'Xem bài đăng', 'posts', 'Xem danh sách và chi tiết bài đăng', 1, NOW(), NOW()),
('posts.create', 'Tạo bài đăng', 'posts', 'Tạo bài đăng mới', 1, NOW(), NOW()),
('posts.update', 'Sửa bài đăng', 'posts', 'Chỉnh sửa bài đăng', 1, NOW(), NOW()),
('posts.delete', 'Xóa bài đăng', 'posts', 'Xóa bài đăng', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE display_name = VALUES(display_name), description = VALUES(description), module = VALUES(module);

-- Insert sample data
INSERT INTO posts (title, category, summary, content, is_pinned, is_important, tags, author_id, view_count, created_at) VALUES
(
  'Thông báo quan trọng về lịch sinh hoạt tháng 12/2024',
  'thong-bao',
  'Kính gửi quý chị em trong Hội Dòng, Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024.',
  '<p>Kính gửi quý chị em trong Hội Dòng,</p><p>Ban tổ chức xin trân trọng thông báo về lịch sinh hoạt trong tháng 12/2024. Các hoạt động sẽ được tổ chức theo kế hoạch đã được phê duyệt.</p><h4>Lịch trình chi tiết</h4><ul><li><strong>20/12/2024:</strong> Họp cộng đoàn định kỳ</li><li><strong>24/12/2024:</strong> Lễ Giáng sinh - Thánh lễ đêm</li><li><strong>28-31/12:</strong> Tĩnh tâm cuối năm</li></ul>',
  1,
  1,
  '["thông báo", "lịch sinh hoạt", "tháng 12"]',
  1,
  245,
  NOW() - INTERVAL 2 DAY
),
(
  'Mừng lễ Giáng sinh 2024',
  'su-kien',
  'Chương trình mừng lễ Giáng sinh sẽ được tổ chức vào ngày 24/12.',
  '<p>Chương trình mừng lễ Giáng sinh 2024 sẽ được tổ chức vào ngày 24/12.</p><p>Mời quý chị em tham dự và chuẩn bị tiết mục văn nghệ.</p>',
  0,
  0,
  '["giáng sinh", "sự kiện", "2024"]',
  1,
  189,
  NOW() - INTERVAL 3 DAY
),
(
  'Hướng dẫn sử dụng hệ thống mới',
  'huong-dan',
  'Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới trong hệ thống quản lý.',
  '<p>Tài liệu hướng dẫn chi tiết về cách sử dụng các tính năng mới trong hệ thống quản lý.</p><p>Vui lòng đọc kỹ trước khi sử dụng.</p><h4>Các tính năng mới:</h4><ul><li>Quản lý bài đăng</li><li>Tìm kiếm nâng cao</li><li>Báo cáo thống kê</li></ul>',
  0,
  0,
  '["hướng dẫn", "hệ thống"]',
  1,
  156,
  NOW() - INTERVAL 4 DAY
),
(
  'Chia sẻ kinh nghiệm đào tạo',
  'chia-se',
  'Một số kinh nghiệm trong công tác đào tạo và đồng hành với các chị em.',
  '<p>Một số kinh nghiệm trong công tác đào tạo và đồng hành với các chị em trong giai đoạn tập sinh và khấn tạm.</p>',
  0,
  0,
  '["chia sẻ", "đào tạo"]',
  1,
  98,
  NOW() - INTERVAL 5 DAY
),
(
  'Lịch họp tháng 12/2024',
  'thong-bao',
  'Thông báo lịch họp định kỳ tháng 12/2024.',
  '<p>Thông báo lịch họp định kỳ tháng 12/2024.</p><p>Đề nghị quý chị em sắp xếp thời gian tham dự đầy đủ.</p>',
  0,
  0,
  '["lịch họp", "tháng 12"]',
  1,
  134,
  NOW() - INTERVAL 6 DAY
),
(
  'Tĩnh tâm cuối năm tại Đà Lạt',
  'su-kien',
  'Chương trình tĩnh tâm cuối năm sẽ được tổ chức tại Đà Lạt từ ngày 28-31/12.',
  '<p>Chương trình tĩnh tâm cuối năm sẽ được tổ chức tại Đà Lạt từ ngày 28-31/12.</p><p>Đăng ký tham gia trước ngày 20/12.</p>',
  0,
  0,
  '["tĩnh tâm", "đà lạt", "cuối năm"]',
  1,
  201,
  NOW() - INTERVAL 7 DAY
);
