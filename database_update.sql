-- Add new columns to service_requests table to store client details directly
ALTER TABLE service_requests 
ADD COLUMN client_name VARCHAR(255),
ADD COLUMN client_email VARCHAR(255),
ADD COLUMN client_phone VARCHAR(20),
ADD COLUMN description TEXT;

-- Update existing records to move data from remarks to proper fields
-- Note: This is a manual process since the data format in remarks is mixed
-- You may need to manually update existing records or clear them

-- Optional: Clear existing incorrect data
-- UPDATE service_requests SET remarks = NULL WHERE remarks LIKE '%-%-%';