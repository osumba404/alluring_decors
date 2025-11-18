<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alluring Decors - Transforming Spaces, Creating Dreams</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/modern-ui.css">
    <link rel="stylesheet" href="css/style.css">
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

        <section class="services-preview slide-up">
            <div style="text-align: center; margin-bottom: 4rem;">
                <h3 style="position: relative; display: inline-block;">Our Service Domains</h3>
                <p style="color: var(--text-light); font-size: 1.1rem; margin-top: 1rem;">Comprehensive interior and exterior design solutions</p>
            </div>
            <div class="services-grid">
                <c:forEach var="domain" items="${domains}" varStatus="status">
                    <c:if test="${status.index < 4}">
                        <div class="service-card slide-up" onclick="window.location.href='${pageContext.request.contextPath}/services/view-services?domainId=${domain.domainId}&domainName=${domain.name}'" style="cursor: pointer; position: relative; overflow: hidden;">
                            <div style="position: relative; overflow: hidden; border-radius: 15px 15px 0 0;">
                                <c:if test="${not empty domain.iconUrl}">
                                    <img src="${domain.iconUrl}" alt="${domain.name}" style="width: 100%; height: 220px; object-fit: cover; transition: transform var(--transition-normal);">
                                </c:if>
                                <c:if test="${empty domain.iconUrl}">
                                    <div style="width: 100%; height: 220px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;">
                                        <i class="fas fa-home"></i>
                                    </div>
                                </c:if>
                                <div style="position: absolute; top: 1rem; right: 1rem; background: rgba(0,0,0,0.7); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">
                                    ${domain.serviceCount} Services
                                </div>
                            </div>
                            <div style="padding: 2rem 1.5rem;">
                                <h4 style="margin-bottom: 1rem; font-size: 1.3rem;">${domain.name}</h4>
                                <p style="color: var(--text-light); line-height: 1.6; margin-bottom: 1.5rem;">${domain.description}</p>
                                <div style="display: flex; align-items: center; justify-content: space-between;">
                                    <span style="color: var(--accent); font-weight: 600; font-size: 0.9rem;">
                                        <i class="fas fa-arrow-right"></i> Explore Services
                                    </span>
                                    <div style="width: 40px; height: 40px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white;">
                                        <i class="fas fa-chevron-right"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <div style="text-align: center; margin-top: 3rem;">
                <a href="${pageContext.request.contextPath}/services" class="btn btn-primary" style="padding: 1.2rem 3rem; font-size: 1.1rem;">
                    <i class="fas fa-th-large"></i> View All Services
                </a>
            </div>
        </section>

        <section class="projects-preview">
            <h3>Recent Projects</h3>
            <div class="projects-grid">
                <c:forEach var="project" items="${recentProjects}" varStatus="status">
                    <c:if test="${status.index < 3}">
                        <div class="project-card">
                            <c:if test="${not empty project.thumbnailUrl}">
                                <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 15px 15px 0 0;">
                            </c:if>
                            <c:if test="${empty project.thumbnailUrl}">
                                <div style="width: 100%; height: 200px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem; border-radius: 15px 15px 0 0;">
                                    <i class="fas fa-building"></i>
                                </div>
                            </c:if>
                            <div style="padding: 1.5rem;">
                                <h4>${project.title}</h4>
                                <p>${project.shortDescription}</p>
                                <c:if test="${not empty project.location}">
                                    <p><strong>Location:</strong> ${project.location}</p>
                                </c:if>
                            </div>
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
        setInterval(() => {
            changeSlide(1);
        }, 4000);
        
        // Add hover effects to cards
        document.querySelectorAll('.service-card, .project-card').forEach(card => {
            card.style.cursor = 'pointer';
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
                this.style.boxShadow = 'var(--shadow-medium)';
            });
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
                this.style.boxShadow = 'var(--shadow-light)';
            });
        });
    </script>
</body>
</html>