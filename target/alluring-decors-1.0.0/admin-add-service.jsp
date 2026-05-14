<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add/Edit Service - Alluring Decors Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />

    <div class="auth-container">
        <form class="auth-form" method="post" style="max-width: 600px;">
            <h2><i class="fas fa-cogs"></i> ${service != null ? 'Edit' : 'Add'} Service</h2>
            
            <c:if test="${not empty error}">
                <div class="error-message" style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="success-message" style="background: #d4edda; color: #155724; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                    ${success}
                </div>
            </c:if>

            <div class="form-group">
                <label for="domainId"><i class="fas fa-layer-group"></i> Service Domain</label>
                <select id="domainId" name="domainId" required>
                    <option value="">Select Domain</option>
                    <c:forEach var="domain" items="${domains}">
                        <option value="${domain.domainId}" ${service != null && service.domainId == domain.domainId ? 'selected' : ''}>
                            ${domain.name}
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="name"><i class="fas fa-tag"></i> Service Name</label>
                <input type="text" id="name" name="name" value="${service != null ? service.name : ''}" 
                       placeholder="e.g., Kitchen Design, Office Partitioning" required>
            </div>

            <div class="form-group">
                <label for="description"><i class="fas fa-align-left"></i> Description</label>
                <textarea id="description" name="description" rows="4" 
                          placeholder="Detailed description of the service...">${service != null ? service.description : ''}</textarea>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div class="form-group">
                    <label for="basePrice"><i class="fas fa-money-bill"></i> Base Price (KES)</label>
                    <input type="number" id="basePrice" name="basePrice" step="0.01" min="0"
                           value="${service != null ? service.basePrice : ''}" 
                           placeholder="Fixed base price">
                </div>

                <div class="form-group">
                    <label for="pricePerSqft"><i class="fas fa-calculator"></i> Price per Sq Ft (KES)</label>
                    <input type="number" id="pricePerSqft" name="pricePerSqft" step="0.01" min="0"
                           value="${service != null ? service.pricePerSqft : ''}" 
                           placeholder="Price per square foot" required>
                </div>
            </div>

            <div class="form-group">
                <label for="unit"><i class="fas fa-ruler"></i> Unit of Measurement</label>
                <select id="unit" name="unit">
                    <option value="sqft" ${service == null || service.unit == 'sqft' ? 'selected' : ''}>Square Feet (sqft)</option>
                    <option value="sqm" ${service != null && service.unit == 'sqm' ? 'selected' : ''}>Square Meters (sqm)</option>
                    <option value="piece" ${service != null && service.unit == 'piece' ? 'selected' : ''}>Per Piece</option>
                    <option value="room" ${service != null && service.unit == 'room' ? 'selected' : ''}>Per Room</option>
                    <option value="project" ${service != null && service.unit == 'project' ? 'selected' : ''}>Per Project</option>
                </select>
            </div>



            <div class="form-group">
                <label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
                    <input type="checkbox" name="isActive" value="true" 
                           ${service == null || service.active ? 'checked' : ''}>
                    <i class="fas fa-toggle-on"></i> Service is Active
                </label>
                <small style="color: #666; font-size: 0.9rem;">Inactive services won't be visible to clients</small>
            </div>

            <div style="display: flex; gap: 1rem; justify-content: space-between;">
                <a href="${pageContext.request.contextPath}/admin/services" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Services
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> ${service != null ? 'Update' : 'Create'} Service
                </button>
            </div>

            <c:if test="${service != null}">
                <input type="hidden" name="serviceId" value="${service.serviceId}">
            </c:if>
        </form>
    </div>

    <style>
        .form-group select, .form-group input[type="file"] {
            width: 100%;
            padding: 1.2rem 1.5rem;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: var(--white);
            color: var(--text);
        }
        
        .form-group select:focus, .form-group input[type="file"]:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(212, 160, 23, 0.1);
        }
        
        .form-group label i {
            color: var(--accent);
            margin-right: 0.5rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem 2rem;
            border-radius: 12px;
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
        
        .btn-secondary {
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--primary);
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }
    </style>
</body>
</html>