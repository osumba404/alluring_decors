<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Service Requests - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Service Requests</h1>
            </div>
            
            <h3>Pending Requests</h3>
            <table style="margin-bottom: 3rem;">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Client Name</th>
                        <th>Service Type</th>
                        <th>Location</th>
                        <th>Budget</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Jane Smith</td>
                        <td>Home Decoration</td>
                        <td>Nairobi</td>
                        <td>$5,000</td>
                        <td>Pending</td>
                        <td>2024-01-20</td>
                        <td>
                            <a href="requests?action=approve&id=1">Approve</a> | 
                            <a href="requests?action=reject&id=1" onclick="return confirm('Reject this request?')">Reject</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">No additional requests available</td>
                    </tr>
                </tbody>
            </table>

            <h3>Completed Requests</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Client Name</th>
                        <th>Service Type</th>
                        <th>Status</th>
                        <th>Completion Date</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5">No completed requests available</td>
                    </tr>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>