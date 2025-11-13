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
    <link rel="stylesheet" href="css/icons-final.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Our Services</h2>
                <p>Comprehensive interior and exterior design solutions tailored to your unique vision and lifestyle.</p>
            </div>
        </section>

        <section class="services-domains" style="padding: 4rem 2rem;">
            <div class="container">
                <h3 style="text-align: center; color: #164e31; margin-bottom: 3rem; font-size: 2rem;">Our Service Domains</h3>
                
                <c:forEach var="domain" items="${domains}">
                    <div class="domain-section" style="margin-bottom: 4rem; background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        <h4 style="color: #164e31; margin-bottom: 1.5rem; font-size: 1.5rem;">${domain.name}</h4>
                        <p style="color: #666; margin-bottom: 1rem;">${domain.description}</p>
                        
                        <c:if test="${not empty services}">
                            <div class="services-list" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1rem; margin-bottom: 2rem;">
                                <c:forEach var="service" items="${services}">
                                    <c:if test="${service.domainId == domain.domainId}">
                                        <div class="service-item" style="padding: 0.5rem; background: #f8f9fa; border-radius: 6px;">
                                            <strong>${service.name}</strong>
                                            <c:if test="${service.description != null}">
                                                <br><small style="color: #666;">${service.description}</small>
                                            </c:if>
                                            <c:if test="${service.pricePerSqft != null}">
                                                <br><small style="color: #D4A017; font-weight: 600;">From $${service.pricePerSqft}/sqft</small>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                        
                        <button class="request-btn" onclick="requestService('${domain.name}')" style="background: #D4A017; color: #164e31; padding: 12px 24px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;">Request Service Now</button>
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
            function requestService(domain) {
                // Check if user is logged in
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        // Redirect to service request form with domain pre-selected
                        window.location.href = '${pageContext.request.contextPath}/request-service?domain=' + encodeURIComponent(domain);
                    </c:when>
                    <c:otherwise>
                        // Redirect to login page
                        alert('Please login to request services');
                        window.location.href = '${pageContext.request.contextPath}/login.jsp';
                    </c:otherwise>
                </c:choose>
            }
        </script>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>