# Alluring Decors - eProject Report

## eProject Synopsis

**Project Title:** Alluring Decors - Interior & Exterior Design Management System

**Objective:** To develop a comprehensive web-based platform that enables an interior and exterior design firm to manage client interactions, service requests, project portfolios, and business operations efficiently.

**Key Features:**
- Dynamic content management system
- Service domain management with pricing
- Client registration and authentication
- Service request workflow management
- Project portfolio showcase
- Billing and payment tracking
- Feedback and FAQ management
- Admin dashboard for complete system control

**Technology Stack:**
- **Frontend:** JSP, HTML5, CSS3, JavaScript
- **Backend:** Java Servlets, JSP
- **Database:** MySQL/MariaDB
- **Server:** Apache Tomcat
- **Architecture:** MVC (Model-View-Controller)

---

## eProject Analysis

### Problem Statement
Interior design firms face challenges in:
- Managing client inquiries and service requests
- Showcasing project portfolios effectively
- Tracking project progress and billing
- Maintaining consistent communication with clients
- Organizing service offerings across multiple domains

### Proposed Solution
A web-based management system that provides:
- **Client Portal:** Service browsing, request submission, progress tracking
- **Admin Panel:** Complete business management and content control
- **Dynamic Content:** Easy updates to services, projects, and company information
- **Workflow Management:** Structured process from inquiry to project completion

### System Requirements

**Functional Requirements:**
1. User registration and authentication
2. Service domain and pricing management
3. Service request submission and tracking
4. Project portfolio management
5. Billing and payment processing
6. Content management system
7. Feedback and communication system

**Non-Functional Requirements:**
1. **Performance:** Response time < 3 seconds
2. **Security:** Role-based access control, data encryption
3. **Usability:** Intuitive interface, mobile responsive
4. **Scalability:** Support for growing business needs
5. **Reliability:** 99.5% uptime availability

---

## eProject Design

### System Architecture
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │    Business     │    │      Data       │
│     Layer       │◄──►│     Logic       │◄──►│     Layer       │
│   (JSP/HTML)    │    │   (Servlets)    │    │    (MySQL)      │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Data Flow Diagrams (DFDs)

#### Level 0 DFD - Context Diagram
```
                    ┌─────────────────┐
                    │                 │
        Client ────►│  Alluring       │◄──── Admin
                    │  Decors         │
        Guest  ────►│  System         │
                    │                 │
                    └─────────────────┘
```

#### Level 1 DFD - System Overview
```
┌─────────┐    ┌──────────────┐    ┌─────────────┐    ┌──────────────┐
│ Client  │───►│   Service    │───►│   Request   │───►│   Billing    │
│ Portal  │    │ Management   │    │ Processing  │    │ Management   │
└─────────┘    └──────────────┘    └─────────────┘    └──────────────┘
     │                │                     │                 │
     │                ▼                     ▼                 ▼
     │         ┌──────────────┐    ┌─────────────┐    ┌──────────────┐
     └────────►│   Content    │    │   Project   │    │   User       │
               │ Management   │    │ Management  │    │ Management   │
               └──────────────┘    └─────────────┘    └──────────────┘
```

### Process Diagrams

#### Service Request Process
```
[Client Login] → [Browse Services] → [Select Service] → [Submit Request]
       ↓
[Admin Review] → [Generate Quote] → [Client Approval] → [Project Start]
       ↓
[Progress Updates] → [Project Completion] → [Generate Bill] → [Payment]
```

#### User Registration Flow
```
[Registration Form] → [Validation] → [Database Storage] → [Email Confirmation]
                                           ↓
                    [Login Access] ← [Account Activation]
```

### Database Design/Structure

#### Entity Relationship Diagram
```
Users (1) ──────── (M) Service_Requests (M) ──────── (1) Services
  │                         │                              │
  │                         │                              │
  │                    (1)  │  (1)                        │
  │                         │                              │
  │                      Bills                             │
  │                         │                              │
  │                    (1)  │  (M)                        │
  │                         │                              │
  │                     Payments                           │
  │                                                        │
  └─────────── (M) Feedbacks                              │
                                                           │
                              Domains (1) ──────── (M) ───┘
```

#### Core Database Tables

**Users Table:**
- user_id (PK), full_name, email, phone, password_hash, role, registration_date

**Domains Table:**
- domain_id (PK), name, description, icon_url, is_active

**Services Table:**
- service_id (PK), domain_id (FK), name, description, base_price, price_per_sqft, unit

**Service_Requests Table:**
- request_id (PK), user_id (FK), service_id (FK), location, area_sqft, status, requested_at

**Bills Table:**
- bill_id (PK), request_id (FK), bill_number, total_amount, net_amount, generated_at

