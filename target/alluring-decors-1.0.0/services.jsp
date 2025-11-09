<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services - Alluring Decors</title>
    <link rel="stylesheet" href="css/fontawesome.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Our Services</h2>
                <p>Comprehensive interior and exterior design solutions tailored to your unique vision and lifestyle.</p>
            </div>
        </section>

        <section class="services-preview">
            <h3>Service Domains</h3>
            <div class="services-grid">
                <c:forEach var="domain" items="${domains}">
                    <div class="service-card">
                        <h4>${domain.name}</h4>
                        <p>${domain.description}</p>
                    </div>
                </c:forEach>
            </div>
        </section>

        <c:if test="${not empty services}">
            <section class="services-preview">
                <h3>Available Services</h3>
                <div class="services-grid">
                    <c:forEach var="service" items="${services}">
                        <div class="service-card">
                            <h4>${service.name}</h4>
                            <p>${service.description}</p>
                            <c:if test="${service.pricePerSqft != null}">
                                <p><strong>Starting from: $${service.pricePerSqft}/sqft</strong></p>
                            </c:if>
                        </div>
                    </c:forEach>
                </div>
            </section>
        </c:if>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>