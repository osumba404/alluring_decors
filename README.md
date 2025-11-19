# Alluring Decors - eProject Report

## Acknowledgements

We extend our heartfelt gratitude to:
- **Academic Supervisors** for their guidance and support throughout the project development
- **Industry Mentors** who provided valuable insights into interior design business processes
- **Beta Testers** who helped identify and resolve critical issues
- **Open Source Community** for the frameworks and libraries that made this project possible

---

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

**Project Status:** Completed ✅  
**Version:** 1.0  
**Last Updated:** November 2025