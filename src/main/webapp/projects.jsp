<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projects - Alluring Decors</title>
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
                <h2>Our Projects</h2>
            </div>
        </section>

        <section class="projects-preview">
            <h3>Ongoing Projects</h3>
            <div class="projects-grid">
                <div class="project-card">
                    <h4>Modern Villa Interior</h4>
                    <p>Complete home makeover with contemporary design</p>
                    <p><strong>Location:</strong> Nairobi, Kenya</p>
                </div>
            </div>

            <h3>Accomplished Projects</h3>
            <div class="projects-grid">
                <div class="project-card">
                    <h4>Corporate Office Design</h4>
                    <p>Professional workspace renovation</p>
                    <p><strong>Location:</strong> Mombasa, Kenya</p>
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