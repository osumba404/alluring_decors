<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alluring Decors - Transforming Spaces, Creating Dreams</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <div class="nav-brand">
                <h1>Alluring Decors</h1>
            </div>
            <ul class="nav-menu">
                <li><a href="home">Home</a></li>
                <li><a href="about.jsp">About Us</a></li>
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
                <h2>Why Choose Alluring Decors?</h2>
                <p>Welcome to <strong>Alluring Decors</strong> — where imagination meets craftsmanship. With over 5 years of excellence in interior and exterior design, we transform ordinary spaces into breathtaking environments. Our team of creative designers and skilled artisans ensures every project reflects your unique style and vision. From luxurious homes to professional offices and grand banquet halls, we deliver perfection in every detail. Choose us for unmatched quality, timely delivery, and personalized service that turns your dreams into reality.</p>
            </div>
        </section>

        <section class="services-preview">
            <h3>Our Services</h3>
            <div class="services-grid">
                <c:forEach var="domain" items="${domains}">
                    <div class="service-card">
                        <h4>${domain.name}</h4>
                        <p>${domain.description}</p>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section class="projects-preview">
            <h3>Ongoing Projects</h3>
            <div class="projects-grid">
                <c:forEach var="project" items="${ongoingProjects}" varStatus="status">
                    <c:if test="${status.index < 3}">
                        <div class="project-card">
                            <h4>${project.title}</h4>
                            <p>${project.shortDescription}</p>
                            <p><strong>Location:</strong> ${project.location}</p>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 Alluring Decors. All rights reserved.</p>
    </footer>
</body>
</html>