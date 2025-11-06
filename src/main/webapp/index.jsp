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
    <jsp:include page="WEB-INF/navigation.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Elegance Redefined</h2>
                <p>Transforming ordinary spaces into extraordinary experiences with bespoke interior and exterior designs. Where imagination meets craftsmanship, and every detail reflects your unique vision.</p>
                <a href="services.jsp" class="btn">Explore Our Services</a>
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
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>