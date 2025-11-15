<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Dashboard - Alluring Decors</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
    <style>
        .btn {
            display: inline-block;
            padding: 1rem 2rem;
            background: var(--gradient-primary);
            color: white;
            text-decoration: none;
            border-radius: 12px;
            font-weight: 600;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-medium);
        }
        .btn-outline {
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
        }
    </style>
</head>
<body>
    <jsp:include page="/includes/navbar.jsp" />

    <!-- Profile Header -->
    <div class="profile-header">
        <div class="profile-container">
            <div class="profile-info">
                <div class="profile-avatar">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="profile-details">
                    <h1>${sessionScope.user.fullName}</h1>
                    <p><i class="fas fa-envelope"></i> ${sessionScope.user.email}</p>
                    <p><i class="fas fa-phone"></i> ${sessionScope.user.phone}</p>
                    <p><i class="fas fa-calendar"></i> Member since ${sessionScope.user.registrationDate != null ? sessionScope.user.registrationDate : 'Recently'}</p>
                </div>
            </div>
            <button class="btn btn-secondary" onclick="openEditProfile()">Edit Profile</button>
        </div>
    </div>

    <!-- Dashboard Content -->
    <div class="dashboard-container">
        <!-- Quick Stats -->
        <div class="stats-grid">
            <div class="stat-card active">
                <div class="stat-icon"><i class="fas fa-clock"></i></div>
                <div class="stat-content">
                    <h3>${pendingCount != null ? pendingCount : 0}</h3>
                    <p>Active Requests</p>
                </div>
            </div>
            <div class="stat-card completed">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-content">
                    <h3>${completedCount != null ? completedCount : 0}</h3>
                    <p>Completed Services</p>
                </div>
            </div>
            <div class="stat-card pending">
                <div class="stat-icon"><i class="fas fa-dollar-sign"></i></div>
                <div class="stat-content">
                    <h3>${pendingPayments != null ? pendingPayments : 0}</h3>
                    <p>Pending Payments</p>
                </div>
            </div>
            <div class="stat-card new">
                <a href="${pageContext.request.contextPath}/request-service" class="stat-link">
                    <div class="stat-icon"><i class="fas fa-plus"></i></div>
                    <div class="stat-content">
                        <h3>Request</h3>
                        <p>New Service</p>
                    </div>
                </a>
            </div>
        </div>

        <!-- Main Dashboard Grid -->
        <div class="dashboard-grid">
            <!-- Service Requests Panel -->
            <div class="panel requests-panel">
                <div class="panel-header">
                    <h2><i class="fas fa-list-alt"></i> Service Requests</h2>
                    <div class="panel-actions">
                        <select id="statusFilter" onchange="filterRequests()">
                            <option value="all">All Status</option>
                            <option value="pending">Pending</option>
                            <option value="accepted">Accepted</option>
                            <option value="ongoing">Ongoing</option>
                            <option value="completed">Completed</option>
                        </select>
                    </div>
                </div>
                <div class="requests-list">
                    <c:choose>
                        <c:when test="${not empty userRequests}">
                            <c:forEach var="request" items="${userRequests}">
                                <div class="request-card" data-status="${request.statusName.toLowerCase()}">
                                    <div class="request-header">
                                        <div class="request-id">#${request.requestCode}</div>
                                        <div class="request-status status-${request.statusName.toLowerCase()}">
                                            ${request.statusName}
                                        </div>
                                    </div>
                                    <div class="request-details">
                                        <p><strong>Service:</strong> ${request.location}</p>
                                        <p><strong>Area:</strong> ${request.areaSqft} sq ft</p>
                                        <p><strong>Requested:</strong> ${request.requestedAt}</p>
                                        <c:if test="${not empty request.remarks}">
                                            <p><strong>Admin Notes:</strong> ${request.remarks}</p>
                                        </c:if>
                                    </div>
                                    <div class="request-actions">
                                        <button class="btn-sm btn-outline" onclick="viewRequest(${request.requestId})">View Details</button>
                                        <c:if test="${request.statusName == 'Pending'}">
                                            <button class="btn-sm btn-warning" onclick="editRequest(${request.requestId})">Edit</button>
                                            <button class="btn-sm btn-danger" onclick="cancelRequest(${request.requestId})">Cancel</button>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="fas fa-clipboard-list"></i>
                                <h3>No Service Requests</h3>
                                <p>Start your interior design journey</p>
                                <a href="${pageContext.request.contextPath}/request-service" class="btn btn-primary">Request Service</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Billing Panel -->
                <div class="panel billing-panel">
                    <div class="panel-header">
                        <h3><i class="fas fa-receipt"></i> Billing & Payments</h3>
                    </div>
                    <div class="billing-summary">
                        <div class="billing-item">
                            <span>Total Billed:</span>
                            <strong>KES ${totalBilled != null ? totalBilled : '0.00'}</strong>
                        </div>
                        <div class="billing-item">
                            <span>Amount Paid:</span>
                            <strong class="text-success">KES ${totalPaid != null ? totalPaid : '0.00'}</strong>
                        </div>
                        <div class="billing-item">
                            <span>Balance Due:</span>
                            <strong class="text-danger">KES ${balanceDue != null ? balanceDue : '0.00'}</strong>
                        </div>
                    </div>
                    <button class="btn btn-outline btn-full" onclick="viewBilling()">View All Bills</button>
                </div>

                <!-- Quick Actions -->
                <div class="panel actions-panel">
                    <div class="panel-header">
                        <h3><i class="fas fa-bolt"></i> Quick Actions</h3>
                    </div>
                    <div class="actions-list">
                        <a href="${pageContext.request.contextPath}/request-service" class="action-item">
                            <i class="fas fa-plus-circle"></i>
                            <span>Request New Service</span>
                        </a>
                        <a href="#" onclick="viewProjects()" class="action-item">
                            <i class="fas fa-images"></i>
                            <span>View My Projects</span>
                        </a>
                        <a href="#" onclick="submitFeedback()" class="action-item">
                            <i class="fas fa-comment-alt"></i>
                            <span>Submit Feedback</span>
                        </a>
                        <a href="${pageContext.request.contextPath}/contact" class="action-item">
                            <i class="fas fa-headset"></i>
                            <span>Contact Support</span>
                        </a>
                        <a href="#" onclick="viewFAQs()" class="action-item">
                            <i class="fas fa-question-circle"></i>
                            <span>View FAQs</span>
                        </a>
                    </div>
                </div>

                <!-- Notifications -->
                <div class="panel notifications-panel">
                    <div class="panel-header">
                        <h3><i class="fas fa-bell"></i> Recent Updates</h3>
                    </div>
                    <div class="notifications-list">
                        <c:choose>
                            <c:when test="${not empty notifications}">
                                <c:forEach var="notification" items="${notifications}" end="3">
                                    <div class="notification-item">
                                        <div class="notification-icon">
                                            <i class="fas fa-info-circle"></i>
                                        </div>
                                        <div class="notification-content">
                                            <p>${notification.message}</p>
                                            <small>${notification.createdAt}</small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-notifications">
                                    <i class="fas fa-bell-slash"></i>
                                    <p>No new notifications</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
</body>
</html>