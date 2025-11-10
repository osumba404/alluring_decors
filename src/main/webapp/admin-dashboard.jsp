<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Alluring Decors</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/icons-svg.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar-override.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-sidebar.css">
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
    <jsp:include page="includes/navbar.jsp" />

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
                <a href="javascript:void(0)" class="sidebar-item" onclick="loadContent('heroes')">
                    <span class="sidebar-item-icon"><i class="fas fa-images"></i></span>
                    <span class="sidebar-item-text">Hero Carousel</span>
                </a>
            </nav>
        </aside>
        
        <main class="main-content" id="mainContent">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Admin Dashboard</h1>
                <p class="dashboard-subtitle">Select an option from the menu to get started</p>
            </div>
            
            <div class="admin-grid">
                <div class="admin-card" onclick="loadContent('users')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-users" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Users</h4>
                    </div>
                    <p>View, edit, and delete registered users</p>
                </div>
                <div class="admin-card" onclick="loadContent('projects')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-project-diagram" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Projects</h4>
                    </div>
                    <p>Add, edit, and delete projects</p>
                </div>

                <div class="admin-card" onclick="loadContent('domains')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-tags" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Domains</h4>
                    </div>
                    <p>Configure service domains and categories</p>
                </div>
                <div class="admin-card" onclick="loadContent('services')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-cogs" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Services</h4>
                    </div>
                    <p>Configure services, pricing, and models</p>
                </div>
                <div class="admin-card" onclick="loadContent('content')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-edit" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Content</h4>
                    </div>
                    <p>Update home page content and about us section</p>
                </div>
                <div class="admin-card" onclick="loadContent('contacts')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-phone" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Contacts</h4>
                    </div>
                    <p>Update contact information and addresses</p>
                </div>
                <div class="admin-card" onclick="loadContent('feedback')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-comments" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Feedback</h4>
                    </div>
                    <p>Review customer feedback and queries</p>
                </div>
                <div class="admin-card" onclick="loadContent('faqs')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-question-circle" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">FAQs</h4>
                    </div>
                    <p>Add, edit, and delete frequently asked questions</p>
                </div>
                <div class="admin-card" onclick="loadContent('requests')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-envelope" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Service Requests</h4>
                    </div>
                    <p>View and manage customer service requests</p>
                </div>
                <div class="admin-card" onclick="loadContent('heroes')" style="cursor: pointer;">
                    <div style="display: flex; align-items: center; margin-bottom: 1rem;">
                        <div style="width: 50px; height: 50px; background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 1rem;">
                            <i class="fas fa-images" style="color: #164e31; font-size: 1.5rem;"></i>
                        </div>
                        <h4 style="margin: 0; color: #164e31; font-size: 1.3rem;">Hero Carousel</h4>
                    </div>
                    <p>Manage home page hero slides and carousel</p>
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
        }
        
        function closeModal() {
            document.getElementById('formModal').style.display = 'none';
            document.body.style.overflow = 'auto';
        }
        
        function submitModalForm(form) {
            // For file uploads, use regular form submission
            if (form.enctype === 'multipart/form-data' || form.getAttribute('enctype') === 'multipart/form-data') {
                closeModal();
                form.submit();
                return;
            }
            
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
                    const currentSection = localStorage.getItem('adminCurrentSection');
                    if (currentSection) {
                        loadContent(currentSection);
                    }
                } else {
                    return response.text().then(text => {
                        throw new Error(`Server error (${response.status}): ${text}`);
                    });
                }
            })
            .catch(error => {
                alert('Error submitting form: ' + error.message);
            })
            .finally(() => {
                submitBtn.innerHTML = originalText;
                submitBtn.classList.remove('btn-loading');
            });
        }
        
        // Global functions for all admin forms
        function showAddProjectForm() {
            const formHtml = '<form method="post" action="/alluring-decors/admin/projects">' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" required></div>' +
                '<div class="form-group"><label>Short Description:</label><textarea name="shortDescription" rows="3" required></textarea></div>' +
                '<div class="form-group"><label>Full Description:</label><textarea name="fullDescription" rows="4"></textarea></div>' +
                '<div class="form-group"><label>Client Name:</label><input type="text" name="clientName" required></div>' +
                '<div class="form-group"><label>Location:</label><input type="text" name="location" required></div>' +
                '<div class="form-group"><label>Start Date:</label><input type="date" name="startDate" required></div>' +
                '<div class="form-group"><label>End Date:</label><input type="date" name="endDate"></div>' +
                '<div class="form-group"><label>Image URL:</label><input type="url" name="thumbnailUrl" placeholder="https://example.com/image.jpg"></div>' +
                '<button type="submit" class="btn-primary">Add Project</button></form>';
            openModal('Add New Project', formHtml);
        }
        
        function submitDirectForm(form) {
            form.submit();
            return false;
        }
        
        function showViewProjectForm(id, title, client, location, startDate, shortDesc, fullDesc) {
            const formHtml = '<div class="form-group"><label>Title:</label><input type="text" value="' + (title || '') + '" readonly></div>' +
                '<div class="form-group"><label>Client:</label><input type="text" value="' + (client || '') + '" readonly></div>' +
                '<div class="form-group"><label>Location:</label><input type="text" value="' + (location || '') + '" readonly></div>' +
                '<div class="form-group"><label>Start Date:</label><input type="text" value="' + (startDate || 'N/A') + '" readonly></div>' +
                '<div class="form-group"><label>Short Description:</label><textarea rows="3" readonly>' + (shortDesc || '') + '</textarea></div>' +
                (fullDesc ? '<div class="form-group"><label>Full Description:</label><textarea rows="4" readonly>' + fullDesc + '</textarea></div>' : '');
            openModal('Project Details', formHtml);
        }
        
        function showEditProjectForm(id, title, client, location, category, shortDesc, fullDesc, startDate, endDate, thumbnailUrl) {
            const formHtml = '<form method="post" action="/alluring-decors/admin/projects">' +
                '<input type="hidden" name="projectId" value="' + id + '">' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" value="' + title + '" required></div>' +
                '<div class="form-group"><label>Client Name:</label><input type="text" name="clientName" value="' + client + '" required></div>' +
                '<div class="form-group"><label>Location:</label><input type="text" name="location" value="' + location + '" required></div>' +
                '<div class="form-group"><label>Short Description:</label><textarea name="shortDescription" rows="3" required>' + shortDesc + '</textarea></div>' +
                '<div class="form-group"><label>Full Description:</label><textarea name="fullDescription" rows="4">' + (fullDesc || '') + '</textarea></div>' +
                '<div class="form-group"><label>Start Date:</label><input type="date" name="startDate" value="' + (startDate !== 'N/A' ? startDate : '') + '" required></div>' +
                '<div class="form-group"><label>End Date:</label><input type="date" name="endDate" value="' + (endDate || '') + '"></div>' +
                '<div class="form-group"><label>Image URL:</label><input type="url" name="thumbnailUrl" value="' + (thumbnailUrl || '') + '" placeholder="https://example.com/image.jpg"></div>' +
                '<button type="submit" class="btn-primary">Update Project</button></form>';
            openModal('Edit Project', formHtml);
        }
        
        // Simple functions that servlet calls with just ID
        function showViewProject(id) {
            // Fetch project details and show view modal
            fetch('projects?action=view&id=' + id + '&ajax=true')
                .then(response => response.json())
                .then(project => {
                    showViewProjectForm(project.projectId, project.title, project.clientName, project.location, 
                        project.startDate || 'N/A', project.shortDescription, project.fullDescription);
                })
                .catch(error => {
                    console.error('Error fetching project:', error);
                    alert('Error loading project details');
                });
        }
        
        function showEditProject(id) {
            // Fetch project details and show edit modal
            fetch('projects?action=view&id=' + id + '&ajax=true')
                .then(response => response.json())
                .then(project => {
                    showEditProjectForm(project.projectId, project.title, project.clientName, project.location, 
                        project.category, project.shortDescription, project.fullDescription, project.startDate);
                })
                .catch(error => {
                    console.error('Error fetching project:', error);
                    alert('Error loading project details');
                });
        }
        
        function showAddDomainForm() {
            openModal('Add New Domain', 
                '<form method="post" action="/alluring-decors/admin/domains">' +
                '<div class="form-group"><label>Domain Name:</label><input type="text" name="name" required></div>' +
                '<div class="form-group"><label>Description:</label><textarea name="description" rows="3" required></textarea></div>' +
                '<button type="submit" class="btn-primary">Add Domain</button></form>'
            );
        }
        
        function showAddServiceForm() {
            openModal('Add New Service', 
                '<form method="post" action="/alluring-decors/admin/services">' +
                '<div class="form-group"><label>Service Name:</label><input type="text" name="name" required></div>' +
                '<div class="form-group"><label>Description:</label><textarea name="description" rows="3" required></textarea></div>' +
                '<div class="form-group"><label>Price per Sqft:</label><input type="number" name="pricePerSqft" step="0.01" required></div>' +
                '<button type="submit" class="btn-primary">Add Service</button></form>'
            );
        }
        
        function showAddContentForm() {
            openModal('Add New Content', 
                '<form method="post" action="content">' +
                '<div class="form-group"><label>Section Key:</label><input type="text" name="sectionKey" required></div>' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" required></div>' +
                '<div class="form-group"><label>Content:</label><textarea name="content" rows="6" required></textarea></div>' +
                '<button type="submit" class="btn-primary">Add Content</button></form>'
            );
        }
        
        function showEditContactForm() {
            openModal('Update Contact Information', 
                '<form method="post" action="contacts">' +
                '<div class="form-group"><label>Phone Number:</label><input type="tel" name="phone" required></div>' +
                '<div class="form-group"><label>Email Address:</label><input type="email" name="email" required></div>' +
                '<div class="form-group"><label>Address:</label><textarea name="address" rows="3" required></textarea></div>' +
                '<button type="submit" class="btn-primary">Update Contact Info</button></form>'
            );
        }
        
        function showAddFaqForm() {
            openModal('Add New FAQ', 
                '<form method="post" action="faqs">' +
                '<div class="form-group"><label>Question:</label><input type="text" name="question" required></div>' +
                '<div class="form-group"><label>Answer:</label><textarea name="answer" rows="4" required></textarea></div>' +
                '<div class="form-group"><label>Display Order:</label><input type="number" name="displayOrder" value="0" required></div>' +
                '<button type="submit" class="btn-primary">Add FAQ</button></form>'
            );
        }
        
        function showEditServiceForm(id, name, description, price) {
            openModal('Edit Service', 
                '<form method="post" action="/alluring-decors/admin/services">' +
                '<input type="hidden" name="serviceId" value="' + id + '">' +
                '<div class="form-group"><label>Service Name:</label><input type="text" name="name" value="' + name + '" required></div>' +
                '<div class="form-group"><label>Description:</label><textarea name="description" rows="3" required>' + description + '</textarea></div>' +
                '<div class="form-group"><label>Price per Sqft:</label><input type="number" name="pricePerSqft" step="0.01" value="' + price + '" required></div>' +
                '<button type="submit" class="btn-primary">Update Service</button></form>'
            );
        }
        
        function showEditFaqForm(id, question, answer, order) {
            openModal('Edit FAQ', 
                '<form method="post" action="faqs">' +
                '<input type="hidden" name="faqId" value="' + id + '">' +
                '<div class="form-group"><label>Question:</label><input type="text" name="question" value="' + question + '" required></div>' +
                '<div class="form-group"><label>Answer:</label><textarea name="answer" rows="4" required>' + answer + '</textarea></div>' +
                '<div class="form-group"><label>Display Order:</label><input type="number" name="displayOrder" value="' + order + '" required></div>' +
                '<button type="submit" class="btn-primary">Update FAQ</button></form>'
            );
        }
        
        function showEditContentForm(key, title, content) {
            openModal('Edit Content - ' + title, 
                '<form method="post" action="content">' +
                '<input type="hidden" name="sectionKey" value="' + key + '">' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" value="' + title + '" required></div>' +
                '<div class="form-group"><label>Content:</label><textarea name="content" rows="8" required>' + content + '</textarea></div>' +
                '<button type="submit" class="btn-primary">Update Content</button></form>'
            );
        }
        
        function showUserDetails(id, username, fullName, email, phone, role) {
            openModal('User Details', 
                '<div class="form-group"><label>User ID:</label><input type="text" value="' + id + '" readonly></div>' +
                '<div class="form-group"><label>Username:</label><input type="text" value="' + username + '" readonly></div>' +
                '<div class="form-group"><label>Full Name:</label><input type="text" value="' + fullName + '" readonly></div>' +
                '<div class="form-group"><label>Email:</label><input type="email" value="' + email + '" readonly></div>' +
                '<div class="form-group"><label>Phone:</label><input type="text" value="' + phone + '" readonly></div>' +
                '<div class="form-group"><label>Role:</label><input type="text" value="' + role + '" readonly></div>'
            );
        }
        
        function showAddHeroForm() {
            openModal('Add Hero Slide', 
                '<form id="addHeroForm" method="post" action="/alluring-decors/admin/heroes" enctype="multipart/form-data">' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" required></div>' +
                '<div class="form-group"><label>Subtitle:</label><input type="text" name="subtitle"></div>' +
                '<div class="form-group"><label>Body Text:</label><textarea name="bodyText" rows="3" required></textarea></div>' +
                '<div class="form-group"><label>Upload Background Image:</label><input type="file" name="heroImage" accept="image/*"></div>' +
                '<div class="form-group"><label>Primary Button Text:</label><input type="text" name="primaryButton"></div>' +
                '<div class="form-group"><label>Primary Button Link:</label><input type="text" name="primaryButtonLink"></div>' +
                '<div class="form-group"><label>Secondary Button Text:</label><input type="text" name="secondaryButton"></div>' +
                '<div class="form-group"><label>Secondary Button Link:</label><input type="text" name="secondaryButtonLink"></div>' +
                '<div class="form-group"><label>Display Order:</label><input type="number" name="displayOrder" value="1" required></div>' +
                '<button type="button" onclick="submitHeroForm()" class="btn-primary">Add Hero Slide</button></form>'
            );
        }
        
        // Project management functions
        function showAddProjectForm() {
            openModal('Add New Project', 
                '<form id="addProjectForm" method="post" action="/alluring-decors/admin/projects" enctype="multipart/form-data">' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" required></div>' +
                '<div class="form-group"><label>Short Description:</label><textarea name="shortDescription" rows="3" required></textarea></div>' +
                '<div class="form-group"><label>Full Description:</label><textarea name="fullDescription" rows="4"></textarea></div>' +
                '<div class="form-group"><label>Category:</label><select name="category" required><option value="ongoing">Ongoing</option><option value="accomplished">Accomplished</option></select></div>' +
                '<div class="form-group"><label>Client Name:</label><input type="text" name="clientName" required></div>' +
                '<div class="form-group"><label>Location:</label><input type="text" name="location" required></div>' +
                '<div class="form-group"><label>Start Date:</label><input type="date" name="startDate"></div>' +
                '<div class="form-group"><label>Upload Image:</label><input type="file" name="projectImage" accept="image/*" required></div>' +
                '<button type="button" onclick="submitProjectForm()" class="btn-primary">Add Project</button></form>'
            );
        }
        
        function viewProject(id) {
            // Simple view - fetch project data and display
            fetch('/alluring-decors/admin/projects?action=view&id=' + id)
                .then(response => response.json())
                .then(project => {
                    openModal('Project Details', 
                        '<div class="form-group"><label>Title:</label><input type="text" value="' + project.title + '" readonly></div>' +
                        '<div class="form-group"><label>Client:</label><input type="text" value="' + project.clientName + '" readonly></div>' +
                        '<div class="form-group"><label>Location:</label><input type="text" value="' + project.location + '" readonly></div>' +
                        '<div class="form-group"><label>Category:</label><input type="text" value="' + project.category + '" readonly></div>' +
                        '<div class="form-group"><label>Short Description:</label><textarea rows="3" readonly>' + project.shortDescription + '</textarea></div>' +
                        (project.fullDescription ? '<div class="form-group"><label>Full Description:</label><textarea rows="4" readonly>' + project.fullDescription + '</textarea></div>' : '') +
                        (project.startDate ? '<div class="form-group"><label>Start Date:</label><input type="text" value="' + project.startDate + '" readonly></div>' : '')
                    );
                })
                .catch(error => alert('Error loading project details'));
        }
        
        function editProject(id) {
            // Simple edit - fetch project data and show edit form
            fetch('/alluring-decors/admin/projects?action=view&id=' + id)
                .then(response => response.json())
                .then(project => {
                    openModal('Edit Project', 
                        '<form method="post" action="/alluring-decors/admin/projects" enctype="multipart/form-data">' +
                        '<input type="hidden" name="projectId" value="' + project.projectId + '">' +
                        '<div class="form-group"><label>Title:</label><input type="text" name="title" value="' + project.title + '" required></div>' +
                        '<div class="form-group"><label>Short Description:</label><textarea name="shortDescription" rows="3" required>' + project.shortDescription + '</textarea></div>' +
                        '<div class="form-group"><label>Full Description:</label><textarea name="fullDescription" rows="4">' + (project.fullDescription || '') + '</textarea></div>' +
                        '<div class="form-group"><label>Category:</label><select name="category" required><option value="ongoing"' + (project.category === 'ongoing' ? ' selected' : '') + '>Ongoing</option><option value="accomplished"' + (project.category === 'accomplished' ? ' selected' : '') + '>Accomplished</option></select></div>' +
                        '<div class="form-group"><label>Client Name:</label><input type="text" name="clientName" value="' + project.clientName + '" required></div>' +
                        '<div class="form-group"><label>Location:</label><input type="text" name="location" value="' + project.location + '" required></div>' +
                        '<div class="form-group"><label>Start Date:</label><input type="date" name="startDate" value="' + (project.startDate || '') + '"></div>' +
                        (project.thumbnailUrl ? '<div class="form-group"><label>Current Image:</label><br><img src="' + project.thumbnailUrl + '" style="max-width: 200px; border-radius: 8px; margin-bottom: 10px;"></div>' : '') +
                        '<div class="form-group"><label>Upload New Image:</label><input type="file" name="projectImage" accept="image/*"></div>' +
                        '<button type="submit" class="btn-primary">Update Project</button></form>'
                    );
                })
                .catch(error => alert('Error loading project details'));
        }
        
        function showEditHeroForm(id, title, subtitle, bodyText, backgroundImage, primaryButton, primaryButtonLink, secondaryButton, secondaryButtonLink, displayOrder) {
            openModal('Edit Hero Slide', 
                '<form id="editHeroForm" method="post" action="/alluring-decors/admin/heroes" enctype="multipart/form-data">' +
                '<input type="hidden" name="heroId" value="' + id + '">' +
                '<div class="form-group"><label>Title:</label><input type="text" name="title" value="' + title + '" required></div>' +
                '<div class="form-group"><label>Subtitle:</label><input type="text" name="subtitle" value="' + subtitle + '"></div>' +
                '<div class="form-group"><label>Body Text:</label><textarea name="bodyText" rows="3" required>' + bodyText + '</textarea></div>' +
                (backgroundImage ? '<div class="form-group"><label>Current Image:</label><br><img src="' + backgroundImage + '" style="max-width: 200px; border-radius: 8px; margin-bottom: 10px;"></div>' : '') +
                '<div class="form-group"><label>Upload New Background Image:</label><input type="file" name="heroImage" accept="image/*"></div>' +
                '<div class="form-group"><label>Primary Button Text:</label><input type="text" name="primaryButton" value="' + primaryButton + '"></div>' +
                '<div class="form-group"><label>Primary Button Link:</label><input type="text" name="primaryButtonLink" value="' + primaryButtonLink + '"></div>' +
                '<div class="form-group"><label>Secondary Button Text:</label><input type="text" name="secondaryButton" value="' + secondaryButton + '"></div>' +
                '<div class="form-group"><label>Secondary Button Link:</label><input type="text" name="secondaryButtonLink" value="' + secondaryButtonLink + '"></div>' +
                '<div class="form-group"><label>Display Order:</label><input type="number" name="displayOrder" value="' + displayOrder + '" required></div>' +
                '<button type="button" onclick="submitHeroForm()" class="btn-primary">Update Hero Slide</button></form>'
            );
        }
        
        function showEditDomainForm(id, name, description) {
            openModal('Edit Domain', 
                '<form method="post" action="/alluring-decors/admin/domains">' +
                '<input type="hidden" name="domainId" value="' + id + '">' +
                '<div class="form-group"><label>Domain Name:</label><input type="text" name="name" value="' + name + '" required></div>' +
                '<div class="form-group"><label>Description:</label><textarea name="description" rows="3" required>' + description + '</textarea></div>' +
                '<button type="submit" class="btn-primary">Update Domain</button></form>'
            );
        }
        
        function submitProjectForm() {
            const form = document.getElementById('addProjectForm');
            if (form) {
                console.log('Form found:', form);
                console.log('Form enctype:', form.enctype);
                console.log('Form method:', form.method);
                console.log('Form action:', form.action);
                
                const fileInput = form.querySelector('input[type="file"]');
                if (fileInput && fileInput.files.length > 0) {
                    console.log('File selected:', fileInput.files[0].name);
                } else {
                    console.log('No file selected');
                }
                
                closeModal();
                form.submit();
            } else {
                console.log('Form not found!');
            }
        }
        
        function submitHeroForm() {
            const form = document.getElementById('addHeroForm') || document.getElementById('editHeroForm');
            if (form) {
                closeModal();
                form.submit();
            }
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
        
        // Handle form submissions
        document.addEventListener('submit', function(event) {
            const form = event.target;
            if (form.closest('.modal')) {
                event.preventDefault();
                submitModalForm(form);
            }
        });
        
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
        
        // Initialize on page load
        window.addEventListener('load', function() {
            // Prevent modal from closing when clicking inside modal content
            const modalContent = document.querySelector('.modal-content');
            if (modalContent) {
                modalContent.addEventListener('click', function(event) {
                    event.stopPropagation();
                });
            }
            
            // Restore last viewed section on page load
            const savedSection = localStorage.getItem('adminCurrentSection');
            console.log('Saved section:', savedSection); // Debug log
            if (savedSection) {
                setTimeout(() => {
                    loadContentProgrammatically(savedSection);
                }, 100);
            }
        });
        
        // Separate function for programmatic loading
        function loadContentProgrammatically(section) {
            const mainContent = document.getElementById('mainContent');
            
            // Update active menu item
            document.querySelectorAll('.sidebar-item').forEach(item => {
                item.classList.remove('active');
            });
            
            // Find and activate the correct menu item
            const menuItems = document.querySelectorAll('.sidebar-item');
            menuItems.forEach(item => {
                const onclick = item.getAttribute('onclick');
                if (onclick && onclick.includes("'" + section + "'")) {
                    item.classList.add('active');
                }
            });
            
            // Load content based on section
            fetch(section + '?ajax=true')
                .then(response => response.text())
                .then(html => {
                    mainContent.innerHTML = html;
                    console.log('Content loaded for section:', section); // Debug log
                })
                .catch(error => {
                    console.error('Error loading content:', error);
                    mainContent.innerHTML = `
                        <div class="dashboard-header">
                            <h1 class="dashboard-title">Error</h1>
                            <p class="dashboard-subtitle">Failed to load content</p>
                        </div>
                    `;
                });
        }
    </script>
</body>
</html>