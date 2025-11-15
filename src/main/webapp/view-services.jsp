<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${domainName} Services - Alluring Decors</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />

    <main style="padding: 2rem 5%; background: var(--bg); min-height: 80vh;">
        <div class="container" style="max-width: 1200px; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: var(--primary); margin-bottom: 1rem;">${domainName} Services</h2>
                <p style="color: #666; font-size: 1.1rem;">${domain.description}</p>
            </div>
            
            <div class="search-container" style="text-align: center; margin-bottom: 3rem;">
                <input type="text" id="serviceSearch" placeholder="Search services..." 
                       style="padding: 1rem 1.5rem; width: 100%; max-width: 400px; border: 2px solid var(--border); border-radius: 25px; font-size: 1rem; outline: none;"
                       onkeyup="searchServices()">
            </div>
            
            <c:choose>
                <c:when test="${not empty services}">
                    <div class="services-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem;">
                        <c:forEach var="service" items="${services}">
                            <div class="service-card" style="background: white; padding: 2rem; border-radius: 15px; box-shadow: var(--shadow-light); border: 1px solid var(--border); transition: all 0.3s ease;">
                                <h4 style="color: var(--primary); margin-bottom: 1rem; font-size: 1.3rem;">${service.name}</h4>
                                <p style="color: #666; margin-bottom: 1.5rem; line-height: 1.6;">${service.description}</p>
                                
                                <div style="margin-bottom: 1.5rem;">
                                    <c:if test="${service.basePrice != null}">
                                        <p style="color: var(--accent); font-weight: 600; margin-bottom: 0.5rem;">
                                            <i class="fas fa-tag"></i> Base Price: KES ${service.basePrice}
                                        </p>
                                    </c:if>
                                    <p style="color: var(--accent); font-weight: 600;">
                                        <i class="fas fa-calculator"></i> KES ${service.pricePerSqft}/${service.unit}
                                    </p>
                                </div>
                                
                                <button onclick="viewService(${service.serviceId})" 
                                        style="background: var(--gradient-primary); color: white; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; width: 100%; transition: all 0.3s ease;">
                                    <i class="fas fa-eye"></i> View Service
                                </button>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 3rem; color: #666;">
                        <i class="fas fa-search" style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"></i>
                        <h3>No services available in this domain yet.</h3>
                        <p>Please check back later or contact us for custom solutions.</p>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <div style="text-align: center; margin-top: 3rem;">
                <a href="${pageContext.request.contextPath}/services" 
                   style="background: transparent; border: 2px solid var(--primary); color: var(--primary); padding: 1rem 2rem; text-decoration: none; border-radius: 8px; font-weight: 600; transition: all 0.3s ease;">
                    <i class="fas fa-arrow-left"></i> Back to All Domains
                </a>
            </div>
        </div>
    </main>

    <script>
        function viewService(serviceId) {
            window.location.href = '${pageContext.request.contextPath}/services/view-service?serviceId=' + serviceId;
        }
        
        function searchServices() {
            const searchTerm = document.getElementById('serviceSearch').value.toLowerCase();
            const serviceCards = document.querySelectorAll('.service-card');
            
            serviceCards.forEach(card => {
                const serviceName = card.querySelector('h4').textContent.toLowerCase();
                const serviceDesc = card.querySelector('p').textContent.toLowerCase();
                
                if (serviceName.includes(searchTerm) || serviceDesc.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
    
    <style>
        .service-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-medium);
            border-color: var(--accent);
        }
        
        .service-card button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }
        
        #serviceSearch:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(212, 160, 23, 0.1);
        }
    </style>
</body>
</html>