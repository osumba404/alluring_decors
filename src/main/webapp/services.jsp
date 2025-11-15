<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.alluringdecors.bean.ServiceBean" %>
<%@ page import="com.alluringdecors.model.Service" %>
<%@ page import="java.util.List" %>
<%
    ServiceBean serviceBean = new ServiceBean();
    List<Service> allServices = serviceBean.getAllServices();
    request.setAttribute("services", allServices);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Services - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="css/fontawesome-fix.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
     

        <section class="services-domains" style="padding: 4rem 2rem;">
            <div class="container">
                <h3 style="text-align: center; color: #164e31; margin-bottom: 2rem; font-size: 2rem;">Our Service Domains</h3>
                
                <div class="search-container" style="text-align: center; margin-bottom: 3rem;">
                    <input type="text" id="domainSearch" placeholder="Search domains..." 
                           style="padding: 1rem 1.5rem; width: 100%; max-width: 400px; border: 2px solid #E0E0E0; border-radius: 25px; font-size: 1rem; outline: none;"
                           onkeyup="searchDomains()">
                </div>
                
                <c:forEach var="domain" items="${domains}" varStatus="status">
                    <div class="domain-section" style="margin-bottom: 4rem; background: white; border-radius: 20px; box-shadow: var(--shadow-light); border: 1px solid var(--border); overflow: hidden; height: 300px;">
                        <div style="display: flex; height: 100%; ${status.index % 2 == 1 ? 'flex-direction: row-reverse;' : ''}">
                            <div style="width: 50%; height: 100%; position: relative;">
                                <c:if test="${not empty domain.iconUrl}">
                                    <img src="${domain.iconUrl}" alt="${domain.name}" style="width: 100%; height: 100%; object-fit: cover;">
                                </c:if>
                                <c:if test="${empty domain.iconUrl}">
                                    <div style="width: 100%; height: 100%; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-weight: 700; font-size: 4rem;">
                                        <i class="fas fa-home"></i>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div style="width: 50%; padding: 2rem; display: flex; flex-direction: column; justify-content: center;">
                                <h4 style="color: var(--primary); margin-bottom: 1rem; font-size: 1.8rem;">${domain.name}</h4>
                                <p style="color: #666; margin-bottom: 1.5rem; font-size: 1rem; line-height: 1.6;">${domain.description}</p>
                                
                                <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem;">
                                    <div style="background: var(--bg); padding: 0.8rem 1.2rem; border-radius: 8px; border: 1px solid var(--border);">
                                        <i class="fas fa-list" style="color: var(--accent); margin-right: 0.5rem;"></i>
                                        <span style="color: var(--accent); font-weight: 700; font-size: 1.2rem;">${domain.serviceCount}</span>
                                        <span style="color: #666; margin-left: 0.3rem;">Services</span>
                                    </div>
                                </div>
                                
                                <button class="view-services-btn" onclick="viewServices(${domain.domainId}, '${domain.name}')" 
                                        style="background: var(--gradient-primary); color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 10px; font-weight: 600; cursor: pointer; font-size: 0.95rem; transition: all 0.3s ease; align-self: flex-start;">
                                    <span style="margin-right: 0.5rem;">→</span>View Services
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <div style="text-align: center; margin-top: 3rem; padding: 2rem; background: #f8f9fa; border-radius: 12px;">
                    <h4 style="color: #164e31; margin-bottom: 1rem;">Multiple Domain Services</h4>
                    <p style="color: #666; margin-bottom: 2rem;">You can opt for more than one domain for comprehensive service coverage</p>
                    <a href="${pageContext.request.contextPath}/login.jsp" style="background: #164e31; color: #D4A017; padding: 15px 30px; text-decoration: none; border-radius: 8px; font-weight: 600;">View My Service Requests</a>
                </div>
            </div>
        </section>
        
        <script>
            function viewServices(domainId, domainName) {
                window.location.href = '${pageContext.request.contextPath}/services/view-services?domainId=' + domainId + '&domainName=' + encodeURIComponent(domainName);
            }
            
            function searchDomains() {
                const searchTerm = document.getElementById('domainSearch').value.toLowerCase();
                const domainSections = document.querySelectorAll('.domain-section');
                
                domainSections.forEach(section => {
                    const domainName = section.querySelector('h4').textContent.toLowerCase();
                    const domainDesc = section.querySelector('p').textContent.toLowerCase();
                    
                    if (domainName.includes(searchTerm) || domainDesc.includes(searchTerm)) {
                        section.style.display = 'block';
                    } else {
                        section.style.display = 'none';
                    }
                });
            }
            
            // Fallback icon loader
            // document.addEventListener('DOMContentLoaded', function() {
            //     setTimeout(function() {
            //         const icons = document.querySelectorAll('.fas');
            //         icons.forEach(function(icon) {
            //             if (icon.offsetWidth === 0 || icon.offsetHeight === 0) {
            //                 if (icon.classList.contains('fa-home')) {
            //                     icon.innerHTML = '🏠';
            //                 } else if (icon.classList.contains('fa-list')) {
            //                     icon.innerHTML = '📋';
            //                 } else if (icon.classList.contains('fa-arrow-right')) {
            //                     icon.innerHTML = '→';
            //                 }
            //             }
            //         });
            //     }, 1000);
            // });
        </script>
        
        <style>
            .view-services-btn:hover {
                transform: translateY(-3px);
                box-shadow: var(--shadow-heavy);
            }
            
            .domain-section:hover {
                transform: translateY(-5px);
                box-shadow: var(--shadow-medium);
            }
            
            #domainSearch:focus {
                border-color: var(--accent);
                box-shadow: 0 0 0 3px rgba(212, 160, 23, 0.1);
            }
            
            /* Ensure FontAwesome icons display */
            .fas, .far, .fab, .fa {
                font-family: "Font Awesome 6 Free", "Font Awesome 5 Free", "FontAwesome" !important;
                font-weight: 900 !important;
                display: inline-block !important;
                font-style: normal !important;
                font-variant: normal !important;
                text-rendering: auto !important;
                -webkit-font-smoothing: antialiased !important;
            }
            
            /* Force icon display with content fallback */
            .fas.fa-home::before { content: "\f015" !important; }
            .fas.fa-list::before { content: "\f03a" !important; }
            .fas.fa-arrow-right::before { content: "\f061" !important; }
            
            /* Fallback if FontAwesome completely fails */
            /* .fas.fa-home:empty::after { content: "🏠" !important; }
            .fas.fa-list:empty::after { content: "📋" !important; }
            .fas.fa-arrow-right:empty::after { content: "→" !important; } */
        </style>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>