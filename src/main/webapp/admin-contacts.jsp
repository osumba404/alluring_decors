<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Contacts - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Manage Contacts</h1>
            </div>
            
            <div class="auth-form" style="max-width: 600px; margin-bottom: 3rem;">
                <h3>Update Contact Information</h3>
                <form method="post">
                    <div class="form-group">
                        <label>Phone Number:</label>
                        <input type="tel" name="phone" value="+123 987 654 321" required>
                    </div>
                    <div class="form-group">
                        <label>Email Address:</label>
                        <input type="email" name="email" value="info@alluringdecors.com" required>
                    </div>
                    <div class="form-group">
                        <label>Address:</label>
                        <textarea name="address" rows="3" required>123 Mfangano Street, Nairobi, Kenya</textarea>
                    </div>
                    <div class="form-group">
                        <label>Business Hours:</label>
                        <input type="text" name="hours" value="Mon-Fri: 9AM-6PM, Sat: 10AM-4PM" required>
                    </div>
                    <button type="submit" class="btn-primary">Update Contact Info</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>