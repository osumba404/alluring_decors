# Alluring Decors - Setup Instructions

## Prerequisites
1. Java 11 or higher
2. Apache Maven 3.6+
3. XAMPP (for MySQL database)
4. Apache Tomcat 9.0+ or any Java EE application server

## Database Setup

1. **Start XAMPP**
   - Start Apache and MySQL services in XAMPP Control Panel

2. **Create Database**
   - Open phpMyAdmin (http://localhost/phpmyadmin)
   - Import the `database.sql` file to create the database and tables
   - Or run the SQL commands manually in phpMyAdmin

3. **Verify Database Connection**
   - Database: `alluring_decors`
   - Username: `root`
   - Password: (empty)
   - Port: 3306

## Application Setup

1. **Build the Project**
   ```cmd
   cd c:\Users\evans\Desktop\sem4\alluring_decors
   mvn clean compile
   mvn package
   ```

2. **Deploy to Tomcat**
   - Copy the generated WAR file from `target/alluring-decors-1.0.0.war`
   - Place it in Tomcat's `webapps` directory
   - Start Tomcat server

3. **Access the Application**
   - Open browser and go to: `http://localhost:8080/alluring-decors-1.0.0/`

## Default Login Credentials

**Administrator:**
- Username: `admin`
- Password: `admin123`

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/alluringdecors/
│   │       ├── bean/          # EJB Session Beans
│   │       ├── model/         # Entity Classes
│   │       ├── servlet/       # Web Servlets
│   │       └── util/          # Utility Classes
│   └── webapp/
│       ├── WEB-INF/
│       │   └── web.xml        # Web Configuration
│       ├── css/               # Stylesheets
│       └── *.jsp              # JSP Pages
```

## Features Implemented

### Guest Module
- Home page with company info and services
- User registration and login
- View projects (ongoing, upcoming, accomplished)
- View services offered
- Contact information

### Authentication
- User login/logout
- Role-based access (admin/client)
- Session management

### Database Integration
- MySQL connectivity
- EJB session beans for data operations
- CRUD operations for users, domains, services, projects

## Next Steps

After the web application is running, you can:

1. **Add Admin Features:**
   - Project management (CRUD)
   - User management
   - Service management
   - Content management

2. **Add Client Features:**
   - Service requests
   - Request status tracking
   - Profile management

3. **Create Desktop Application:**
   - JavaFX or Swing GUI
   - Connect to same database
   - Admin functionality

## Troubleshooting

1. **Database Connection Issues:**
   - Verify XAMPP MySQL is running
   - Check database credentials in `DatabaseUtil.java`
   - Ensure `alluring_decors` database exists

2. **Build Issues:**
   - Ensure Java 11+ is installed
   - Verify Maven is properly configured
   - Check internet connection for dependency downloads

3. **Deployment Issues:**
   - Verify Tomcat is running
   - Check Tomcat logs for errors
   - Ensure WAR file is properly deployed