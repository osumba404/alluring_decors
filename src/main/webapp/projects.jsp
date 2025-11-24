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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/modern-ui.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <main>
        <!-- Hero Section -->
        <section class="contact-hero">
            <div class="container">
                <h1 class="fade-in">Our Projects</h1>
                <p class="fade-in">Discover our portfolio of stunning interior and exterior transformations</p>
            </div>
        </section>

        <!-- Project Filters -->
        <section style="padding: 2rem 5%; max-width: 1200px; margin: 0 auto;">
            <div style="display: flex; justify-content: center; gap: 1rem; flex-wrap: wrap; margin-bottom: 3rem;">
                <button class="filter-btn active" onclick="filterProjects('all')" style="padding: 0.75rem 1.5rem; border: 2px solid var(--primary); background: var(--primary); color: white; border-radius: 25px; cursor: pointer; font-weight: 600; transition: all var(--transition-normal);">
                    All Projects
                </button>
                <button class="filter-btn" onclick="filterProjects('ongoing')" style="padding: 0.75rem 1.5rem; border: 2px solid var(--border); background: white; color: var(--text); border-radius: 25px; cursor: pointer; font-weight: 600; transition: all var(--transition-normal);">
                    Ongoing
                </button>
                <button class="filter-btn" onclick="filterProjects('accomplished')" style="padding: 0.75rem 1.5rem; border: 2px solid var(--border); background: white; color: var(--text); border-radius: 25px; cursor: pointer; font-weight: 600; transition: all var(--transition-normal);">
                    Completed
                </button>
            </div>
        </section>

        <!-- Ongoing Projects -->
        <section class="project-section" data-category="ongoing" style="padding: 2rem 5%; max-width: 1200px; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: #164e31; margin-bottom: 1rem; font-size: 2.5rem;">
                    <i class="fas fa-hammer" style="color: #D4A017;"></i>
                    Ongoing Projects
                </h2>
                <p style="color: #666;">Projects currently in progress</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty ongoingProjects}">
                    <c:forEach var="project" items="${ongoingProjects}" varStatus="status">
                        <div class="project-row" style="display: flex; align-items: center; margin-bottom: 4rem; background: white; border-radius: 20px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); overflow: hidden; min-height: 400px; ${status.index % 2 == 1 ? 'flex-direction: row-reverse;' : ''}">
                            <div class="project-image" style="flex: 1; height: 400px;">
                                <c:choose>
                                    <c:when test="${project.thumbnailUrl != null && !empty project.thumbnailUrl}">
                                        <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%); display: flex; align-items: center; justify-content: center; color: #D4A017; font-size: 4rem;">
                                            <i class="fas fa-building"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="project-content" style="flex: 1; padding: 3rem; display: flex; flex-direction: column; justify-content: center;">
                                <h4 style="color: #164e31; font-size: 2rem; margin-bottom: 1rem;">${project.title}</h4>
                                <p style="color: #666; font-size: 1.1rem; line-height: 1.6; margin-bottom: 1.5rem;">${project.shortDescription}</p>
                                <div style="margin-bottom: 1.5rem;">
                                    <p style="margin-bottom: 0.5rem;"><strong style="color: #164e31;">Client:</strong> <span style="color: #666;">${project.clientName}</span></p>
                                    <p style="margin-bottom: 0.5rem;"><strong style="color: #164e31;">Location:</strong> <span style="color: #666;">${project.location}</span></p>
                                    <c:if test="${project.startDate != null}">
                                        <p><strong style="color: #164e31;">Started:</strong> <span style="color: #666;">${project.startDate}</span></p>
                                    </c:if>
                                </div>
                                <div style="display: flex; gap: 1rem;">
                                    <button style="background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); color: #164e31; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;" onclick="viewProjectDetails(${project.projectId})">More Details</button>
                                    <span style="background: #fff3cd; color: #856404; padding: 0.8rem 1.5rem; border-radius: 8px; font-weight: 600;">In Progress</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 4rem; background: white; border-radius: 20px; box-shadow: 0 8px 25px rgba(0,0,0,0.1);">
                        <i class="fas fa-tools" style="font-size: 4rem; color: #D4A017; margin-bottom: 1rem;"></i>
                        <h4 style="color: #164e31; margin-bottom: 1rem;">No Ongoing Projects</h4>
                        <p style="color: #666;">We currently have no ongoing projects. Check back soon for updates!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>

        <!-- Accomplished Projects -->
        <section class="project-section" data-category="accomplished" style="padding: 2rem 5%; max-width: 1200px; margin: 2rem auto;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: #164e31; margin-bottom: 1rem; font-size: 2.5rem;">
                    <i class="fas fa-check-circle" style="color: #28a745;"></i>
                    Completed Projects
                </h2>
                <p style="color: #666;">Our portfolio of successful transformations</p>
            </div>
            
            <c:choose>
                <c:when test="${not empty accomplishedProjects}">
                    <c:forEach var="project" items="${accomplishedProjects}" varStatus="status">
                        <div class="project-row" style="display: flex; align-items: center; margin-bottom: 4rem; background: white; border-radius: 20px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); overflow: hidden; min-height: 400px; ${status.index % 2 == 1 ? 'flex-direction: row-reverse;' : ''}">
                            <div class="project-image" style="flex: 1; height: 400px;">
                                <c:choose>
                                    <c:when test="${project.thumbnailUrl != null && !empty project.thumbnailUrl}">
                                        <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 100%; object-fit: cover;">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width: 100%; height: 100%; background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%); display: flex; align-items: center; justify-content: center; color: #D4A017; font-size: 4rem;">
                                            <i class="fas fa-building"></i>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="project-content" style="flex: 1; padding: 3rem; display: flex; flex-direction: column; justify-content: center;">
                                <h4 style="color: #164e31; font-size: 2rem; margin-bottom: 1rem;">${project.title}</h4>
                                <p style="color: #666; font-size: 1.1rem; line-height: 1.6; margin-bottom: 1.5rem;">${project.shortDescription}</p>
                                <div style="margin-bottom: 1.5rem;">
                                    <p style="margin-bottom: 0.5rem;"><strong style="color: #164e31;">Client:</strong> <span style="color: #666;">${project.clientName}</span></p>
                                    <p style="margin-bottom: 0.5rem;"><strong style="color: #164e31;">Location:</strong> <span style="color: #666;">${project.location}</span></p>
                                    <c:if test="${project.startDate != null}">
                                        <p><strong style="color: #164e31;">Completed:</strong> <span style="color: #666;">${project.startDate}</span></p>
                                    </c:if>
                                </div>
                                <div style="display: flex; gap: 1rem;">
                                    <button style="background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); color: #164e31; padding: 0.8rem 1.5rem; border: none; border-radius: 8px; font-weight: 600; cursor: pointer;" onclick="viewProjectDetails(${project.projectId})">More Details</button>
                                    <span style="background: #d4edda; color: #155724; padding: 0.8rem 1.5rem; border-radius: 8px; font-weight: 600;">Completed</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 4rem; background: white; border-radius: 20px; box-shadow: 0 8px 25px rgba(0,0,0,0.1);">
                        <i class="fas fa-check-circle" style="font-size: 4rem; color: #D4A017; margin-bottom: 1rem;"></i>
                        <h4 style="color: #164e31; margin-bottom: 1rem;">No Completed Projects Yet</h4>
                        <p style="color: #666;">We're working hard on our first projects. Stay tuned for our amazing portfolio!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </section>
    </main>

    <footer>
        <div class="container">
            <p>&copy; 2025 Alluring Decors. All rights reserved. | Designed with elegance.</p>
        </div>
    </footer>

    <script>
        // Filter functionality
        function filterProjects(category) {
            const sections = document.querySelectorAll('.project-section');
            const buttons = document.querySelectorAll('.filter-btn');
            
            // Update button states
            buttons.forEach(btn => {
                btn.style.background = 'white';
                btn.style.color = 'var(--text)';
                btn.style.borderColor = 'var(--border)';
                btn.classList.remove('active');
            });
            
            event.target.style.background = 'var(--primary)';
            event.target.style.color = 'white';
            event.target.style.borderColor = 'var(--primary)';
            event.target.classList.add('active');
            
            // Show/hide sections
            sections.forEach(section => {
                if (category === 'all' || section.dataset.category === category) {
                    section.style.display = 'block';
                } else {
                    section.style.display = 'none';
                }
            });
        }
        
        // View project details
        function viewProjectDetails(projectId) {
            // For now, just show an alert. In a real app, this would navigate to a detail page
            alert('Project details functionality coming soon!');
        }
        
        // Add hover effects to project cards
        document.addEventListener('DOMContentLoaded', () => {
            const projectCards = document.querySelectorAll('.project-card');
            projectCards.forEach(card => {
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-8px)';
                    card.style.boxShadow = 'var(--shadow-xl)';
                    const img = card.querySelector('img');
                    if (img) {
                        img.style.transform = 'scale(1.05)';
                    }
                });
                
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0)';
                    card.style.boxShadow = 'var(--shadow-md)';
                    const img = card.querySelector('img');
                    if (img) {
                        img.style.transform = 'scale(1)';
                    }
                });
            });
            
            // Animation observer
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            const animatedElements = document.querySelectorAll('.slide-up, .fade-in');
            animatedElements.forEach(el => {
                el.style.opacity = '0';
                el.style.transform = 'translateY(30px)';
                el.style.transition = 'all 0.6s ease-out';
                observer.observe(el);
            });
        });
    </script>
</body>
</html>