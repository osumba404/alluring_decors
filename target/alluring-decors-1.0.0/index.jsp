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
        <section class="hero">
            <div class="hero-content">
                <h2>Elegance Redefined</h2>
                <p>Transforming ordinary spaces into extraordinary experiences with bespoke interior and exterior designs.</p>
            </div>
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
        if (slides.length > 1) {
            setInterval(() => {
                changeSlide(1);
            }, 5000);
        }
    </script>
</body>
</html>