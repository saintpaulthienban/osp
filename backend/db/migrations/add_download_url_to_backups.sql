-- Add download_url column to backups table for Firebase Storage URLs
ALTER TABLE backups 
ADD COLUMN download_url TEXT NULL 
COMMENT 'Firebase Storage signed URL for downloading backup file';
