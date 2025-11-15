<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Request Service - Alluring Decors</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <h1><a href="index.jsp">Alluring Decors</a></h1>
        </div>
        <ul class="nav-menu">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="services.jsp">Services</a></li>
            <li><a href="projects.jsp">Projects</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="login.jsp">Login</a></li>
        </ul>
    </nav>

    <div class="auth-container">
        <form class="auth-form" method="post">
            <h2>Request Service</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message"><%= request.getAttribute("error") %></div>
            <% } %>

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" name="phone" required>
            </div>

            <div class="form-group">
                <label for="domain">Service Domain</label>
                <input type="text" id="domain" name="domain" value="<%= request.getAttribute("selectedDomain") != null ? request.getAttribute("selectedDomain") : "" %>" readonly>
            </div>

            <div class="form-group">
                <label for="description">Project Description</label>
                <textarea id="description" name="description" rows="4" placeholder="Describe your project requirements..." required></textarea>
            </div>

            <button type="submit" class="btn btn-primary">Submit Request</button>
        </form>
    </div>
</body>
</html>