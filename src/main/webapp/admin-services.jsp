<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Services - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Manage Services</h1>
            </div>
            
            <div class="auth-form" style="max-width: 600px; margin-bottom: 3rem;">
                <h3>Add New Service</h3>
                <form method="post">
                    <div class="form-group">
                        <label>Service Name:</label>
                        <input type="text" name="name" required>
                    </div>
                    <div class="form-group">
                        <label>Description:</label>
                        <textarea name="description" rows="3" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Price:</label>
                        <input type="number" name="price" step="0.01" required>
                    </div>
                    <button type="submit" class="btn-primary">Add Service</button>
                </form>
            </div>

            <h3>Existing Services</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5">No services available</td>
                    </tr>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>