<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="nav-brand">
                <h1><a href="home">Alluring <span style="color: var(--accent);">Decors</span></a></h1>
            </div>
            <ul class="nav-menu">
                <li><a href="home">Home</a></li>
                <li><a href="about.jsp">About</a></li>
                <li><a href="projects.jsp">Projects</a></li>
                <li><a href="services.jsp">Services</a></li>
                <li><a href="contact.jsp">Contact</a></li>
                <li><a href="login">Login</a></li>
                <li><a href="register">Register</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Contact Us</h2>
            </div>
        </section>

        <section class="services-preview">
            <div class="services-grid">
                <div class="service-card">
                    <h4>Head Office</h4>
                    <p><strong>Address:</strong> 123 Mfangano Street, Nairobi, CC 400001</p>
                    <p><strong>Phone:</strong> +123 98765 43210</p>
                    <p><strong>Email:</strong> info@alluringdecors.com</p>
                </div>
                <div class="service-card">
                    <h4>Get In Touch</h4>
                    <p>Ready to transform your space? Contact us today for a consultation and let us bring your vision to life.</p>
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