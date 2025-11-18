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
                <h2 style="color: var(--primary); margin-bottom: 1rem; display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
                    <i class="fas fa-hammer" style="color: var(--accent);"></i>
                    Ongoing Projects
                </h2>
                <p style="color: var(--text-light);">Projects currently in progress</p>
            </div>
            
            <div class="projects-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem;">
                <c:choose>
                    <c:when test="${not empty ongoingProjects}">
                        <c:forEach var="project" items="${ongoingProjects}">
                            <div class="project-card slide-up" style="background: var(--white); border-radius: 20px; overflow: hidden; box-shadow: var(--shadow-md); border: 1px solid var(--border-light); transition: all var(--transition-normal); position: relative;">
                                <div style="position: relative; overflow: hidden;">
                                    <c:choose>
                                        <c:when test="${project.thumbnailUrl != null && !empty project.thumbnailUrl}">
                                            <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 250px; object-fit: cover; transition: transform var(--transition-normal);" onerror="this.parentElement.innerHTML='<div style=\"width: 100%; height: 250px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;\"><i class=\"fas fa-image\"></i></div>'">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width: 100%; height: 250px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div style="position: absolute; top: 1rem; right: 1rem; background: var(--warning); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">
                                        <i class="fas fa-clock"></i> In Progress
                                    </div>
                                </div>
                                
                                <div style="padding: 2rem;">
                                    <h4 style="color: var(--primary); margin-bottom: 1rem; font-size: 1.3rem;">${project.title}</h4>
                                    <p style="color: var(--text-light); margin-bottom: 1.5rem; line-height: 1.6;">${project.shortDescription}</p>
                                    
                                    <div style="display: grid; gap: 0.5rem; margin-bottom: 1.5rem;">
                                        <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">
                                            <i class="fas fa-user" style="color: var(--accent);"></i>
                                            <span><strong>Client:</strong> ${project.clientName}</span>
                                        </div>
                                        <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">
                                            <i class="fas fa-map-marker-alt" style="color: var(--accent);"></i>
                                            <span><strong>Location:</strong> ${project.location}</span>
                                        </div>
                                        <c:if test="${project.startDate != null}">
                                            <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">
                                                <i class="fas fa-calendar" style="color: var(--accent);"></i>
                                                <span><strong>Started:</strong> ${project.startDate}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <button class="btn btn-primary" style="width: 100%; padding: 0.75rem;" onclick="viewProjectDetails(${project.projectId})">
                                        <i class="fas fa-eye"></i> View Details
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 4rem 2rem; background: var(--white); border-radius: 20px; box-shadow: var(--shadow-md);">
                            <div style="width: 80px; height: 80px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2rem; color: white; font-size: 2rem;">
                                <i class="fas fa-hammer"></i>
                            </div>
                            <h4 style="color: var(--primary); margin-bottom: 1rem;">No Ongoing Projects</h4>
                            <p style="color: var(--text-light); margin-bottom: 2rem;">We currently have no ongoing projects. Check back soon for updates!</p>
                            <a href="${pageContext.request.contextPath}/request-service" class="btn btn-primary">Start Your Project</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- Accomplished Projects -->
        <section class="project-section" data-category="accomplished" style="padding: 2rem 5%; max-width: 1200px; margin: 2rem auto;">
            <div style="text-align: center; margin-bottom: 3rem;">
                <h2 style="color: var(--primary); margin-bottom: 1rem; display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
                    <i class="fas fa-check-circle" style="color: var(--success);"></i>
                    Completed Projects
                </h2>
                <p style="color: var(--text-light);">Our portfolio of successful transformations</p>
            </div>
            
            <div class="projects-grid" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem;">
                <c:choose>
                    <c:when test="${not empty accomplishedProjects}">
                        <c:forEach var="project" items="${accomplishedProjects}">
                            <div class="project-card slide-up" style="background: var(--white); border-radius: 20px; overflow: hidden; box-shadow: var(--shadow-md); border: 1px solid var(--border-light); transition: all var(--transition-normal); position: relative;">
                                <div style="position: relative; overflow: hidden;">
                                    <c:choose>
                                        <c:when test="${project.thumbnailUrl != null && !empty project.thumbnailUrl}">
                                            <img src="${project.thumbnailUrl}" alt="${project.title}" style="width: 100%; height: 250px; object-fit: cover; transition: transform var(--transition-normal);" onerror="this.parentElement.innerHTML='<div style=\"width: 100%; height: 250px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;\"><i class=\"fas fa-image\"></i></div>'">
                                        </c:when>
                                        <c:otherwise>
                                            <div style="width: 100%; height: 250px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; color: white; font-size: 3rem;">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div style="position: absolute; top: 1rem; right: 1rem; background: var(--success); color: white; padding: 0.5rem 1rem; border-radius: 20px; font-size: 0.8rem; font-weight: 600;">
                                        <i class="fas fa-check"></i> Completed
                                    </div>
                                </div>
                                
                                <div style="padding: 2rem;">
                                    <h4 style="color: var(--primary); margin-bottom: 1rem; font-size: 1.3rem;">${project.title}</h4>
                                    <p style="color: var(--text-light); margin-bottom: 1.5rem; line-height: 1.6;">${project.shortDescription}</p>
                                    
                                    <div style="display: grid; gap: 0.5rem; margin-bottom: 1.5rem;">
                                        <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">
                                            <i class="fas fa-user" style="color: var(--accent);"></i>
                                            <span><strong>Client:</strong> ${project.clientName}</span>
                                        </div>
                                        <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">
                                            <i class="fas fa-map-marker-alt" style="color: var(--accent);"></i>
                                            <span><strong>Location:</strong> ${project.location}</span>
                                        </div>
                                        <c:if test="${project.startDate != null}">
                                            <div style="display: flex; align-items: center; gap: 0.5rem; color: var(--text-muted); font-size: 0.9rem;">
                                                <i class="fas fa-calendar-check" style="color: var(--success);"></i>
                                                <span><strong>Completed:</strong> ${project.startDate}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <button class="btn btn-primary" style="width: 100%; padding: 0.75rem;" onclick="viewProjectDetails(${project.projectId})">
                                        <i class="fas fa-eye"></i> View Details
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="grid-column: 1 / -1; text-align: center; padding: 4rem 2rem; background: var(--white); border-radius: 20px; box-shadow: var(--shadow-md);">
                            <div style="width: 80px; height: 80px; background: var(--gradient-accent); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 2rem; color: white; font-size: 2rem;">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <h4 style="color: var(--primary); margin-bottom: 1rem;">No Completed Projects Yet</h4>
                            <p style="color: var(--text-light); margin-bottom: 2rem;">We're working hard on our first projects. Stay tuned for our amazing portfolio!</p>
                            <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary">Get In Touch</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
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