<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/modern-ui.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <!-- Hero Section -->
    <section class="contact-hero">
        <div class="container">
            <h1 class="fade-in">Frequently Asked Questions</h1>
            <p class="fade-in">Find answers to common questions about our services and processes</p>
        </div>
    </section>

    <main style="padding: 2rem 5%; min-height: 60vh;">
        <div class="container" style="max-width: 900px; margin: 0 auto;">

            <div class="search-container" style="text-align: center; margin-bottom: 3rem;">
                <input type="text" id="faqSearch" placeholder="Search FAQs..." 
                       style="padding: 1rem 1.5rem; width: 100%; max-width: 500px; border: 2px solid var(--border); border-radius: 25px; font-size: 1rem; outline: none;"
                       onkeyup="searchFaqs()">
            </div>

            <c:choose>
                <c:when test="${not empty faqs}">
                    <div class="faq-container">
                        <c:forEach var="faq" items="${faqs}" varStatus="status">
                            <div class="faq-item slide-up" style="background: white; margin-bottom: 1.5rem; border-radius: 16px; box-shadow: var(--shadow-md); border: 1px solid var(--border-light); overflow: hidden; transition: all var(--transition-normal);">
                                <div class="faq-question" onclick="toggleFaq(${status.index})" 
                                     style="padding: 2rem; cursor: pointer; display: flex; justify-content: space-between; align-items: center; background: var(--bg-secondary); transition: all var(--transition-normal);">
                                    <h4 style="color: var(--primary); margin: 0; font-size: 1.2rem; font-weight: 600;">${faq.question}</h4>
                                    <div style="width: 40px; height: 40px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: transform var(--transition-normal);">
                                        <i class="fas fa-chevron-down faq-icon" style="transition: transform var(--transition-normal);"></i>
                                    </div>
                                </div>
                                <div class="faq-answer" id="answer-${status.index}" 
                                     style="padding: 0 2rem; max-height: 0; overflow: hidden; transition: all var(--transition-normal);">
                                    <div style="padding: 2rem 0;">
                                        <p style="color: var(--text-light); line-height: 1.8; margin: 0; font-size: 1.05rem;">${faq.answer}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 4rem 2rem; background: white; border-radius: 20px; box-shadow: var(--shadow-lg);">
                        <div style="width: 80px; height: 80px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2rem; color: white; font-size: 2rem;">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <h3 style="color: var(--primary); margin-bottom: 1rem;">No FAQs available at the moment</h3>
                        <p style="color: var(--text-light); margin-bottom: 2rem;">Please check back later or contact us directly for any questions.</p>
                        <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary">Contact Us</a>
                    </div>
                </c:otherwise>
            </c:choose>

            <div class="slide-up" style="margin-top: 4rem; text-align: center; padding: 3rem; background: white; border-radius: 20px; box-shadow: var(--shadow-lg); border: 1px solid var(--border-light);">
                <div style="width: 80px; height: 80px; background: var(--gradient-primary); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2rem; color: white; font-size: 2rem;">
                    <i class="fas fa-headset"></i>
                </div>
                <h3 style="color: var(--primary); margin-bottom: 1rem; font-size: 1.8rem;">Still Have Questions?</h3>
                <p style="color: var(--text-light); margin-bottom: 2rem; font-size: 1.1rem;">Can't find what you're looking for? We're here to help!</p>
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/feedback" class="btn btn-primary">
                        <i class="fas fa-comment"></i> Send Message
                    </a>
                    <a href="${pageContext.request.contextPath}/contact" class="btn btn-secondary">
                        <i class="fas fa-phone"></i> Contact Us
                    </a>
                </div>
            </div>
        </div>
    </main>

    <script>
        function toggleFaq(index) {
            const answer = document.getElementById('answer-' + index);
            const faqItem = answer.closest('.faq-item');
            const icon = answer.previousElementSibling.querySelector('.faq-icon');
            
            // Close all other FAQs
            document.querySelectorAll('.faq-item').forEach((item, i) => {
                if (i !== index) {
                    const otherAnswer = item.querySelector('.faq-answer');
                    const otherIcon = item.querySelector('.faq-icon');
                    otherAnswer.style.maxHeight = '0px';
                    otherIcon.style.transform = 'rotate(0deg)';
                    item.classList.remove('active');
                }
            });
            
            if (answer.style.maxHeight === '0px' || answer.style.maxHeight === '') {
                answer.style.maxHeight = answer.scrollHeight + 'px';
                icon.style.transform = 'rotate(180deg)';
                faqItem.classList.add('active');
            } else {
                answer.style.maxHeight = '0px';
                icon.style.transform = 'rotate(0deg)';
                faqItem.classList.remove('active');
            }
        }

        function searchFaqs() {
            const searchTerm = document.getElementById('faqSearch').value.toLowerCase();
            const faqItems = document.querySelectorAll('.faq-item');
            let visibleCount = 0;
            
            faqItems.forEach(item => {
                const question = item.querySelector('.faq-question h4').textContent.toLowerCase();
                const answer = item.querySelector('.faq-answer p').textContent.toLowerCase();
                
                if (question.includes(searchTerm) || answer.includes(searchTerm)) {
                    item.style.display = 'block';
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                    visibleCount++;
                } else {
                    item.style.display = 'none';
                }
            });
            
            // Show no results message if needed
            const container = document.querySelector('.faq-container');
            let noResults = container.querySelector('.no-results');
            
            if (visibleCount === 0 && searchTerm.length > 0) {
                if (!noResults) {
                    noResults = document.createElement('div');
                    noResults.className = 'no-results';
                    noResults.innerHTML = `
                        <div style="text-align: center; padding: 3rem; background: white; border-radius: 16px; box-shadow: var(--shadow-md);">
                            <i class="fas fa-search" style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"></i>
                            <h4 style="color: var(--primary); margin-bottom: 0.5rem;">No results found</h4>
                            <p style="color: var(--text-light);">Try different keywords or contact us directly.</p>
                        </div>
                    `;
                    container.appendChild(noResults);
                }
                noResults.style.display = 'block';
            } else if (noResults) {
                noResults.style.display = 'none';
            }
        }
        
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

        document.addEventListener('DOMContentLoaded', () => {
            const animatedElements = document.querySelectorAll('.slide-up, .fade-in');
            animatedElements.forEach((el, index) => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = `all 0.6s ease-out ${index * 0.1}s`;
                observer.observe(el);
            });
        });
    </script>

    <style>
        .faq-question:hover {
            background: var(--bg);
            transform: translateX(5px);
        }
        
        #faqSearch:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(230, 184, 0, 0.1);
        }
        
        .faq-item:hover {
            box-shadow: var(--shadow-xl);
            transform: translateY(-2px);
        }
        
        .faq-item.active .faq-question {
            background: var(--primary);
            color: white;
        }
        
        .faq-item.active .faq-question h4 {
            color: white;
        }
        
        .faq-item.active .faq-question .faq-icon {
            transform: rotate(180deg);
        }
    </style>
</body>
</html>