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
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="nav-brand">
                <h1>Admin <span style="color: var(--accent);">Dashboard</span></h1>
            </div>
            <ul class="nav-menu">
                <li><a href="../home">Home</a></li>
                <li><a href="../logout">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Welcome to Admin Dashboard</h2>
                <p>Manage your Alluring Decors business from here.</p>
            </div>
        </section>

        <section class="services-preview">
            <h3>Site Management</h3>
            <div class="services-grid">
                <div class="service-card">
                    <h4><a href="../admin/users">Manage Users</a></h4>
                    <p>View, edit, and delete registered users</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/projects">Manage Projects</a></h4>
                    <p>Add, edit, and delete projects (ongoing, upcoming, accomplished)</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/domains">Manage Domains</a></h4>
                    <p>Configure service domains and categories</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/services">Manage Services</a></h4>
                    <p>Configure services, pricing, and models</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/content">Edit Content</a></h4>
                    <p>Update home page content and about us section</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/contacts">Manage Contacts</a></h4>
                    <p>Update contact information and addresses</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/feedback">View Feedback</a></h4>
                    <p>Review customer feedback and queries</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/faqs">Manage FAQs</a></h4>
                    <p>Add, edit, and delete frequently asked questions</p>
                </div>
                <div class="service-card">
                    <h4><a href="../admin/requests">Service Requests</a></h4>
                    <p>View and manage customer service requests</p>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>