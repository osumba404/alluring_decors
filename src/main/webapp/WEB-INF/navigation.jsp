<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar">
        <div class="nav-brand">
            <h1><a href="home">Alluring <span style="color: var(--accent);">Decors</span></a></h1>
        </div>
        <ul class="nav-menu">
            <li><a href="home">Home</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="projects.jsp">Projects</a></li>
            <li><a href="services.jsp">Services</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="admin/dashboard">Admin Dashboard</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'client'}">
                        <li><a href="client/dashboard">Dashboard</a></li>
                    </c:if>
                    <li><a href="logout">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="login">Login</a></li>
                    <li><a href="register">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
</header>