**Projects Table:**
- project_id (PK), title, description, client_name, location, status, thumbnail_url

---

## User Guide

### For Clients

#### Getting Started
1. **Registration:** Visit the website and click "Register" to create an account
2. **Login:** Use your credentials to access the client dashboard
3. **Browse Services:** Explore different service domains and offerings

#### Requesting Services
1. Navigate to "Services" section
2. Select desired service domain (Home, Office, Restaurant, etc.)
3. Choose specific service and click "Request Service"
4. Fill in project details and submit request
5. Track request status in your dashboard

#### Managing Requests
- **View Requests:** Access all your service requests from the dashboard
- **Track Progress:** Monitor real-time status updates
- **Update Details:** Modify pending requests before approval
- **Cancel Requests:** Cancel unwanted requests

#### Billing & Payments
- View generated bills in the dashboard
- Track payment status and due dates
- Download bill receipts

### For Administrators

#### Content Management
- **Update Company Information:** Modify about us, contact details
- **Manage Hero Sections:** Update homepage banners and content
- **FAQ Management:** Add, edit, or remove frequently asked questions

#### Service Management
- **Domain Management:** Create and manage service categories
- **Service Configuration:** Set pricing, descriptions, and availability
- **Request Processing:** Review, approve, and manage client requests

#### Project Portfolio
- **Add Projects:** Upload project images and descriptions
- **Categorize Projects:** Organize by status (ongoing, completed)
- **Update Progress:** Maintain current project information

---

## Developer's Guide

### Module Descriptions

#### 1. Authentication Module
**Location:** `com.alluringdecors.servlet.LoginServlet`, `RegisterServlet`
**Purpose:** Handles user registration, login, logout, and session management
**Key Classes:**
- `AuthUtil.java` - Authentication utilities
- `UserBean.java` - User data operations

#### 2. Content Management Module
**Location:** `com.alluringdecors.servlet.AdminContentServlet`
**Purpose:** Dynamic content management for homepage and about sections
**Key Classes:**
- `ContentBean.java` - Content CRUD operations
- `HeroBean.java` - Hero section management

#### 3. Service Management Module
**Location:** `com.alluringdecors.servlet.ServicesServlet`, `AdminServicesServlet`
**Purpose:** Service domain and individual service management
**Key Classes:**
- `DomainBean.java` - Service domain operations
- `ServiceBean.java` - Individual service management

#### 4. Request Processing Module
**Location:** `com.alluringdecors.servlet.RequestServiceServlet`, `AdminRequestsServlet`
**Purpose:** Service request workflow management
**Key Classes:**
- `ServiceRequestBean.java` - Request CRUD operations
- Request status tracking and updates

#### 5. Billing Module
**Location:** `com.alluringdecors.servlet.AdminBillsServlet`
**Purpose:** Bill generation and payment tracking
**Key Classes:**
- `BillBean.java` - Billing operations
- `PaymentBean.java` - Payment processing

#### 6. Project Portfolio Module
**Location:** `com.alluringdecors.servlet.ProjectsServlet`, `AdminProjectsServlet`
**Purpose:** Project showcase and management
**Key Classes:**
- `ProjectBean.java` - Project CRUD operations
- Image upload and management

#### 7. Communication Module
**Location:** `com.alluringdecors.servlet.FeedbackServlet`, `FaqServlet`
**Purpose:** Client feedback and FAQ management
**Key Classes:**
- `FeedbackBean.java` - Feedback processing
- `FaqBean.java` - FAQ management

### Development Setup
1. **Prerequisites:** Java 8+, Apache Tomcat 9+, MySQL 8+
2. **Database Setup:** Import `alluring_decors.sql`
3. **Configuration:** Update database connection in `DatabaseUtil.java`
4. **Deployment:** Deploy WAR file to Tomcat webapps directory

### API Endpoints
- `/login` - User authentication
- `/services` - Service browsing
- `/request-service` - Service request submission
- `/admin/*` - Administrative functions
- `/client/dashboard` - Client dashboard

---

## Detailed Technical Specifications

### Frontend Architecture

#### JSP Pages Structure
```
webapp/
├── index.jsp (Homepage with hero carousel)
├── about.jsp (Company information)
├── contact.jsp (Contact details)
├── projects.jsp (Project portfolio)
├── services.jsp (Service domains)
├── view-services.jsp (Domain-specific services)
├── view-service.jsp (Individual service details)
├── feedback.jsp (Client feedback form)
├── faq.jsp (Frequently asked questions)
├── login.jsp (User authentication)
├── register.jsp (User registration)
├── request-service.jsp (Service request form)
├── client-dashboard.jsp (Client portal)
└── admin/ (Administrative pages)
    ├── admin-dashboard.jsp
    ├── admin-users.jsp
    ├── admin-services.jsp
    ├── admin-requests.jsp
    ├── admin-projects.jsp
    ├── admin-content.jsp
    └── admin-feedback.jsp
```

