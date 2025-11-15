-- =============================================
-- DATABASE: alluring_decors
-- =============================================
CREATE DATABASE IF NOT EXISTS alluring_decors;
USE alluring_decors;

-- =============================================
-- 1. users - MUST BE FIRST (many tables reference it)
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

-- Default Admin (password: admin123 - HASH IT LATER!)
INSERT INTO users (username, password, email, full_name, role) 
VALUES ('admin', 'admin123', 'admin@alluringdecors.com', 'Administrator', 'admin');

-- =============================================
-- 2. domains - Needed before services
-- =============================================
CREATE TABLE domains (
    domain_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    icon_url VARCHAR(255),
    is_active TINYINT(1) DEFAULT 1
);

INSERT INTO domains (name, description) VALUES
('Home Decoration', 'Complete interior and exterior design for residential spaces.'),
('Office Decoration', 'Professional and modern office interiors.'),
('Banquet & Function Halls', 'Elegant decoration for events, weddings, and seminars.'),
('Restaurant Decoration', 'Stylish and functional restaurant interiors.');

-- =============================================
-- 3. services - Now domains exist
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

INSERT INTO services (domain_id, name, description, price_per_sqft) VALUES
(1, 'Furniture & Glass Furnishing', 'Custom furniture and glass decor', 23000.00),
(1, 'Kitchen Design', 'Modular and aesthetic kitchen layouts', 30000.00),
(1, 'Lightning Effects', 'Ambient and task lighting solutions', 8000.00),
(2, 'Office Partitioning', 'Glass and wooden partitions', 20000.00);

-- =============================================
-- 4. service_models - Now services exist
-- =============================================
CREATE TABLE service_models (
    model_id INT AUTO_INCREMENT PRIMARY KEY,
    service_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    additional_price DECIMAL(10,2) DEFAULT 0.00,
    is_active TINYINT(1) DEFAULT 1,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE
);

INSERT INTO service_models (service_id, name, description, additional_price) VALUES
(3, 'Chandelier Style', 'Luxury crystal chandeliers', 5000.00),
(3, 'LED Strip Lighting', 'Modern hidden LED strips', 1200.00);

-- =============================================
-- 5. projects - Independent
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

CREATE TABLE project_images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT NOT NULL,
    image_url VARCHAR(255) NOT NULL,
    caption VARCHAR(200),
    display_order INT DEFAULT 0,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);

-- =============================================
-- 6. statuses - Needed before service_requests
-- =============================================
CREATE TABLE statuses (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    is_editable TINYINT(1) DEFAULT 1
);

INSERT INTO statuses (name, description) VALUES
('Request Received', 'Service request received'),
('Rejected', 'Service cannot be provided'),
('Accepted', 'Request accepted, awaiting payment'),
('Payment Received', 'Payment completed'),
('Service Began', 'Work started'),
('Service Completed', 'Project finished');

-- =============================================
-- 7. service_requests - Now users & statuses exist
-- =============================================
CREATE TABLE service_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    request_code VARCHAR(20) UNIQUE NOT NULL,
    location TEXT NOT NULL,
    area_sqft DECIMAL(10,2),
    requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status_id INT NOT NULL,
    remarks TEXT,
    cancelled TINYINT(1) DEFAULT 0,
    cancelled_at DATETIME NULL,
    cancelled_reason TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES statuses(status_id) ON DELETE RESTRICT
);

-- =============================================
-- 8. request_services - Now all referenced tables exist
-- =============================================
CREATE TABLE request_services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    domain_id INT NOT NULL,
    service_id INT NOT NULL,
    model_id INT NULL,
    area DECIMAL(10,2) DEFAULT 0.00,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(10,2) DEFAULT 0.00,
    subtotal DECIMAL(10,2) DEFAULT 0.00,
    notes TEXT,
    FOREIGN KEY (request_id) REFERENCES service_requests(request_id) ON DELETE CASCADE,
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id) ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) ON DELETE CASCADE,
    FOREIGN KEY (model_id) REFERENCES service_models(model_id) ON DELETE SET NULL
);

