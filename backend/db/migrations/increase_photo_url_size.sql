-- Migration: Increase photo_url column size for Firebase URLs
-- Date: 2025-12-24
-- Reason: Firebase signed URLs are longer than 255 characters

ALTER TABLE sisters 
MODIFY COLUMN photo_url VARCHAR(1000) NULL;
