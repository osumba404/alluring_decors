<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Alluring Decors</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Contact Us</h2>
                <p>Get in touch with our design experts to transform your space into something extraordinary.</p>
            </div>
        </section>

        <section class="services-preview">
            <div class="services-grid">
                <div class="service-card">
                    <h4>Get a Quote</h4>
                    <form class="auth-form" method="post" action="contact">
                        <div class="form-group">
                            <label>Your Name</label>
                            <input type="text" name="name" required>
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" name="email" required>
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="tel" name="phone">
                        </div>
                        <div class="form-group">
                            <label>Project Type</label>
                            <select name="projectType" required>
                                <option value="">Select a service</option>
                                <option value="home">Home Decoration</option>
                                <option value="office">Office Decoration</option>
                                <option value="restaurant">Restaurant Decoration</option>
                                <option value="banquet">Banquet & Function Halls</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Message</label>
                            <textarea name="message" rows="4" placeholder="Tell us about your project..."></textarea>
                        </div>
                        <button type="submit" class="btn-primary">Send Message</button>
                    </form>
                </div>

                <div class="service-card">
                    <h4>Contact Information</h4>
                    <c:choose>
                        <c:when test="${not empty contacts}">
                            <c:forEach var="contact" items="${contacts}" varStatus="status">
                                <c:if test="${status.index == 0}">
                                    <div style="margin-bottom: 2rem;">
                                        <p><strong>Phone:</strong> ${contact.phone}</p>
                                        <p><strong>Email:</strong> ${contact.email}</p>
                                        <p><strong>Address:</strong><br>${contact.address}</p>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div style="margin-bottom: 2rem;">
                                <p><strong>Phone:</strong> +1 (555) 123-4567</p>
                                <p><strong>Email:</strong> info@alluringdecors.com</p>
                                <p><strong>Address:</strong><br>123 Design Street<br>Creative City, CC 12345</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <h4>Business Hours</h4>
                    <p><strong>Monday - Friday:</strong> 9:00 AM - 6:00 PM</p>
                    <p><strong>Saturday:</strong> 10:00 AM - 4:00 PM</p>
                    <p><strong>Sunday:</strong> Closed</p>
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