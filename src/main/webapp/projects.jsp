<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.alluringdecors.bean.ProjectBean" %>
<%@ page import="com.alluringdecors.model.Project" %>
<%@ page import="java.util.List" %>
<%
    ProjectBean projectBean = new ProjectBean();
    List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
    List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
    request.setAttribute("ongoingProjects", ongoingProjects);
    request.setAttribute("accomplishedProjects", accomplishedProjects);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Projects - Alluring Decors</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/navbar-override.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <section class="hero">
            <div class="hero-content">
                <h2>Our Projects</h2>
            </div>
        </section>

        <section class="projects-preview">
            <h3>Ongoing Projects</h3>
            <div class="projects-grid">
                <c:choose>
                    <c:when test="${not empty ongoingProjects}">
                        <c:forEach var="project" items="${ongoingProjects}">
                            <div class="project-card">
                                <h4>${project.title}</h4>
                                <p>${project.shortDescription}</p>
                                <p><strong>Client:</strong> ${project.clientName}</p>
                                <p><strong>Location:</strong> ${project.location}</p>
                                <c:if test="${project.startDate != null}">
                                    <p><strong>Started:</strong> ${project.startDate}</p>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="project-card">
                            <h4>No Ongoing Projects</h4>
                            <p>We currently have no ongoing projects. Check back soon for updates!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <h3>Accomplished Projects</h3>
            <div class="projects-grid">
                <c:choose>
                    <c:when test="${not empty accomplishedProjects}">
                        <c:forEach var="project" items="${accomplishedProjects}">
                            <div class="project-card">
                                <h4>${project.title}</h4>
                                <p>${project.shortDescription}</p>
                                <p><strong>Client:</strong> ${project.clientName}</p>
                                <p><strong>Location:</strong> ${project.location}</p>
                                <c:if test="${project.startDate != null}">
                                    <p><strong>Completed:</strong> ${project.startDate}</p>
                                </c:if>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="project-card">
                            <h4>No Accomplished Projects</h4>
                            <p>We haven't completed any projects yet. Stay tuned for our portfolio!</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2024 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>
</body>
</html>