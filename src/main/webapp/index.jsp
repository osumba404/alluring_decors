<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alluring Decors - Transforming Spaces, Creating Dreams</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero-carousel">
            <c:choose>
                <c:when test="${not empty heroes}">
                    <c:forEach var="hero" items="${heroes}" varStatus="status">
                        <div class="hero-slide ${status.index == 0 ? 'active' : ''}" style="background-image: url('${hero.backgroundImage}')">
                            <div class="hero-content">
                                <c:if test="${not empty hero.subtitle}"><span class="hero-subtitle">${hero.subtitle}</span></c:if>
                                <h2 class="hero-title">${hero.title}</h2>
                                <p class="hero-text">${hero.bodyText}</p>
                                <div class="hero-buttons">
                                    <c:if test="${not empty hero.primaryButton}">
                                        <a href="${hero.primaryButtonLink}" class="btn btn-primary">${hero.primaryButton}</a>
                                    </c:if>
                                    <c:if test="${not empty hero.secondaryButton}">
                                        <a href="${hero.secondaryButtonLink}" class="btn btn-secondary">${hero.secondaryButton}</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${heroes.size() > 1}">
                        <div class="carousel-controls">
                            <button class="carousel-btn prev" onclick="changeSlide(-1)">❮</button>
                            <button class="carousel-btn next" onclick="changeSlide(1)">❯</button>
                        </div>
                        <div class="carousel-dots">
                            <c:forEach var="hero" items="${heroes}" varStatus="status">
                                <span class="dot ${status.index == 0 ? 'active' : ''}" onclick="currentSlide(${status.index + 1})"></span>
                            </c:forEach>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="hero-slide active" style="background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%)">
                        <div class="hero-content">
                            <span class="hero-subtitle">Welcome to</span>
                            <h2 class="hero-title">Elegance Redefined</h2>
                            <p class="hero-text">Transforming ordinary spaces into extraordinary experiences with bespoke interior and exterior designs.</p>
                            <div class="hero-buttons">
                                <a href="services" class="btn btn-primary">Explore Services</a>
                                <a href="contact" class="btn btn-secondary">Get Quote</a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
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
        if (slides.length > 1) {
            setInterval(() => {
                changeSlide(1);
            }, 5000);
        }
    </script>
</body>
</html>