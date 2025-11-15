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
    <link rel="stylesheet" href="css/fontawesome-fix.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main style="padding: 2rem 5%; background: var(--bg); min-height: 80vh;">
        <div class="container" style="max-width: 800px; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: var(--primary); margin-bottom: 1rem;">We Value Your Feedback</h2>
                <p style="color: #666; font-size: 1.1rem;">Share your thoughts, suggestions, or ask us any questions. We're here to help!</p>
            </div>

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

            <form method="post" style="background: white; padding: 3rem; border-radius: 20px; box-shadow: var(--shadow-medium); border: 1px solid var(--border);">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin-bottom: 1.5rem;">
                    <div class="form-group">
                        <label for="name" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--primary);">
                            <i class="fas fa-user"></i> Full Name
                        </label>
                        <input type="text" id="name" name="name" required 
                               style="width: 100%; padding: 1rem; border: 2px solid var(--border); border-radius: 8px; font-size: 1rem;">
                    </div>

                    <div class="form-group">
                        <label for="email" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--primary);">
                            <i class="fas fa-envelope"></i> Email Address
                        </label>
                        <input type="email" id="email" name="email" required 
                               style="width: 100%; padding: 1rem; border: 2px solid var(--border); border-radius: 8px; font-size: 1rem;">
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label for="type" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--primary);">
                        <i class="fas fa-tag"></i> Feedback Type
                    </label>
                    <select id="type" name="type" required 
                            style="width: 100%; padding: 1rem; border: 2px solid var(--border); border-radius: 8px; font-size: 1rem;">
                        <option value="">Select feedback type</option>
                        <option value="general">General Feedback</option>
                        <option value="suggestion">Suggestion</option>
                        <option value="complaint">Complaint</option>
                        <option value="question">Question</option>
                        <option value="compliment">Compliment</option>
                    </select>
                </div>

                <div class="form-group" style="margin-bottom: 2rem;">
                    <label for="message" style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: var(--primary);">
                        <i class="fas fa-comment"></i> Your Message
                    </label>
                    <textarea id="message" name="message" rows="6" required placeholder="Please share your thoughts, questions, or feedback..."
                              style="width: 100%; padding: 1rem; border: 2px solid var(--border); border-radius: 8px; font-size: 1rem; resize: vertical;"></textarea>
                </div>

                <div style="text-align: center;">
                    <button type="submit" 
                            style="background: var(--gradient-primary); color: white; padding: 1rem 3rem; border: none; border-radius: 12px; font-weight: 600; font-size: 1.1rem; cursor: pointer; transition: all 0.3s ease;">
                        <i class="fas fa-paper-plane"></i> Submit Feedback
                    </button>
                </div>
            </form>

            <div style="margin-top: 3rem; text-align: center; padding: 2rem; background: white; border-radius: 15px; box-shadow: var(--shadow-light);">
                <h3 style="color: var(--primary); margin-bottom: 1rem;">Other Ways to Reach Us</h3>
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                    <div>
                        <i class="fas fa-phone" style="color: var(--accent); font-size: 1.5rem; margin-bottom: 0.5rem;"></i>
                        <p style="color: #666;">Call us at<br><strong>+254 700 000 000</strong></p>
                    </div>
                    <div>
                        <i class="fas fa-envelope" style="color: var(--accent); font-size: 1.5rem; margin-bottom: 0.5rem;"></i>
                        <p style="color: #666;">Email us at<br><strong>info@alluringdecors.com</strong></p>
                    </div>
                    <div>
                        <i class="fas fa-clock" style="color: var(--accent); font-size: 1.5rem; margin-bottom: 0.5rem;"></i>
                        <p style="color: #666;">Business Hours<br><strong>Mon-Fri: 8AM-6PM</strong></p>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <style>
        .form-group input:focus, .form-group select:focus, .form-group textarea:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(212, 160, 23, 0.1);
        }
        
        button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-heavy);
        }
    </style>
</body>
</html>