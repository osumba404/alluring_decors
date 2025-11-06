<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <jsp:include page="WEB-INF/navigation.jsp" />

    <div class="admin-layout">
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3 class="sidebar-title">Admin Panel</h3>
                <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>
            </div>
            <nav class="sidebar-menu">
                <a href="../admin/users" class="sidebar-item">
                    <span class="sidebar-item-icon">👥</span>
                    <span class="sidebar-item-text">Manage Users</span>
                </a>
                <a href="../admin/projects" class="sidebar-item">
                    <span class="sidebar-item-icon">📋</span>
                    <span class="sidebar-item-text">Manage Projects</span>
                </a>
                <a href="../admin/domains" class="sidebar-item">
                    <span class="sidebar-item-icon">🏷️</span>
                    <span class="sidebar-item-text">Manage Domains</span>
                </a>
                <a href="../admin/services" class="sidebar-item">
                    <span class="sidebar-item-icon">⚙️</span>
                    <span class="sidebar-item-text">Manage Services</span>
                </a>
                <a href="../admin/content" class="sidebar-item">
                    <span class="sidebar-item-icon">📝</span>
                    <span class="sidebar-item-text">Edit Content</span>
                </a>
                <a href="../admin/contacts" class="sidebar-item">
                    <span class="sidebar-item-icon">📞</span>
                    <span class="sidebar-item-text">Manage Contacts</span>
                </a>
                <a href="../admin/feedback" class="sidebar-item">
                    <span class="sidebar-item-icon">💬</span>
                    <span class="sidebar-item-text">View Feedback</span>
                </a>
                <a href="../admin/faqs" class="sidebar-item">
                    <span class="sidebar-item-icon">❓</span>
                    <span class="sidebar-item-text">Manage FAQs</span>
                </a>
                <a href="../admin/requests" class="sidebar-item">
                    <span class="sidebar-item-icon">📨</span>
                    <span class="sidebar-item-text">Service Requests</span>
                </a>
            </nav>
        </aside>
        
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Admin Dashboard</h1>
                <p class="dashboard-subtitle">Manage your Alluring Decors business</p>
            </div>
            
            <div class="admin-grid">
                <div class="admin-card">
                    <h4>Users</h4>
                    <p>View, edit, and delete registered users</p>
                    <a href="../admin/users">Manage Users →</a>
                </div>
                <div class="admin-card">
                    <h4>Projects</h4>
                    <p>Add, edit, and delete projects</p>
                    <a href="../admin/projects">Manage Projects →</a>
                </div>
                <div class="admin-card">
                    <h4>Domains</h4>
                    <p>Configure service domains and categories</p>
                    <a href="../admin/domains">Manage Domains →</a>
                </div>
                <div class="admin-card">
                    <h4>Services</h4>
                    <p>Configure services, pricing, and models</p>
                    <a href="../admin/services">Manage Services →</a>
                </div>
                <div class="admin-card">
                    <h4>Content</h4>
                    <p>Update home page content and about us section</p>
                    <a href="../admin/content">Edit Content →</a>
                </div>
                <div class="admin-card">
                    <h4>Contacts</h4>
                    <p>Update contact information and addresses</p>
                    <a href="../admin/contacts">Manage Contacts →</a>
                </div>
                <div class="admin-card">
                    <h4>Feedback</h4>
                    <p>Review customer feedback and queries</p>
                    <a href="../admin/feedback">View Feedback →</a>
                </div>
                <div class="admin-card">
                    <h4>FAQs</h4>
                    <p>Add, edit, and delete frequently asked questions</p>
                    <a href="../admin/faqs">Manage FAQs →</a>
                </div>
                <div class="admin-card">
                    <h4>Service Requests</h4>
                    <p>View and manage customer service requests</p>
                    <a href="../admin/requests">Service Requests →</a>
                </div>
            </div>
        </main>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        }
    </script>
</body>
</html>