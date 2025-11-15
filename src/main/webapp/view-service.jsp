<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${service.name} - Alluring Decors</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />

    <main style="padding: 2rem 5%; background: var(--bg); min-height: 80vh;">
        <div class="container" style="max-width: 800px; margin: 0 auto;">
            <c:choose>
                <c:when test="${service != null}">
                    <div class="service-detail" style="background: white; padding: 3rem; border-radius: 20px; box-shadow: var(--shadow-medium); border: 1px solid var(--border);">
                        <div style="text-align: center; margin-bottom: 2rem;">
                            <span style="background: var(--bg); color: var(--primary); padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.9rem; font-weight: 600;">
                                ${domain.name}
                            </span>
                        </div>
                        
                        <h1 style="color: var(--primary); text-align: center; margin-bottom: 2rem; font-size: 2.5rem;">${service.name}</h1>
                        
                        <div style="margin-bottom: 3rem;">
                            <h3 style="color: var(--primary); margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                                <i class="fas fa-info-circle"></i> Service Description
                            </h3>
                            <p style="color: #666; line-height: 1.8; font-size: 1.1rem;">${service.description}</p>
                        </div>
                        
                        <div style="background: var(--bg); padding: 2rem; border-radius: 15px; margin-bottom: 3rem;">
                            <h3 style="color: var(--primary); margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem;">
                                <i class="fas fa-money-bill-wave"></i> Pricing Information
                            </h3>
                            
                            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem;">
                                <c:if test="${service.basePrice != null}">
                                    <div style="background: white; padding: 1.5rem; border-radius: 10px; text-align: center; border: 2px solid var(--border);">
                                        <i class="fas fa-tag" style="color: var(--accent); font-size: 1.5rem; margin-bottom: 0.5rem;"></i>
                                        <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Base Price</h4>
                                        <p style="color: var(--accent); font-weight: 700; font-size: 1.3rem;">KES ${service.basePrice}</p>
                                    </div>
                                </c:if>
                                
                                <div style="background: white; padding: 1.5rem; border-radius: 10px; text-align: center; border: 2px solid var(--accent);">
                                    <i class="fas fa-calculator" style="color: var(--accent); font-size: 1.5rem; margin-bottom: 0.5rem;"></i>
                                    <h4 style="color: var(--primary); margin-bottom: 0.5rem;">Per ${service.unit}</h4>
                                    <p style="color: var(--accent); font-weight: 700; font-size: 1.3rem;">KES ${service.pricePerSqft}</p>
                                </div>
                            </div>
                        </div>
                        
                        <div style="text-align: center;">
                            <button onclick="requestService('${domain.name}')" 
                                    style="background: var(--gradient-primary); color: white; padding: 1.2rem 3rem; border: none; border-radius: 12px; font-weight: 600; font-size: 1.1rem; cursor: pointer; margin-right: 1rem; transition: all 0.3s ease;">
                                <i class="fas fa-paper-plane"></i> Request Service
                            </button>
                            
                            <a href="${pageContext.request.contextPath}/services/view-services?domainId=${domain.domainId}&domainName=${domain.name}" 
                               style="background: transparent; border: 2px solid var(--primary); color: var(--primary); padding: 1.2rem 2rem; text-decoration: none; border-radius: 12px; font-weight: 600; transition: all 0.3s ease;">
                                <i class="fas fa-arrow-left"></i> Back to ${domain.name} Services
                            </a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 3rem; color: #666;">
                        <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"></i>
                        <h3>Service not found</h3>
                        <p>The requested service could not be found.</p>
                        <a href="${pageContext.request.contextPath}/services" 
                           style="background: var(--gradient-primary); color: white; padding: 1rem 2rem; text-decoration: none; border-radius: 8px; font-weight: 600; margin-top: 1rem; display: inline-block;">
                            <i class="fas fa-arrow-left"></i> Back to Services
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script>
        function requestService(domainName) {
            // Check if user is logged in
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    // Redirect to service request form with domain pre-selected
                    window.location.href = '${pageContext.request.contextPath}/request-service?domain=' + encodeURIComponent(domainName);
                </c:when>
                <c:otherwise>
                    // Redirect to login page
                    alert('Please login to request services');
                    window.location.href = '${pageContext.request.contextPath}/login.jsp';
                </c:otherwise>
            </c:choose>
        }
    </script>
    
    <style>
        .service-detail button:hover {
            transform: translateY(-3px);
            box-shadow: var(--shadow-heavy);
        }
        
        .service-detail a:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }
    </style>
</body>
</html>