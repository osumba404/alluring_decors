<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Feedback - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">View Feedback</h1>
            </div>
            
            <h3>Customer Feedback</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Subject</th>
                        <th>Message</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>John Doe</td>
                        <td>john@example.com</td>
                        <td>Great Service</td>
                        <td>Excellent work on our office renovation...</td>
                        <td>2024-01-15</td>
                        <td>
                            <a href="feedback?action=delete&id=1" onclick="return confirm('Delete this feedback?')">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="7">No additional feedback available</td>
                    </tr>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>