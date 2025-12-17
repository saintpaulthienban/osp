-- Migration: Add data_scope and is_super_admin to users table
-- Date: 2025-01-13

-- Add data_scope column
ALTER TABLE users 
ADD COLUMN data_scope ENUM('all', 'community', 'own') NOT NULL DEFAULT 'community' 
COMMENT 'Data scope: all=xem tất cả, community=xem theo cộng đoàn, own=chỉ xem của mình'
AFTER is_admin;

-- Add is_super_admin column
ALTER TABLE users 
ADD COLUMN is_super_admin TINYINT(1) NOT NULL DEFAULT 0 
COMMENT 'Super admin có quyền tối cao, bypass mọi kiểm tra'
AFTER is_admin;

-- Add index for better query performance
CREATE INDEX idx_users_data_scope ON users(data_scope);
CREATE INDEX idx_users_super_admin ON users(is_super_admin);

-- Set admin users to have 'all' scope
UPDATE users 
SET data_scope = 'all', is_super_admin = 1 
WHERE is_admin = 1;

-- Show results
SELECT id, username, is_admin, is_super_admin, data_scope 
FROM users 
ORDER BY id;
