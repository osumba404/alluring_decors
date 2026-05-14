<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Form</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="auth-container">
        <div class="auth-form">
            <h2>Add Project - Test</h2>
            <form method="post" action="admin/projects">
                <div class="form-group">
                    <label>Title:</label>
                    <input type="text" name="title" required>
                </div>
                <div class="form-group">
                    <label>Short Description:</label>
                    <textarea name="shortDescription" rows="3" required></textarea>
                </div>
                <div class="form-group">
                    <label>Category:</label>
                    <select name="category" required>
                        <option value="ongoing">Ongoing</option>
                        <option value="accomplished">Accomplished</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Client Name:</label>
                    <input type="text" name="clientName" required>
                </div>
                <div class="form-group">
                    <label>Location:</label>
                    <input type="text" name="location" required>
                </div>
                <button type="submit" class="btn-primary">Add Project</button>
            </form>
        </div>
    </div>
</body>
</html>