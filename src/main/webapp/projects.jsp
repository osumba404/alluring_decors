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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                                <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 1rem;">
                                <h4>${project.title}</h4>
                                <p style="font-size: 0.8rem; color: #666;">URL: ${project.thumbnailUrl}</p>
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
                                <c:choose>
                                    <c:when test="${project.thumbnailUrl != null && !empty project.thumbnailUrl}">
                                        <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 1rem;" onerror="this.style.display='none'">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width: 100%; height: 200px; background: #f0f0f0; border-radius: 8px; margin-bottom: 1rem; display: flex; align-items: center; justify-content: center; color: #999;">
                                            <i class="fas fa-image" style="font-size: 3rem;"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
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