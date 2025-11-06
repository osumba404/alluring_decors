CREATE TABLE heroes (
    hero_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    subtitle VARCHAR(255),
    body_text TEXT NOT NULL,
    background_image VARCHAR(500),
    primary_button VARCHAR(100),
    primary_button_link VARCHAR(500),
    secondary_button VARCHAR(100),
    secondary_button_link VARCHAR(500),
    display_order INT DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Insert a default hero slide
INSERT INTO heroes (title, subtitle, body_text, background_image, primary_button, primary_button_link, secondary_button, secondary_button_link, display_order) 
VALUES (
    'Elegance Redefined',
    'Welcome to Alluring Decors',
    'Transforming ordinary spaces into extraordinary experiences with bespoke interior and exterior designs. Where imagination meets craftsmanship, and every detail reflects your unique vision.',
    'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80',
    'Explore Services',
    'services',
    'Get Quote',
    'contact',
    1
);