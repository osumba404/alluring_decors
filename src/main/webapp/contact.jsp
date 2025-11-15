<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/fontawesome-fix.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
      

        <section class="services-preview">
            <div class="services-grid">
                <div class="service-card">
                    <h4>Contact Information</h4>
                    <c:choose>
                        <c:when test="${not empty contacts}">
                            <c:forEach var="contact" items="${contacts}" varStatus="status">
                                <c:if test="${status.index == 0}">
                                    <div style="margin-bottom: 2rem;">
                                        <p><i class="fas fa-phone"></i> <strong>Phone:</strong> ${contact.phone}</p>
                                        <p><i class="fas fa-envelope"></i> <strong>Email:</strong> ${contact.email}</p>
                                        <p><i class="fas fa-map-marker-alt"></i> <strong>Address:</strong><br>${contact.address}</p>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p>No contact information available at the moment. Please check back later.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>