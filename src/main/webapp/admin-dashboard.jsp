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
        /* Modern Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(22, 78, 49, 0.8);
            backdrop-filter: blur(5px);
            animation: fadeIn 0.3s ease;
        }
        
        .modal-content {
            background: linear-gradient(135deg, #F8F5F0 0%, #ffffff 100%);
            margin: 3% auto;
            padding: 0;
            border-radius: 20px;
            width: 90%;
            max-width: 650px;
            position: relative;
            box-shadow: 0 25px 50px rgba(22, 78, 49, 0.3);
            animation: slideIn 0.4s ease;
            overflow: hidden;
            border: 3px solid #D4A017;
        }
        
        .modal-header {
            background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%);
            color: #D4A017;
            padding: 25px 30px;
            border-bottom: 3px solid #D4A017;
            position: relative;
        }
        
        .modal-header h3 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .close {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #D4A017;
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(212, 160, 23, 0.1);
        }
        
        .close:hover {
            background: #D4A017;
            color: #164e31;
            transform: translateY(-50%) rotate(90deg);
        }
        
        .modal-body {
            padding: 30px;
        }
        
        .modal .form-group {
            margin-bottom: 25px;
        }
        
        .modal .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #164e31;
            font-size: 1.1rem;
        }
        
        .modal input, .modal textarea, .modal select {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #ffffff;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .modal input:focus, .modal textarea:focus, .modal select:focus {
            outline: none;
            border-color: #D4A017;
            box-shadow: 0 0 0 3px rgba(212, 160, 23, 0.2);
            transform: translateY(-2px);
        }
        
        .modal input[readonly] {
            background: #f8f9fa;
            color: #6c757d;
        }
        
        .modal .btn-primary {
            background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%);
            border: none;
            color: #164e31;
            padding: 15px 30px;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(212, 160, 23, 0.3);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .modal .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(212, 160, 23, 0.4);
        }
        
        /* Action Buttons */
        .action-btn {
            background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%);
            border: none;
            color: #164e31;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 8px;
            box-shadow: 0 4px 12px rgba(212, 160, 23, 0.3);
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(212, 160, 23, 0.4);
        }
        
        .action-btn.view {
            background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%);
            color: #D4A017;
        }
        
        .action-btn.delete {
            background: linear-gradient(135deg, #dc3545 0%, #e74c3c 100%);
            color: white;
        }
        
        /* Loading Spinner */
        .loading {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #164e31;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin-right: 10px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .btn-loading {
            opacity: 0.7;
            pointer-events: none;
        }
        
        /* Success Message */
        .success-message {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: none;
            animation: slideDown 0.3s ease;
        }
        
        @keyframes slideDown {
            from { transform: translateY(-20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        /* Enhanced Tables */
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .admin-table th {
            background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%);
            color: #D4A017;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }
        
        .admin-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.3s ease;
        }
        
        .admin-table tr:hover {
            background: rgba(212, 160, 23, 0.05);
        }
        
        /* Header Action Button */
        .header-action-btn {
            background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%);
            border: none;
            color: #164e31;
            padding: 12px 24px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(212, 160, 23, 0.3);
            margin-left: 20px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .header-action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 25px rgba(212, 160, 23, 0.4);
        }
        
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 20px 0;
            border-bottom: 2px solid #f0f0f0;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideIn {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
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

    <!-- Enhanced Modal for forms -->
    <div id="formModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Form</h3>
                <span class="close" onclick="closeModal()">&times;</span>
            </div>
            <div class="modal-body" id="modalBody"></div>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        }
        
        function loadContent(section) {
            const mainContent = document.getElementById('mainContent');
            
            // Save current section to localStorage
            localStorage.setItem('adminCurrentSection', section);
            
            // Update active menu item
            document.querySelectorAll('.sidebar-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Find and activate the correct menu item
            if (event && event.target) {
                event.target.closest('.sidebar-item').classList.add('active');
            } else {
                // For programmatic calls, find the menu item by section name
                const menuItems = document.querySelectorAll('.sidebar-item');
                menuItems.forEach(item => {
                    const onclick = item.getAttribute('onclick');
                    if (onclick && onclick.includes("'" + section + "'")) {
                        item.classList.add('active');
                    }
                });
            }
            
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
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('modalBody').innerHTML = formHtml;
            document.getElementById('formModal').style.display = 'block';
            document.body.style.overflow = 'hidden';
            
            // Add form submission handler
            const form = document.querySelector('#modalBody form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    e.preventDefault();
                    submitModalForm(this);
                });
            }
        }
        
        function closeModal() {
            document.getElementById('formModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }
        
        function submitModalForm(form) {
            const submitBtn = form.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            
            // Show loading state
            submitBtn.innerHTML = '<span class="loading"></span>Saving...';
            submitBtn.classList.add('btn-loading');
            
            const formData = new FormData(form);
            const action = form.getAttribute('action');
            
            fetch(action, {
                method: 'POST',
                body: formData
            })
            .then(response => {
                if (response.ok) {
                    closeModal();
                    showSuccessMessage('Operation completed successfully!');
                    // Refresh the current section
                    const currentSection = localStorage.getItem('adminCurrentSection');
                    if (currentSection) {
                        loadContent(currentSection);
                    }
                } else {
                    throw new Error('Server error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error submitting form. Please try again.');
            })
            .finally(() => {
                // Reset button state
                submitBtn.innerHTML = originalText;
                submitBtn.classList.remove('btn-loading');
            });
        }
        
        function showSuccessMessage(message) {
            // Remove existing success message
            const existingMsg = document.querySelector('.success-message');
            if (existingMsg) {
                existingMsg.remove();
            }
            
            // Create and show new success message
            const successDiv = document.createElement('div');
            successDiv.className = 'success-message';
            successDiv.innerHTML = '<i class="fas fa-check-circle"></i> ' + message;
            
            const mainContent = document.getElementById('mainContent');
            mainContent.insertBefore(successDiv, mainContent.firstChild);
            
            // Show the message
            setTimeout(() => {
                successDiv.style.display = 'block';
            }, 100);
            
            // Hide after 3 seconds
            setTimeout(() => {
                successDiv.style.display = 'none';
                setTimeout(() => successDiv.remove(), 300);
            }, 3000);
        }
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('formModal');
            if (event.target == modal) {
                closeModal();
            }
        }
        
        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeModal();
            }
        });
        
        // Prevent modal from closing when clicking inside modal content
        document.addEventListener('DOMContentLoaded', function() {
            const modalContent = document.querySelector('.modal-content');
            if (modalContent) {
                modalContent.addEventListener('click', function(event) {
                    event.stopPropagation();
                });
            }
            
            // Restore last viewed section on page load
            const savedSection = localStorage.getItem('adminCurrentSection');
            if (savedSection) {
                loadContent(savedSection);
            }
        });
    </script>
</body>
</html>