<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.alluringdecors.bean.ContentBean" %>
<%@ page import="java.util.Map" %>
<%
    ContentBean contentBean = new ContentBean();
    String aboutContent = contentBean.getContentByKey("about_us");
    Map<String, String> allContent = contentBean.getAllContent();
    request.setAttribute("aboutContent", aboutContent);
    request.setAttribute("allContent", allContent);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="css/modern-ui.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <!-- Hero Section -->
        <section class="contact-hero">
            <div class="container">
                <h1 class="fade-in">About Alluring Decors</h1>
                <p class="fade-in">Transforming spaces, creating dreams, and bringing your vision to life</p>
            </div>
        </section>

        <!-- Content Sections -->
        <c:choose>
            <c:when test="${not empty allContent}">
                <section style="padding: 4rem 5%; max-width: 1200px; margin: 0 auto;">
                    <div class="content-grid" style="display: grid; gap: 3rem;">
                        <c:forEach var="content" items="${allContent}" varStatus="status">
                            <div class="content-item slide-up" style="background: var(--white); padding: 3rem; border-radius: 20px; box-shadow: var(--shadow-lg); border: 1px solid var(--border-light); transition: all var(--transition-normal);">
                                <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 2rem;">
                                    <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; font-size: 1.5rem;">
                                        <c:choose>
                                            <c:when test="${content.key.contains('mission')}">
                                                <i class="fas fa-bullseye"></i>
                                            </c:when>
                                            <c:when test="${content.key.contains('vision')}">
                                                <i class="fas fa-eye"></i>
                                            </c:when>
                                            <c:when test="${content.key.contains('about')}">
                                                <i class="fas fa-info-circle"></i>
                                            </c:when>
                                            <c:when test="${content.key.contains('service')}">
                                                <i class="fas fa-cogs"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <h3 style="color: var(--primary); margin: 0; font-size: 1.8rem; text-transform: capitalize;">
                                        ${content.key.replace('_', ' ')}
                                    </h3>
                                </div>
                                <p style="color: var(--text-light); line-height: 1.8; font-size: 1.1rem; margin: 0;">${content.value}</p>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </c:when>
            <c:otherwise>
                <section style="padding: 4rem 5%; text-align: center;">
                    <div style="background: var(--white); padding: 4rem 2rem; border-radius: 20px; box-shadow: var(--shadow-lg); max-width: 600px; margin: 0 auto;">
                        <div style="width: 80px; height: 80px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2rem; color: white; font-size: 2rem;">
                            <i class="fas fa-info-circle"></i>
                        </div>
                        <h3 style="color: var(--primary); margin-bottom: 1rem;">Content Coming Soon</h3>
                        <p style="color: var(--text-light); margin-bottom: 2rem;">We're updating our about section with exciting new content. Please check back soon!</p>
                        <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary">Contact Us</a>
                    </div>
                </section>
            </c:otherwise>
        </c:choose>

        <!-- Values Section -->
        <section style="padding: 4rem 5%; background: var(--white); margin: 4rem 0; border-radius: 2rem; max-width: 1200px; margin-left: auto; margin-right: auto; box-shadow: var(--shadow-sm);">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: var(--primary); margin-bottom: 1rem;">Our Core Values</h2>
                <p style="color: var(--text-light); font-size: 1.1rem;">The principles that guide everything we do</p>
            </div>
            
            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 2rem;">
                <div class="slide-up" style="text-align: center; padding: 2rem; background: var(--bg-secondary); border-radius: 16px; transition: all var(--transition-normal);">
                    <div style="width: 70px; height: 70px; background: var(--gradient-primary); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: white; font-size: 1.8rem;">
                        <i class="fas fa-lightbulb"></i>
                    </div>
                    <h4 style="margin-bottom: 1rem; color: var(--primary);">Innovation</h4>
                    <p style="color: var(--text-light); line-height: 1.6;">We constantly explore new design trends and technologies to bring fresh, creative solutions to every project.</p>
                </div>
                
                <div class="slide-up" style="text-align: center; padding: 2rem; background: var(--bg-secondary); border-radius: 16px; transition: all var(--transition-normal);">
                    <div style="width: 70px; height: 70px; background: var(--gradient-primary); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: white; font-size: 1.8rem;">
                        <i class="fas fa-handshake"></i>
                    </div>
                    <h4 style="margin-bottom: 1rem; color: var(--primary);">Integrity</h4>
                    <p style="color: var(--text-light); line-height: 1.6;">Honest communication, transparent pricing, and ethical business practices form the foundation of our relationships.</p>
                </div>
                
                <div class="slide-up" style="text-align: center; padding: 2rem; background: var(--bg-secondary); border-radius: 16px; transition: all var(--transition-normal);">
                    <div style="width: 70px; height: 70px; background: var(--gradient-primary); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: white; font-size: 1.8rem;">
                        <i class="fas fa-gem"></i>
                    </div>
                    <h4 style="margin-bottom: 1rem; color: var(--primary);">Excellence</h4>
                    <p style="color: var(--text-light); line-height: 1.6;">We strive for perfection in every detail, ensuring the highest quality in materials, craftsmanship, and service.</p>
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
        // Add hover effects to content items
        document.addEventListener('DOMContentLoaded', () => {
            const contentItems = document.querySelectorAll('.content-item');
            contentItems.forEach(item => {
                item.addEventListener('mouseenter', () => {
                    item.style.transform = 'translateY(-5px)';
                    item.style.boxShadow = 'var(--shadow-xl)';
                });
                item.addEventListener('mouseleave', () => {
                    item.style.transform = 'translateY(0)';
                    item.style.boxShadow = 'var(--shadow-lg)';
                });
            });

            // Animation observer
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