<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Alluring Decors</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
    <style>
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.5); }
        .modal-content { background-color: #fff; margin: 5% auto; padding: 20px; border-radius: 8px; width: 90%; max-width: 600px; position: relative; }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; }
        .close:hover { color: #000; }
        .modal h3 { margin-top: 0; }
    </style>
</head>
<body>
    <jsp:include page="WEB-INF/navigation.jsp" />

    <div class="admin-layout">
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <h3 class="sidebar-title">Admin Panel</h3>
                <button class="sidebar-toggle" onclick="toggleSidebar()">☰</button>
            </div>
            <nav class="sidebar-menu">
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('users')">
                    <span class="sidebar-item-icon"><i class="fas fa-users"></i></span>
                    <span class="sidebar-item-text">Manage Users</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('projects')">
                    <span class="sidebar-item-icon"><i class="fas fa-project-diagram"></i></span>
                    <span class="sidebar-item-text">Manage Projects</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('domains')">
                    <span class="sidebar-item-icon"><i class="fas fa-tags"></i></span>
                    <span class="sidebar-item-text">Manage Domains</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('services')">
                    <span class="sidebar-item-icon"><i class="fas fa-cogs"></i></span>
                    <span class="sidebar-item-text">Manage Services</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('content')">
                    <span class="sidebar-item-icon"><i class="fas fa-edit"></i></span>
                    <span class="sidebar-item-text">Edit Content</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('contacts')">
                    <span class="sidebar-item-icon"><i class="fas fa-phone"></i></span>
                    <span class="sidebar-item-text">Manage Contacts</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('feedback')">
                    <span class="sidebar-item-icon"><i class="fas fa-comments"></i></span>
                    <span class="sidebar-item-text">View Feedback</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('faqs')">
                    <span class="sidebar-item-icon"><i class="fas fa-question-circle"></i></span>
                    <span class="sidebar-item-text">Manage FAQs</span>
                </a>
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('requests')">
                    <span class="sidebar-item-icon"><i class="fas fa-envelope"></i></span>
                    <span class="sidebar-item-text">Service Requests</span>
                </a>
            </nav>
        </aside>
        
        <main class="main-content" id="mainContent">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Admin Dashboard</h1>
                <p class="dashboard-subtitle">Select an option from the menu to get started</p>
            </div>
            
            <div class="admin-grid">
                <div class="admin-card" onclick="loadContent('users')">
                    <h4><i class="fas fa-users"></i> Users</h4>
                    <p>View, edit, and delete registered users</p>
                </div>
                <div class="admin-card" onclick="loadContent('projects')">
                    <h4><i class="fas fa-project-diagram"></i> Projects</h4>
                    <p>Add, edit, and delete projects</p>
                </div>
                <div class="admin-card" onclick="loadContent('domains')">
                    <h4><i class="fas fa-tags"></i> Domains</h4>
                    <p>Configure service domains and categories</p>
                </div>
                <div class="admin-card" onclick="loadContent('services')">
                    <h4><i class="fas fa-cogs"></i> Services</h4>
                    <p>Configure services, pricing, and models</p>
                </div>
                <div class="admin-card" onclick="loadContent('content')">
                    <h4><i class="fas fa-edit"></i> Content</h4>
                    <p>Update home page content and about us section</p>
                </div>
                <div class="admin-card" onclick="loadContent('contacts')">
                    <h4><i class="fas fa-phone"></i> Contacts</h4>
                    <p>Update contact information and addresses</p>
                </div>
                <div class="admin-card" onclick="loadContent('feedback')">
                    <h4><i class="fas fa-comments"></i> Feedback</h4>
                    <p>Review customer feedback and queries</p>
                </div>
                <div class="admin-card" onclick="loadContent('faqs')">
                    <h4><i class="fas fa-question-circle"></i> FAQs</h4>
                    <p>Add, edit, and delete frequently asked questions</p>
                </div>
                <div class="admin-card" onclick="loadContent('requests')">
                    <h4><i class="fas fa-envelope"></i> Service Requests</h4>
                    <p>View and manage customer service requests</p>
                </div>
            </div>
        </main>
    </div>

    <!-- Modal for forms -->
    <div id="formModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="closeModal()">&times;</span>
            <div id="modalBody"></div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        }
        
        function loadContent(section) {
            const mainContent = document.getElementById('mainContent');
            
            // Update active menu item
            document.querySelectorAll('.sidebar-item').forEach(item => {
                item.classList.remove('active');
            });
            event.target.closest('.sidebar-item').classList.add('active');
            
            // Load content based on section
            fetch(section + '?ajax=true')
                .then(response => response.text())
                .then(html => {
                    mainContent.innerHTML = html;
                })
                .catch(error => {
                    mainContent.innerHTML = `
                        <div class="dashboard-header">
                            <h1 class="dashboard-title">Error</h1>
                            <p class="dashboard-subtitle">Failed to load content</p>
                        </div>
                    `;
                });
        }
        
        function openModal(title, formHtml) {
            document.getElementById('modalBody').innerHTML = '<h3>' + title + '</h3>' + formHtml;
            document.getElementById('formModal').style.display = 'block';
        }
        
        function closeModal() {
            document.getElementById('formModal').style.display = 'none';
        }
        
        window.onclick = function(event) {
            const modal = document.getElementById('formModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>