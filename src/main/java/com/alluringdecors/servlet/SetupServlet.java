package com.alluringdecors.servlet;

import com.alluringdecors.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

@WebServlet("/setup")
public class SetupServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Create all required tables
            String[] tables = {
                "CREATE TABLE IF NOT EXISTS users (user_id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50) UNIQUE NOT NULL, password VARCHAR(255) NOT NULL, email VARCHAR(100) NOT NULL, full_name VARCHAR(100) NOT NULL, phone VARCHAR(20), address TEXT, role ENUM('admin', 'client') DEFAULT 'client', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS domains (domain_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, description TEXT, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS projects (project_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255) NOT NULL, short_description TEXT, full_description TEXT, category ENUM('ongoing', 'accomplished') DEFAULT 'ongoing', client_name VARCHAR(100), location VARCHAR(100), start_date DATE, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS services (service_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100) NOT NULL, description TEXT, price_per_sqft DECIMAL(10,2), is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS content_sections (section_id INT AUTO_INCREMENT PRIMARY KEY, section_key VARCHAR(50) UNIQUE NOT NULL, title VARCHAR(255), content TEXT, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS contacts (contact_id INT AUTO_INCREMENT PRIMARY KEY, phone VARCHAR(20), email VARCHAR(100), address TEXT, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS feedbacks (feedback_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), message TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS faqs (faq_id INT AUTO_INCREMENT PRIMARY KEY, question TEXT NOT NULL, answer TEXT NOT NULL, display_order INT DEFAULT 0, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS service_requests (request_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(100), email VARCHAR(100), phone VARCHAR(20), project_type VARCHAR(50), message TEXT, status ENUM('pending', 'in_progress', 'completed') DEFAULT 'pending', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)",
                "CREATE TABLE IF NOT EXISTS heroes (hero_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(255) NOT NULL, subtitle VARCHAR(255), body_text TEXT NOT NULL, background_image VARCHAR(500), primary_button VARCHAR(100), primary_button_link VARCHAR(500), secondary_button VARCHAR(100), secondary_button_link VARCHAR(500), display_order INT DEFAULT 1, is_active BOOLEAN DEFAULT TRUE, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP)"
            };
            
            for (String table : tables) {
                stmt.executeUpdate(table);
            }
            
            response.getWriter().println("<h1>Setup Complete</h1>");
            response.getWriter().println("<p>All database tables created successfully!</p>");
            response.getWriter().println("<p>Tables: users, domains, projects, services, content_sections, contacts, feedbacks, faqs, service_requests, heroes</p>");
            response.getWriter().println("<a href='admin-dashboard.jsp'>Go to Admin Dashboard</a>");
            response.getWriter().println("<br><br><a href='admin/heroes'>Test Heroes Servlet</a>");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("<h1>Setup Failed</h1>");
            response.getWriter().println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
}