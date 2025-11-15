<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard - Alluring Decors</title>
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <h1><a href="../index.jsp">Alluring Decors</a></h1>
        </div>
        <ul class="nav-menu">
            <li><a href="dashboard" class="active">Dashboard</a></li>
            <li><a href="../services.jsp">Services</a></li>
            <li><a href="../projects.jsp">Projects</a></li>
            <li><a href="../logout">Logout</a></li>
        </ul>
    </nav>

    <div class="dashboard-container">
        <div class="dashboard-header">
            <h1>Welcome, ${sessionScope.user.fullName}</h1>
            <p>Manage your interior design projects and requests</p>
        </div>

        <div class="dashboard-stats">
            <div class="stat-card pending">
                <div class="stat-icon">⏳</div>
                <div class="stat-info">
                    <h3>${pendingCount != null ? pendingCount : 0}</h3>
                    <p>Pending Requests</p>
                </div>
            </div>
            <div class="stat-card ongoing">
                <div class="stat-icon">🔄</div>
                <div class="stat-info">
                    <h3>${ongoingCount != null ? ongoingCount : 0}</h3>
                    <p>Ongoing Projects</p>
                </div>
            </div>
            <div class="stat-card completed">
                <div class="stat-icon">✅</div>
                <div class="stat-info">
                    <h3>${completedCount != null ? completedCount : 0}</h3>
                    <p>Completed Projects</p>
                </div>
            </div>
        </div>

        <div class="dashboard-content">
            <div class="requests-section">
                <h2>My Service Requests</h2>
                <div class="request-filters">
                    <button class="filter-btn active" data-status="all">All</button>
                    <button class="filter-btn" data-status="pending">Pending</button>
                    <button class="filter-btn" data-status="ongoing">Ongoing</button>
                    <button class="filter-btn" data-status="completed">Completed</button>
                </div>
                
                <div class="requests-grid">
                    <c:forEach var="request" items="${userRequests}">
                        <div class="request-card" data-status="${request.statusName.toLowerCase()}">
                            <div class="request-header">
                                <h4>Request #${request.requestCode}</h4>
                                <span class="status-badge ${request.statusName.toLowerCase()}">${request.statusName}</span>
                            </div>
                            <div class="request-details">
                                <p><strong>Service:</strong> ${request.location}</p>
                                <p><strong>Area:</strong> ${request.areaSqft} sq ft</p>
                                <p><strong>Requested:</strong> ${request.requestedAt}</p>
                                <c:if test="${not empty request.remarks}">
                                    <p><strong>Notes:</strong> ${request.remarks}</p>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty userRequests}">
                        <div class="empty-state">
                            <div class="empty-icon">📋</div>
                            <h3>No Service Requests Yet</h3>
                            <p>Start by requesting a service for your interior design needs</p>
                            <a href="../request-service" class="btn btn-primary">Request Service</a>
                        </div>
                    </c:if>
                </div>
            </div>

            <div class="quick-actions">
                <h2>Quick Actions</h2>
                <div class="actions-grid">
                    <a href="../request-service" class="action-card">
                        <div class="action-icon">🏠</div>
                        <h4>New Request</h4>
                        <p>Submit a new service request</p>
                    </a>
                    <a href="../contact.jsp" class="action-card">
                        <div class="action-icon">💬</div>
                        <h4>Contact Support</h4>
                        <p>Get help with your projects</p>
                    </a>
                    <a href="../projects.jsp" class="action-card">
                        <div class="action-icon">🎨</div>
                        <h4>Browse Gallery</h4>
                        <p>View our completed projects</p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
                
                const status = btn.dataset.status;
                document.querySelectorAll('.request-card').forEach(card => {
                    if (status === 'all' || card.dataset.status === status) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
    </script>
</body>
</html>