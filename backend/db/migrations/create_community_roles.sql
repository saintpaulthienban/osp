-- Migration: Create community_roles table
-- Date: 2025-12-20
-- Description: Create table for storing community role types (Bề trên, Phó bề trên, etc.)

-- Create table if not exists
CREATE TABLE IF NOT EXISTS community_roles (
  id INT AUTO_INCREMENT PRIMARY KEY,
  code VARCHAR(50) NOT NULL UNIQUE,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  display_order INT DEFAULT 0,
  color VARCHAR(20) DEFAULT '#6c757d',
  is_default BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert default roles (ignore if already exists)
INSERT IGNORE INTO community_roles (code, name, display_order, color, is_default, is_active) VALUES
('superior', 'Bề trên', 1, '#d63031', TRUE, TRUE),
('assistant', 'Phó bề trên', 2, '#2d3436', TRUE, TRUE),
('secretary', 'Thư ký', 3, '#6c5ce7', TRUE, TRUE),
('treasurer', 'Thủ quỹ', 4, '#e84393', TRUE, TRUE),
('member', 'Thành viên', 5, '#0984e3', TRUE, TRUE);

-- Verify
SELECT * FROM community_roles ORDER BY display_order;
