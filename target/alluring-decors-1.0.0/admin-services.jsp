<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Services - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontawesome-fix.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />
    
    <div class="auth-container">
        <div class="auth-form" style="max-width: 800px;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2><i class="fas fa-cogs"></i> Manage Services</h2>
                <a href="${pageContext.request.contextPath}/admin/add-service" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Service
                </a>
            </div>
            
            <c:choose>
                <c:when test="${not empty services}">
                    <div class="services-table">
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background: var(--bg); border-bottom: 2px solid var(--border);">
                                    <th style="padding: 1rem; text-align: left; color: var(--primary);">ID</th>
                                    <th style="padding: 1rem; text-align: left; color: var(--primary);">Domain</th>
                                    <th style="padding: 1rem; text-align: left; color: var(--primary);">Name</th>
                                    <th style="padding: 1rem; text-align: left; color: var(--primary);">Description</th>
                                    <th style="padding: 1rem; text-align: left; color: var(--primary);">Price/Sqft</th>
                                    <th style="padding: 1rem; text-align: left; color: var(--primary);">Status</th>
                                    <th style="padding: 1rem; text-align: center; color: var(--primary);">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="service" items="${services}">
                                    <tr style="border-bottom: 1px solid var(--border);">
                                        <td style="padding: 1rem;">${service.serviceId}</td>
                                        <td style="padding: 1rem;">${service.domainName != null ? service.domainName : 'N/A'}</td>
                                        <td style="padding: 1rem; font-weight: 600;">${service.name}</td>
                                        <td style="padding: 1rem; max-width: 200px; overflow: hidden; text-overflow: ellipsis;">
                                            ${service.description != null ? service.description : 'No description'}
                                        </td>
                                        <td style="padding: 1rem; color: var(--accent); font-weight: 600;">
                                            KES ${service.pricePerSqft}
                                        </td>
                                        <td style="padding: 1rem;">
                                            <span style="padding: 0.3rem 0.8rem; border-radius: 15px; font-size: 0.8rem; font-weight: 600;
                                                     background: ${service.active ? '#d4edda' : '#f8d7da'};
                                                     color: ${service.active ? '#155724' : '#721c24'};">
                                                ${service.active ? 'Active' : 'Inactive'}
                                            </span>
                                        </td>
                                        <td style="padding: 1rem; text-align: center;">
                                            <a href="${pageContext.request.contextPath}/admin/add-service?id=${service.serviceId}" 
                                               style="color: var(--primary); margin-right: 1rem; text-decoration: none;" 
                                               title="Edit Service">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="#" onclick="deleteService(${service.serviceId})" 
                                               style="color: #dc3545; text-decoration: none;" 
                                               title="Delete Service">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 3rem; color: #666;">
                        <i class="fas fa-cogs" style="font-size: 3rem; color: var(--accent); margin-bottom: 1rem;"></i>
                        <h3>No services available. Add some services to get started.</h3>
                        <a href="${pageContext.request.contextPath}/admin/add-service" class="btn btn-primary" style="margin-top: 1rem;">
                            <i class="fas fa-plus"></i> Add First Service
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script>
        function deleteService(serviceId) {
            if (confirm('Are you sure you want to delete this service?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/delete-service?id=' + serviceId;
            }
        }
    </script>
    
    <style>
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        
        .btn-primary {
            background: var(--gradient-primary);
            color: white;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }
        
        table th, table td {
            border: none !important;
        }
        
        table tr:hover {
            background: var(--bg);
        }
    </style>
</body>
</html>