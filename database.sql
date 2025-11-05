-- =============================================
-- DATABASE: alluring_decors
-- =============================================
CREATE DATABASE IF NOT EXISTS alluring_decors;
USE alluring_decors;

-- =============================================
-- 1. site_settings - Global Site Configuration
-- =============================================
CREATE TABLE site_settings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY,
    site_name VARCHAR(100) DEFAULT 'Alluring Decors',
    tagline VARCHAR(255),
    logo_url VARCHAR(255),
    favicon_url VARCHAR(255),
    email VARCHAR(100),
    phone VARCHAR(20),
    support_email VARCHAR(100),
    currency_symbol VARCHAR(5) DEFAULT 'KES',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL
);

-- =============================================
-- 2. users - Clients & Admins
-- =============================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    role ENUM('client', 'admin') DEFAULT 'client',
    is_active TINYINT(1) DEFAULT 1,
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME NULL
);

-- =============================================
-- 3. domains - Service Categories
-- =============================================
CREATE TABLE domains (
    domain_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    icon_url VARCHAR(255),
    is_active TINYINT(1) DEFAULT 1
);

-- =============================================
-- 4. services - Individual Services under Domains
-- =============================================
CREATE TABLE services (
    service_id INT AUTO_INCREMENT PRIMARY KEY,
    domain_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2) DEFAULT 0.00,
    price_per_sqft DECIMAL(10,2) DEFAULT 0.00,
    unit VARCHAR(20) DEFAULT 'sqft',
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id) ON DELETE CASCADE
);

-- =============================================
-- 5. projects
-- =============================================
CREATE TABLE projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    short_description TEXT,
    full_description TEXT,
    category ENUM('ongoing', 'upcoming', 'accomplished') NOT NULL,
    client_name VARCHAR(100),
    location VARCHAR(150),
    start_date DATE,
    end_date DATE,
    thumbnail_url VARCHAR(255),
    is_featured TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- 6. contacts - Multiple Contact Points
-- =============================================
CREATE TABLE contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(50),
    address TEXT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    map_url VARCHAR(255),
    is_primary TINYINT(1) DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1
);

-- =============================================
-- 7. feedbacks
-- =============================================
CREATE TABLE feedbacks (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    name VARCHAR(100),
    email VARCHAR(100),
    message TEXT NOT NULL,
    type ENUM('feedback', 'query') DEFAULT 'feedback',
    is_read TINYINT(1) DEFAULT 0,
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- =============================================
-- 8. faqs
-- =============================================
CREATE TABLE faqs (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(255) NOT NULL,
    answer TEXT NOT NULL,
    display_order INT DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- =============================================
-- INSERT INITIAL DATA
-- =============================================

-- Default Admin (password: admin123)
INSERT INTO users (username, password, email, full_name, role) 
VALUES ('admin', 'admin123', 'admin@alluringdecors.com', 'Administrator', 'admin');

-- Insert Domains
INSERT INTO domains (name, description) VALUES
('Home Decoration', 'Complete interior and exterior design for residential spaces.'),
('Office Decoration', 'Professional and modern office interiors.'),
('Banquet & Function Halls', 'Elegant decoration for events, weddings, and seminars.'),
('Restaurant Decoration', 'Stylish and functional restaurant interiors.');

-- Insert Services
INSERT INTO services (domain_id, name, description, price_per_sqft) VALUES
(1, 'Furniture & Glass Furnishing', 'Custom furniture and glass decor', 23000.00),
(1, 'Kitchen Design', 'Modular and aesthetic kitchen layouts', 30000.00),
(1, 'Lightning Effects', 'Ambient and task lighting solutions', 8000.00),
(2, 'Office Partitioning', 'Glass and wooden partitions', 20000.00);

-- Insert Sample Projects
INSERT INTO projects (title, short_description, full_description, category, client_name, location) VALUES
('Modern Villa Interior', 'Complete home makeover with contemporary design', 'A stunning transformation of a 3-bedroom villa featuring modern furniture, ambient lighting, and elegant color schemes.', 'ongoing', 'John Doe', 'Nairobi, Kenya'),
('Corporate Office Design', 'Professional workspace renovation', 'Complete office renovation with modern partitions, ergonomic furniture, and professional lighting systems.', 'accomplished', 'ABC Corp', 'Mombasa, Kenya');

-- Insert Contact
INSERT INTO contacts (label, address, phone, email, is_primary) VALUES
('Head Office', '123 Mfangano Street, Nairobi, CC 400001', '+123 98765 43210', 'info@alluringdecors.com', 1);

-- Insert FAQs
INSERT INTO faqs (question, answer, display_order) VALUES
('How to register?', 'Click on Register, fill details, and submit.', 1),
('Can I apply without registration?', 'No, only registered users can request services.', 2);

-- Insert Site Settings
INSERT INTO site_settings (site_name, tagline) 
VALUES ('Alluring Decors', 'Transforming Spaces, Creating Dreams');