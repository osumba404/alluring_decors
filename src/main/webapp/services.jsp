<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="WEB-INF/navigation.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Our Services</h2>
            </div>
        </section>

        <section class="services-preview">
            <div class="services-grid">
                <div class="service-card">
                    <h4>Home Decoration</h4>
                    <p>Complete interior and exterior design for residential spaces including furniture, kitchen design, lighting effects, and more.</p>
                </div>
                <div class="service-card">
                    <h4>Office Decoration</h4>
                    <p>Professional and modern office interiors with partitioning, lighting, and ergonomic design solutions.</p>
                </div>
                <div class="service-card">
                    <h4>Banquet & Function Halls</h4>
                    <p>Elegant decoration for events, weddings, seminars, and corporate functions.</p>
                </div>
                <div class="service-card">
                    <h4>Restaurant Decoration</h4>
                    <p>Stylish and functional restaurant interiors that enhance dining experiences.</p>
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