<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage FAQs - Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
            <div class="dashboard-header">
                <h1 class="dashboard-title">Manage FAQs</h1>
            </div>
            
            <div class="auth-form" style="max-width: 700px; margin-bottom: 3rem;">
                <h3>Add New FAQ</h3>
                <form method="post">
                    <div class="form-group">
                        <label>Question:</label>
                        <input type="text" name="question" required>
                    </div>
                    <div class="form-group">
                        <label>Answer:</label>
                        <textarea name="answer" rows="4" required></textarea>
                    </div>
                    <div class="form-group">
                        <label>Category:</label>
                        <select name="category" required>
                            <option value="general">General</option>
                            <option value="services">Services</option>
                            <option value="pricing">Pricing</option>
                            <option value="process">Process</option>
                        </select>
                    </div>
                    <button type="submit" class="btn-primary">Add FAQ</button>
                </form>
            </div>

            <h3>Existing FAQs</h3>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Question</th>
                        <th>Answer</th>
                        <th>Category</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>How long does a typical project take?</td>
                        <td>Project duration varies based on scope, typically 2-8 weeks...</td>
                        <td>General</td>
                        <td>
                            <a href="faqs?action=delete&id=1" onclick="return confirm('Delete this FAQ?')">Delete</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">No additional FAQs available</td>
                    </tr>
                </tbody>
            </table>
        </main>
    </div>
</body>
</html>