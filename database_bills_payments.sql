-- Bills table - connected to service_requests
CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT NOT NULL,
    bill_number VARCHAR(50) UNIQUE NOT NULL,
    area_sqft DECIMAL(10,2) NOT NULL,
    rate_per_sqft DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    description TEXT,
    bill_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Generated',
    FOREIGN KEY (request_id) REFERENCES service_requests(request_id)
);

-- Payments table - connected to bills
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    total_billed_amount DECIMAL(12,2) NOT NULL,
    total_paid_amount DECIMAL(12,2) NOT NULL,
    due_amount DECIMAL(12,2) NOT NULL,
    balance_amount DECIMAL(12,2) NOT NULL,
    date_paid DATE NOT NULL,
    payment_method VARCHAR(20) DEFAULT 'Cash',
    remarks TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bill_id) REFERENCES bills(bill_id)
);

-- Connection Flow:
-- service_requests -> bills -> payments
-- 1. Service request created
-- 2. Bill generated based on request area and rate
-- 3. Payments recorded against bill
-- 4. Service starts only after full payment (balance = 0)