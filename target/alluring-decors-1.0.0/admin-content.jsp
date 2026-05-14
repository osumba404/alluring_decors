<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Content - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Edit Content</h1>
            </div>
            
            <div class="auth-form" style="max-width: 800px; margin-bottom: 3rem;">
                <h3>Home Page Content</h3>
                <form method="post">
                    <div class="form-group">
                        <label>Hero Title:</label>
                        <input type="text" name="heroTitle" value="Elegance Redefined" required>
                    </div>
                    <div class="form-group">
                        <label>Hero Description:</label>
                        <textarea name="heroDescription" rows="4" required>Transforming ordinary spaces into extraordinary experiences with bespoke interior and exterior designs.</textarea>
                    </div>
                    <div class="form-group">
                        <label>About Us Content:</label>
                        <textarea name="aboutContent" rows="6" required>Alluring Decors is a premier interior and exterior design firm with a passion for creating stunning, functional, and timeless spaces.</textarea>
                    </div>
                    <button type="submit" class="btn-primary">Update Content</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>