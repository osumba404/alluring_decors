<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback - Alluring Decors</title>
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
            <h1 class="fade-in">We Value Your Feedback</h1>
            <p class="fade-in">Share your thoughts, suggestions, or ask us any questions. We're here to help!</p>
        </div>
    </section>

    <main style="padding: 2rem 5%; min-height: 60vh;">
        <div class="container" style="max-width: 800px; margin: 0 auto;">

            <c:if test="${not empty success}">
                <div style="background: #d4edda; color: #155724; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid #c3e6cb;">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; border: 1px solid #f5c6cb;">
                    <i class="fas fa-exclamation-triangle"></i> ${error}
                </div>
            </c:if>

            <form method="post" class="auth-form slide-up" style="background: white; padding: 3rem; border-radius: 24px; box-shadow: var(--shadow-2xl); border: 1px solid var(--border-light); position: relative;">
                <div style="position: absolute; top: 0; left: 0; right: 0; height: 4px; background: var(--gradient-accent); border-radius: 24px 24px 0 0;"></div>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                    <div class="form-group">
                        <label for="name" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: var(--primary); font-size: 0.9rem;">
                            <i class="fas fa-user" style="margin-right: 0.5rem; color: var(--accent);"></i> Full Name
                        </label>
                        <input type="text" id="name" name="name" required 
                               style="width: 100%; padding: 1.2rem 1.5rem; border: 2px solid var(--border); border-radius: 12px; font-size: 1rem; transition: all var(--transition-normal); background: var(--white);">
                    </div>

                    <div class="form-group">
                        <label for="email" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: var(--primary); font-size: 0.9rem;">
                            <i class="fas fa-envelope" style="margin-right: 0.5rem; color: var(--accent);"></i> Email Address
                        </label>
                        <input type="email" id="email" name="email" required 
                               style="width: 100%; padding: 1.2rem 1.5rem; border: 2px solid var(--border); border-radius: 12px; font-size: 1rem; transition: all var(--transition-normal); background: var(--white);">
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label for="type" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: var(--primary); font-size: 0.9rem;">
                        <i class="fas fa-tag" style="margin-right: 0.5rem; color: var(--accent);"></i> Feedback Type
                    </label>
                    <select id="type" name="type" required 
                            style="width: 100%; padding: 1.2rem 1.5rem; border: 2px solid var(--border); border-radius: 12px; font-size: 1rem; transition: all var(--transition-normal); background: var(--white);">
                        <option value="">Select feedback type</option>
                        <option value="general">💬 General Feedback</option>
                        <option value="suggestion">💡 Suggestion</option>
                        <option value="complaint">⚠️ Complaint</option>
                        <option value="question">❓ Question</option>
                        <option value="compliment">⭐ Compliment</option>
                    </select>
                </div>

                <div class="form-group" style="margin-bottom: 2rem;">
                    <label for="message" style="display: block; margin-bottom: 0.75rem; font-weight: 600; color: var(--primary); font-size: 0.9rem;">
                        <i class="fas fa-comment" style="margin-right: 0.5rem; color: var(--accent);"></i> Your Message
                    </label>
                    <textarea id="message" name="message" rows="6" required placeholder="Please share your thoughts, questions, or feedback..."
                              style="width: 100%; padding: 1.2rem 1.5rem; border: 2px solid var(--border); border-radius: 12px; font-size: 1rem; resize: vertical; transition: all var(--transition-normal); background: var(--white); font-family: inherit;"></textarea>
                </div>

                <div style="text-align: center;">
                    <button type="submit" class="btn btn-primary"
                            style="background: var(--gradient-accent); color: white; padding: 1.2rem 3rem; border: none; border-radius: 12px; font-weight: 600; font-size: 1.1rem; cursor: pointer; transition: all var(--transition-normal); box-shadow: var(--shadow-lg);">
                        <i class="fas fa-paper-plane" style="margin-right: 0.5rem;"></i> Submit Feedback
                    </button>
                </div>
            </form>

            <div class="slide-up" style="margin-top: 4rem; text-align: center; padding: 3rem; background: white; border-radius: 20px; box-shadow: var(--shadow-lg); border: 1px solid var(--border-light);">
                <h3 style="color: var(--primary); margin-bottom: 2rem; font-size: 1.8rem;">Other Ways to Reach Us</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem;">
                    <div style="padding: 1.5rem; background: var(--bg-secondary); border-radius: 16px; transition: all var(--transition-normal);">
                        <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-size: 1.5rem;">
                            <i class="fas fa-phone"></i>
                        </div>
                        <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Call Us</h4>
                        <p style="color: var(--text-light);">Direct phone support<br><strong style="color: var(--primary);">+254 700 000 000</strong></p>
                    </div>
                    <div style="padding: 1.5rem; background: var(--bg-secondary); border-radius: 16px; transition: all var(--transition-normal);">
                        <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-size: 1.5rem;">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Email Us</h4>
                        <p style="color: var(--text-light);">Quick email response<br><strong style="color: var(--primary);">info@alluringdecors.com</strong></p>
                    </div>
                    <div style="padding: 1.5rem; background: var(--bg-secondary); border-radius: 16px; transition: all var(--transition-normal);">
                        <div style="width: 60px; height: 60px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1rem; color: white; font-size: 1.5rem;">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Business Hours</h4>
                        <p style="color: var(--text-light);">We're available<br><strong style="color: var(--primary);">Mon-Fri: 8AM-6PM</strong></p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <style>
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(230, 184, 0, 0.1);
            transform: translateY(-1px);
        }
        
        button:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-xl);
        }
        
        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl);
        }
    </style>

    <script>
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