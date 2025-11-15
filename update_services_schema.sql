-- Add image_url column to services table
ALTER TABLE services ADD COLUMN image_url VARCHAR(255) NULL AFTER unit;

-- Update existing services with placeholder images if needed
UPDATE services SET image_url = 'images/default-service.jpg' WHERE image_url IS NULL;