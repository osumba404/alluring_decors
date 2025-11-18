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
    <link rel="stylesheet" href="css/modern-ui.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <!-- Hero Section -->
        <section class="contact-hero">
            <div class="container">
                <h1 class="fade-in">Get In Touch</h1>
                <p class="fade-in">We're here to help bring your vision to life. Reach out to us anytime.</p>
            </div>
        </section>

        <!-- Contact Cards -->
        <section class="contact-grid slide-up">
            <c:choose>
                <c:when test="${not empty contacts}">
                    <c:forEach var="contact" items="${contacts}" varStatus="status">
                        <c:if test="${status.index == 0}">
                            <div class="contact-card">
                                <div class="contact-icon">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <h3>Call Us</h3>
                                <p><strong>${contact.phone}</strong></p>
                                <p>Mon - Fri: 8:00 AM - 6:00 PM<br>Sat: 9:00 AM - 4:00 PM</p>
                            </div>
                            
                            <div class="contact-card">
                                <div class="contact-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <h3>Email Us</h3>
                                <p><strong>${contact.email}</strong></p>
                                <p>We'll respond within 24 hours</p>
                            </div>
                            
                            <div class="contact-card">
                                <div class="contact-icon">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <h3>Visit Us</h3>
                                <p><strong>${contact.address}</strong></p>
                                <p>Come see our showroom and portfolio</p>
                            </div>
                        </c:if>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="contact-card">
                        <div class="contact-icon">
                            <i class="fas fa-info-circle"></i>
                        </div>
                        <h3>Information</h3>
                        <p>Contact information is being updated. Please check back soon or use our feedback form.</p>
                        <a href="${pageContext.request.contextPath}/feedback" class="btn btn-primary" style="margin-top: 1rem;">Send Message</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <!-- Additional Info Section -->
        <section style="padding: 4rem 5%; background: var(--white); margin: 4rem 0; border-radius: 2rem; max-width: 1200px; margin-left: auto; margin-right: auto; box-shadow: var(--shadow-sm);">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: var(--primary); margin-bottom: 1rem;">Why Choose Alluring Decors?</h2>
                <p style="color: var(--text-light); font-size: 1.1rem;">Experience the difference with our professional interior design services</p>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem;">
                <div style="text-align: center; padding: 2rem;">
                    <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-size: 1.5rem;">
                        <i class="fas fa-award"></i>
                    </div>
                    <h4 style="margin-bottom: 0.5rem;">Expert Team</h4>
                    <p style="color: var(--text-light);">Professional designers with years of experience</p>
                </div>
                
                <div style="text-align: center; padding: 2rem;">
                    <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-size: 1.5rem;">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h4 style="margin-bottom: 0.5rem;">Timely Delivery</h4>
                    <p style="color: var(--text-light);">Projects completed on schedule, every time</p>
                </div>
                
                <div style="text-align: center; padding: 2rem;">
                    <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-size: 1.5rem;">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h4 style="margin-bottom: 0.5rem;">Customer Satisfaction</h4>
                    <p style="color: var(--text-light);">Your happiness is our top priority</p>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>

    <script>
        // Add animation classes when elements come into view
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        document.addEventListener('DOMContentLoaded', () => {
            const animatedElements = document.querySelectorAll('.slide-up, .fade-in');
            animatedElements.forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = 'all 0.6s ease-out';
                observer.observe(el);
            });
        });
    </script>
</body>
</html>