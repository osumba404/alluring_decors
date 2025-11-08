<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <nav class="navbar">
        <div class="nav-brand">
            <h1><a href="home">Alluring <span style="color: #D4A017;">Decors</span></a></h1>
        </div>
        <ul class="nav-menu">
            <li><a href="home">Home</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="projects">Projects</a></li>
            <li><a href="services">Services</a></li>
            <li><a href="contact">Contact</a></li>
            
            <c:choose>
                <c:when test="${sessionScope.user != null}">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'admin'}">
                            <li><a href="admin-dashboard.jsp">Admin Dashboard</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="client-dashboard.jsp">Dashboard</a></li>
                        </c:otherwise>
                    </c:choose>
                    <li><a href="logout">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="login.jsp">Login</a></li>
                    <li><a href="register.jsp">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </nav>
</header>