#### CSS Framework
- **Modern UI CSS:** Custom responsive framework
- **Component-based styling:** Modular CSS architecture
- **Animation system:** Intersection Observer API for scroll animations
- **Color scheme:** Professional green and gold palette
- **Typography:** Inter and Playfair Display fonts

#### JavaScript Features
- **Hero carousel:** Auto-advancing image slider
- **Form validation:** Client-side input validation
- **Interactive animations:** Hover effects and transitions
- **AJAX functionality:** Dynamic content loading
- **Search filters:** Real-time filtering for services and FAQs

### Backend Architecture

#### Servlet Structure
```
com.alluringdecors.servlet/
├── Authentication/
│   ├── LoginServlet.java
│   ├── RegisterServlet.java
│   └── LogoutServlet.java
├── Client/
│   ├── ClientDashboardServlet.java
│   ├── RequestServiceServlet.java
│   ├── ServicesServlet.java
│   └── ProjectsServlet.java
├── Admin/
│   ├── AdminDashboardServlet.java
│   ├── AdminUsersServlet.java
│   ├── AdminServicesServlet.java
│   ├── AdminRequestsServlet.java
│   ├── AdminProjectsServlet.java
│   └── AdminContentServlet.java
└── Public/
    ├── HomeServlet.java
    ├── ContactServlet.java
    ├── FeedbackServlet.java
    └── FaqServlet.java
```

#### Bean Classes (Data Access Layer)
```
com.alluringdecors.bean/
├── UserBean.java (User management)
├── ServiceBean.java (Service operations)
├── DomainBean.java (Service domains)
├── ServiceRequestBean.java (Request handling)
├── ProjectBean.java (Project portfolio)
├── BillBean.java (Billing system)
├── PaymentBean.java (Payment tracking)
├── FeedbackBean.java (Client feedback)
├── FaqBean.java (FAQ management)
├── ContentBean.java (CMS operations)
├── HeroBean.java (Homepage banners)
└── ContactBean.java (Contact information)
```

#### Model Classes (Entity Objects)
```
com.alluringdecors.model/
├── User.java
├── Service.java
├── Domain.java
├── ServiceRequest.java
├── Project.java
├── Bill.java
├── Payment.java
├── Feedback.java
├── Faq.java
├── Hero.java
└── Contact.java
```

### Database Schema Details

#### Complete Table Structure

**1. Users Table**
```sql
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('client', 'admin') DEFAULT 'client',
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);
```

**2. Domains Table**
```sql
CREATE TABLE domains (
    domain_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    icon_url VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE
);
```

**3. Services Table**
```sql
CREATE TABLE services (
    service_id INT PRIMARY KEY AUTO_INCREMENT,
    domain_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2),
    price_per_sqft DECIMAL(8,2) NOT NULL,
    unit VARCHAR(20) DEFAULT 'sqft',
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (domain_id) REFERENCES domains(domain_id)
);
```

**4. Service Requests Table**
```sql
CREATE TABLE service_requests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    service_id INT,
    location TEXT NOT NULL,
    area_sqft DECIMAL(8,2),
    description TEXT,
    status ENUM('pending', 'approved', 'ongoing', 'completed', 'cancelled') DEFAULT 'pending',
    requested_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);
```

