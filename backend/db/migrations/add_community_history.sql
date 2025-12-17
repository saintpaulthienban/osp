-- Add history field to communities table
-- Run this migration to add the history field for storing community formation history

ALTER TABLE communities
ADD COLUMN history TEXT NULL COMMENT 'Lịch sử hình thành cộng đoàn (HTML content)';