-- =============================================
-- 9. bills - After service_requests
-- =============================================
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    bill_number VARCHAR(30) UNIQUE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    net_amount DECIMAL(12,2) NOT NULL, -- Avoid GENERATED ALWAYS for compatibility
    generated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATE,
    notes TEXT,
    is_paid TINYINT(1) DEFAULT 0,
    FOREIGN KEY (request_id) REFERENCES service_requests(request_id) ON DELETE CASCADE
);

-- Trigger to calculate net_amount (optional, or do it in app)
DELIMITER $$
CREATE TRIGGER calc_net_amount BEFORE INSERT ON bills
FOR EACH ROW SET NEW.net_amount = NEW.total_amount + NEW.tax_amount - NEW.discount_amount;
$$
DELIMITER ;

-- =============================================
-- 10. payments - After bills
-- =============================================
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    paid_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    method ENUM('cash', 'mpesa', 'card', 'bank') DEFAULT 'cash',
    reference_no VARCHAR(50),
    receipt_url VARCHAR(255),
    notes TEXT,
    recorded_by INT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE,
    FOREIGN KEY (recorded_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- =============================================
-- 11. site_settings - Now users exists
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
    updated_by INT NULL,
    FOREIGN KEY (updated_by) REFERENCES users(user_id) ON DELETE SET NULL
);

INSERT INTO site_settings (site_name, tagline) 
VALUES ('Alluring Decors', 'Transforming Spaces, Creating Dreams');

-- =============================================
-- 12. content_sections - Now users exists
-- =============================================
CREATE TABLE content_sections (
    section_id INT AUTO_INCREMENT PRIMARY KEY,
    section_key VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(100),
    content TEXT NOT NULL,
    is_active TINYINT(1) DEFAULT 1,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by INT NULL,
    FOREIGN KEY (updated_by) REFERENCES users(user_id) ON DELETE SET NULL
);

INSERT INTO content_sections (section_key, title, content) VALUES
('home_center', 'Why Choose Alluring Decors?', 
'Welcome to <strong>Alluring Decors</strong> — where imagination meets craftsmanship. With over 5 years of excellence in interior and exterior design, we transform ordinary spaces into breathtaking environments. Our team of creative designers and skilled artisans ensures every project reflects your unique style and vision. From luxurious homes to professional offices and grand banquet halls, we deliver perfection in every detail. Choose us for unmatched quality, timely delivery, and personalized service that turns your dreams into reality.'),

('about_us', 'About Alluring Decors', 
'Alluring Decors is a premier interior and exterior design firm with a passion for creating stunning, functional, and timeless spaces. Established 5 years ago, we have completed hundreds of projects across residential, commercial, and hospitality sectors. Our services include complete home makeovers, office redesigns, restaurant styling, and event hall decorations. We believe in sustainable design, innovative solutions, and client satisfaction above all.');

-- =============================================
-- 13. contacts, feedbacks, faqs, audit_logs, media_uploads
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

INSERT INTO contacts (label, address, phone, email, is_primary) VALUES
('Head Office', '123 Mfangano Street, Nairobi, CC 400001', '+123 98765 43210', 'info@alluringdecors.com', 1);

CREATE TABLE feedbacks (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    name VARCHAR(100),
    email VARCHAR(100),
    message TEXT NOT NULL,
    type ENUM('general', 'suggestion', 'complaint', 'question', 'compliment') DEFAULT 'general',
    is_read TINYINT(1) DEFAULT 0,
    submitted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE faqs (
    faq_id INT AUTO_INCREMENT PRIMARY KEY,
    question VARCHAR(255) NOT NULL,
    answer TEXT NOT NULL,
    display_order INT DEFAULT 0,
    is_active TINYINT(1) DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO faqs (question, answer, display_order) VALUES
('How to register?', 'Click on Register, fill details, and submit.', 1),
('Can I apply without registration?', 'No, only registered users can request services.', 2);

CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NULL,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(50),
    record_id INT NULL,
    old_values JSON NULL,
    new_values JSON NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE media_uploads (
    media_id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    file_type ENUM('image', 'document', 'video') NOT NULL,
    file_size INT NOT NULL,
    uploaded_by INT NULL,
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    purpose VARCHAR(100),
    FOREIGN KEY (uploaded_by) REFERENCES users(user_id) ON DELETE SET NULL
);