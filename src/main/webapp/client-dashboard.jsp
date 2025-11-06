<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard - Alluring Decors</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <jsp:include page="WEB-INF/navigation.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Welcome to Your Dashboard</h2>
                <p>Manage your service requests and profile.</p>
            </div>
        </section>

        <section class="services-preview">
            <h3>Client Functions</h3>
            <div class="services-grid">
                <div class="service-card">
                    <h4>Request Service</h4>
                    <p>Submit new service requests</p>
                </div>
                <div class="service-card">
                    <h4>My Requests</h4>
                    <p>View and track your service requests</p>
                </div>
                <div class="service-card">
                    <h4>Profile</h4>
                    <p>Update your profile information</p>
                </div>
                <div class="service-card">
                    <h4>Feedback</h4>
                    <p>Submit feedback and queries</p>
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