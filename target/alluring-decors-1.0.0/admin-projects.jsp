<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Projects - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>


    <div class="admin-layout">        
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Manage Projects</h1>
            </div>
            
            <div class="auth-form" style="max-width: 600px; margin-bottom: 3rem;">
                <h3>Add New Project</h3>
                <form method="post">
                    <div class="form-group">
                        <label>Title:</label>
                        <input type="text" name="title" required>
                    </div>
                    <div class="form-group">
                        <label>Short Description:</label>
                        <textarea name="shortDescription" rows="2" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Full Description:</label>
                        <textarea name="fullDescription" rows="4" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Category:</label>
                        <select name="category" required>
                            <option value="ongoing">Ongoing</option>
                            <option value="upcoming">Upcoming</option>
                            <option value="accomplished">Accomplished</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Client Name:</label>
                        <input type="text" name="clientName">
                    </div>
                    <div class="form-group">
                        <label>Location:</label>
                        <input type="text" name="location">
                    </div>
                    <div class="form-group">
                        <label>Start Date:</label>
                        <input type="date" name="startDate">
                    </div>
                    <button type="submit" class="btn-primary">Add Project</button>
                </form>
            </div>

            <h3>Ongoing Projects</h3>
            <table style="margin-bottom: 3rem;">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Client</th>
                        <th>Location</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="project" items="${ongoingProjects}">
                        <tr>
                            <td>${project.title}</td>
                            <td>${project.clientName}</td>
                            <td>${project.location}</td>
                            <td>
                                <a href="projects?action=delete&id=${project.projectId}" 
                                   onclick="return confirm('Delete this project?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <h3>Accomplished Projects</h3>
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Client</th>
                        <th>Location</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="project" items="${accomplishedProjects}">
                        <tr>
                            <td>${project.title}</td>
                            <td>${project.clientName}</td>
                            <td>${project.location}</td>
                            <td>
                                <a href="projects?action=delete&id=${project.projectId}" 
                                   onclick="return confirm('Delete this project?')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </div>

    <script>
        function toggleSidebar() {
            document.getElementById('sidebar').classList.toggle('collapsed');
        }
    </script>
</body>
</html>