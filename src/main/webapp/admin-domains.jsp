<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Domains - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
    <jsp:include page="WEB-INF/navigation.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Manage Service Domains</h2>
            </div>
        </section>

        <section class="services-preview">
            <div class="auth-form" style="max-width: 600px;">
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
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>