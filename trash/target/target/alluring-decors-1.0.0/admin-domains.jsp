<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Domains - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
      <div class="admin-layout">
       
        
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Manage Service Domains</h1>
            </div>
            
            <div class="auth-form" style="max-width: 600px; margin-bottom: 3rem;">
                <h3>Add New Domain</h3>
                <form method="post">
                    <div class="form-group">
                        <label>Domain Name:</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Description:</label>
                        <textarea name="description" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn-primary">Add Domain</button>
                </form>
            </div>

            <h3>Existing Domains</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="domain" items="${domains}">
                        <tr>
                            <td>${domain.domainId}</td>
                            <td>${domain.name}</td>
                            <td>${domain.description}</td>
                            <td>
                                <a href="domains?action=delete&id=${domain.domainId}" 
                                   onclick="return confirm('Delete this domain?')">Delete</a>
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