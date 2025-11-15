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
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main style="padding: 2rem 5%; background: var(--bg); min-height: 80vh;">
        <div class="container" style="max-width: 900px; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: var(--primary); margin-bottom: 1rem;">Frequently Asked Questions</h2>
                <p style="color: #666; font-size: 1.1rem;">Find answers to common questions about our services and processes</p>
            </div>

            <div class="search-container" style="text-align: center; margin-bottom: 3rem;">
                <input type="text" id="faqSearch" placeholder="Search FAQs..." 
                       style="padding: 1rem 1.5rem; width: 100%; max-width: 500px; border: 2px solid var(--border); border-radius: 25px; font-size: 1rem; outline: none;"
                       onkeyup="searchFaqs()">
            </div>

            <c:choose>
                <c:when test="${not empty faqs}">
                    <div class="faq-container">
                        <c:forEach var="faq" items="${faqs}" varStatus="status">
                            <div class="faq-item" style="background: white; margin-bottom: 1rem; border-radius: 12px; box-shadow: var(--shadow-light); border: 1px solid var(--border); overflow: hidden;">
                                <div class="faq-question" onclick="toggleFaq(${status.index})" 
                                     style="padding: 1.5rem; cursor: pointer; display: flex; justify-content: space-between; align-items: center; background: var(--bg); border-bottom: 1px solid var(--border);">
                                    <h4 style="color: var(--primary); margin: 0; font-size: 1.1rem;">${faq.question}</h4>
                                    <i class="fas fa-chevron-down faq-icon" style="color: var(--accent); transition: transform 0.3s ease;"></i>
                                </div>
                                <div class="faq-answer" id="answer-${status.index}" 
                                     style="padding: 0 1.5rem; max-height: 0; overflow: hidden; transition: all 0.3s ease;">
                                    <div style="padding: 1.5rem 0;">
                                        <p style="color: #666; line-height: 1.6; margin: 0;">${faq.answer}</p>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 3rem; color: #666;">
                        <i class="fas fa-question-circle" style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"></i>
                        <h3>No FAQs available at the moment</h3>
                        <p>Please check back later or contact us directly for any questions.</p>
                    </div>
                </c:otherwise>
            </c:choose>

            <div style="margin-top: 3rem; text-align: center; padding: 2rem; background: white; border-radius: 15px; box-shadow: var(--shadow-light);">
                <h3 style="color: var(--primary); margin-bottom: 1rem;">Still Have Questions?</h3>
                <p style="color: #666; margin-bottom: 1.5rem;">Can't find what you're looking for? We're here to help!</p>
                <a href="${pageContext.request.contextPath}/feedback" 
                   style="background: var(--gradient-primary); color: white; padding: 1rem 2rem; text-decoration: none; border-radius: 8px; font-weight: 600; transition: all 0.3s ease;">
                    <i class="fas fa-comment"></i> Contact Us
                </a>
            </div>
        </div>
    </main>

    <script>
        function toggleFaq(index) {
            const answer = document.getElementById('answer-' + index);
            const icon = answer.previousElementSibling.querySelector('.faq-icon');
            
            if (answer.style.maxHeight === '0px' || answer.style.maxHeight === '') {
                answer.style.maxHeight = answer.scrollHeight + 'px';
                icon.style.transform = 'rotate(180deg)';
            } else {
                answer.style.maxHeight = '0px';
                icon.style.transform = 'rotate(0deg)';
            }
        }

        function searchFaqs() {
            const searchTerm = document.getElementById('faqSearch').value.toLowerCase();
            const faqItems = document.querySelectorAll('.faq-item');
            
            faqItems.forEach(item => {
                const question = item.querySelector('.faq-question h4').textContent.toLowerCase();
                const answer = item.querySelector('.faq-answer p').textContent.toLowerCase();
                
                if (question.includes(searchTerm) || answer.includes(searchTerm)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }
    </script>

    <style>
        .faq-question:hover {
            background: #f0f0f0;
        }
        
        #faqSearch:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(212, 160, 23, 0.1);
        }
        
        .faq-item:hover {
            box-shadow: var(--shadow-medium);
        }
    </style>
</body>
</html>