**5. Projects Table**
```sql
CREATE TABLE projects (
    project_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    client_name VARCHAR(100),
    location VARCHAR(200),
    thumbnail_url VARCHAR(500),
    status ENUM('ongoing', 'completed', 'upcoming') DEFAULT 'ongoing',
    start_date DATE,
    end_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

**6. Bills Table**
```sql
CREATE TABLE bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    request_id INT NOT NULL,
    bill_number VARCHAR(30) UNIQUE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    net_amount DECIMAL(12,2) NOT NULL,
    generated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATE,
    is_paid BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (request_id) REFERENCES service_requests(request_id)
);
```

**7. Content Management Tables**
```sql
CREATE TABLE content_sections (
    section_id INT PRIMARY KEY AUTO_INCREMENT,
    section_key VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(100),
    content TEXT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE heroes (
    hero_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    subtitle VARCHAR(255),
    body_text TEXT NOT NULL,
    background_image VARCHAR(500),
    primary_button VARCHAR(100),
    primary_button_link VARCHAR(500),
    secondary_button VARCHAR(100),
    secondary_button_link VARCHAR(500),
    display_order INT DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE
);
```

### Security Implementation

#### Authentication System
- **Password Hashing:** BCrypt algorithm for secure password storage
- **Session Management:** HttpSession for user state management
- **Role-based Access:** Admin and client role separation
- **CSRF Protection:** Token-based form validation
- **SQL Injection Prevention:** PreparedStatement usage

#### Authorization Filters
```java
// Authentication filter for protected routes
public class AuthFilter implements Filter {
    // Validates user sessions and redirects unauthorized access
}

// Admin authorization filter
public class AdminFilter implements Filter {
    // Ensures only admin users access admin functionality
}
```

### File Upload System

#### Image Management
- **Upload Directory:** `/webapp/uploads/`
- **Supported Formats:** JPEG, PNG, GIF
- **File Size Limit:** 5MB per image
- **Naming Convention:** Timestamp-based unique filenames
- **Storage Structure:**
  ```
  uploads/
  ├── domains/ (Service domain icons)
  ├── projects/ (Project thumbnails)
  └── heroes/ (Homepage banners)
  ```

### Error Handling & Logging

#### Exception Management
- **Custom Exception Classes:** Business logic specific exceptions
- **Global Error Pages:** User-friendly error displays
- **Logging Framework:** Java Util Logging for system monitoring
- **Audit Trail:** Database logging for critical operations

#### Validation System
- **Client-side Validation:** JavaScript form validation
- **Server-side Validation:** Java Bean Validation
- **Data Sanitization:** Input cleaning and XSS prevention
- **Business Rule Validation:** Custom validation logic

### Performance Optimization

#### Database Optimization
- **Connection Pooling:** Efficient database connection management
- **Prepared Statements:** Query optimization and security
- **Indexing Strategy:** Optimized database indexes
- **Query Optimization:** Efficient SQL queries

#### Frontend Optimization
- **CSS Minification:** Compressed stylesheets
- **Image Optimization:** Compressed and responsive images
- **Lazy Loading:** On-demand content loading
- **Caching Strategy:** Browser and server-side caching

### Testing Strategy

#### Unit Testing
- **Bean Testing:** Data access layer validation
- **Servlet Testing:** HTTP request/response testing
- **Model Testing:** Entity object validation
- **Utility Testing:** Helper function verification

#### Integration Testing
- **Database Integration:** CRUD operation testing
- **Servlet Integration:** End-to-end workflow testing
- **File Upload Testing:** Image upload functionality
- **Authentication Testing:** Login/logout flow validation

### Deployment Configuration

#### Server Requirements
- **Java Version:** JDK 8 or higher
- **Application Server:** Apache Tomcat 9.0+
- **Database:** MySQL 8.0+ or MariaDB 10.4+
- **Memory:** Minimum 2GB RAM
- **Storage:** 10GB available space

#### Configuration Files
```
WEB-INF/
├── web.xml (Servlet configuration)
├── lib/ (JAR dependencies)
└── classes/ (Compiled Java classes)
```

#### Environment Setup
1. **Database Configuration:**
   ```java
   // DatabaseUtil.java
   private static final String URL = "jdbc:mysql://localhost:3306/alluring_decors";
   private static final String USERNAME = "root";
   private static final String PASSWORD = "password";
   ```

2. **Tomcat Deployment:**
   - Copy WAR file to `webapps/` directory
   - Configure database connection
   - Set file upload permissions
   - Configure SSL (optional)

---

**Project Status:** Completed ✅  
**Version:** 1.0  
**Last Updated:** November 2025dates

#### 5. Billing Module
**Location:** `com.alluringdecors.servlet.AdminBillsServlet`
**Purpose:** Bill generation and payment tracking
**Key Classes:**
- `BillBean.java` - Billing operations
- `PaymentBean.java` - Payment processing

#### 6. Project Portfolio Module
**Location:** `com.alluringdecors.servlet.ProjectsServlet`, `AdminProjectsServlet`
**Purpose:** Project showcase and management
**Key Classes:**
- `ProjectBean.java` - Project CRUD operations
- Image upload and management

#### 7. Communication Module
**Location:** `com.alluringdecors.servlet.FeedbackServlet`, `FaqServlet`
**Purpose:** Client feedback and FAQ management
**Key Classes:**
- `FeedbackBean.java` - Feedback processing
- `FaqBean.java` - FAQ management

### Development Setup
1. **Prerequisites:** Java 8+, Apache Tomcat 9+, MySQL 8+
2. **Database Setup:** Import `alluring_decors.sql`
3. **Configuration:** Update database connection in `DatabaseUtil.java`
4. **Deployment:** Deploy WAR file to Tomcat webapps directory

### API Endpoints
- `/login` - User authentication
- `/services` - Service browsing
- `/request-service` - Service request submission
- `/admin/*` - Administrative functions
- `/client/dashboard` - Client dashboard

---

**Project Status:** Completed ✅  
**Version:** 1.0  
**Last Updated:** November 2025