<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alluring Decors - Transforming Spaces, Creating Dreams</title>
    <link rel="stylesheet" href="css/icons-final.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero-carousel">
            <c:forEach var="hero" items="${heroes}" varStatus="status">
                <div class="hero-slide ${status.index == 0 ? 'active' : ''}" style="background-image: <c:choose><c:when test='${hero.backgroundImage != null}'>url('${hero.backgroundImage}')</c:when><c:otherwise>linear-gradient(135deg, #164e31 0%, #295c19 100%)</c:otherwise></c:choose>">
                    <div class="hero-content">
                        <c:if test="${hero.subtitle != null}">
                            <span class="hero-subtitle">${hero.subtitle}</span>
                        </c:if>
                        <h2 class="hero-title">${hero.title}</h2>
                        <p class="hero-text">${hero.bodyText}</p>
                        <div class="hero-buttons">
                            <c:if test="${hero.primaryButton != null}">
                                <a href="${hero.primaryButtonLink}" class="btn btn-primary">${hero.primaryButton}</a>
                            </c:if>
                            <c:if test="${hero.secondaryButton != null}">
                                <a href="${hero.secondaryButtonLink}" class="btn btn-secondary">${hero.secondaryButton}</a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${fn:length(heroes) > 1}">
                <button class="carousel-btn prev" onclick="changeSlide(-1)">‹</button>
                <button class="carousel-btn next" onclick="changeSlide(1)">›</button>
                <div class="carousel-dots">
                    <c:forEach var="hero" items="${heroes}" varStatus="status">
                        <span class="dot ${status.index == 0 ? 'active' : ''}" onclick="currentSlide(${status.index + 1})"></span>
                    </c:forEach>
                </div>
            </c:if>
        </section>

        <section class="services-preview">
            <h3>Our Services</h3>
            <div class="services-grid">
                <div class="service-card">
                    <h4>Interior Design</h4>
                    <p>Complete interior transformation with modern aesthetics</p>
                </div>
                <div class="service-card">
                    <h4>Exterior Design</h4>
                    <p>Beautiful outdoor spaces and facade improvements</p>
                </div>
            </div>
        </section>

        <section class="projects-preview">
            <h3>Recent Projects</h3>
            <div class="projects-grid">
                <div class="project-card">
                    <h4>Modern Villa</h4>
                    <p>Contemporary design with elegant finishes</p>
                    <p><strong>Location:</strong> Nairobi</p>
                </div>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>

    <script>
        let currentSlideIndex = 0;
        const slides = document.querySelectorAll('.hero-slide');
        const dots = document.querySelectorAll('.dot');
        
        function showSlide(index) {
            slides.forEach(slide => slide.classList.remove('active'));
            dots.forEach(dot => dot.classList.remove('active'));
            
            if (slides[index]) {
                slides[index].classList.add('active');
                if (dots[index]) dots[index].classList.add('active');
            }
        }
        
        function changeSlide(direction) {
            currentSlideIndex += direction;
            if (currentSlideIndex >= slides.length) currentSlideIndex = 0;
            if (currentSlideIndex < 0) currentSlideIndex = slides.length - 1;
            showSlide(currentSlideIndex);
        }
        
        function currentSlide(index) {
            currentSlideIndex = index - 1;
            showSlide(currentSlideIndex);
        }
        
        // Auto-advance carousel
        setInterval(() => {
            changeSlide(1);
        }, 4000);
    </script>
</body>
</html>