<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Service - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/fontawesome-fix.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero-section" style="background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%); padding: 4rem 0; margin-bottom: 3rem;">
            <div class="container">
                <div class="hero-content" style="text-align: center; color: #D4A017;">
                    <h1 style="font-size: 2.5rem; margin-bottom: 1rem;">Request Service</h1>
                    <p style="font-size: 1.2rem; opacity: 0.9;">Tell us about your project and we'll get back to you</p>
                </div>
            </div>
        </section>

        <section class="services-preview">
            <div class="container">
                <div class="auth-container" style="max-width: 600px; margin: 0 auto;">
                    <form class="auth-form" method="post" style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 8px 25px rgba(0,0,0,0.1);">
                        <c:if test="${not empty param.error}">
                            <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                                ${param.error}
                            </div>
                        </c:if>

                        <div class="form-group">
                            <label for="name">Full Name</label>
                            <input type="text" id="name" name="name" value="${loggedInUser.fullName}" readonly required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" value="${loggedInUser.email}" readonly required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="tel" id="phone" name="phone" value="${loggedInUser.phone}" readonly required>
                        </div>

                        <div class="form-group">
                            <label for="domain">Service Domain</label>
                            <input type="text" id="domain" name="domain" value="${selectedDomain}" readonly>
                        </div>

                        <div class="form-group">
                            <label for="description">Project Description</label>
                            <textarea id="description" name="description" rows="4" placeholder="Describe your project requirements..." required></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; font-size: 1.1rem;">Submit Request</button>
                    </form>
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