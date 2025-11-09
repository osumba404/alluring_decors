package com.alluringdecors.servlet;

import com.alluringdecors.bean.ProjectBean;
import com.alluringdecors.model.Project;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/admin/projects")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class AdminProjectsServlet extends HttpServlet {
    
    private ProjectBean projectBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        projectBean = new ProjectBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int projectId = Integer.parseInt(request.getParameter("id"));
            projectBean.deleteProject(projectId);
            response.sendRedirect("http://localhost:8082/alluring-decors/admin/dashboard");
            return;
        }
        
        if ("view".equals(action)) {
            int projectId = Integer.parseInt(request.getParameter("id"));
            Project project = projectBean.getProjectById(projectId);
            if (project != null) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().println("{");
                response.getWriter().println("\"projectId\": " + project.getProjectId() + ",");
                response.getWriter().println("\"title\": \"" + (project.getTitle() != null ? project.getTitle().replace("\"", "\\\""): "") + "\",");
                response.getWriter().println("\"clientName\": \"" + (project.getClientName() != null ? project.getClientName().replace("\"", "\\\""): "") + "\",");
                response.getWriter().println("\"location\": \"" + (project.getLocation() != null ? project.getLocation().replace("\"", "\\\""): "") + "\",");
                response.getWriter().println("\"category\": \"" + (project.getCategory() != null ? project.getCategory(): "") + "\",");
                response.getWriter().println("\"shortDescription\": \"" + (project.getShortDescription() != null ? project.getShortDescription().replace("\"", "\\\\").replace("\n", "\\n"): "") + "\",");
                response.getWriter().println("\"fullDescription\": \"" + (project.getFullDescription() != null ? project.getFullDescription().replace("\"", "\\\\").replace("\n", "\\n"): "") + "\",");
                response.getWriter().println("\"thumbnailUrl\": \"" + (project.getThumbnailUrl() != null ? project.getThumbnailUrl(): "") + "\",");
                response.getWriter().println("\"startDate\": \"" + (project.getStartDate() != null ? project.getStartDate().toString(): "") + "\"");
                response.getWriter().println("}");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Project not found");
            }
            return;
        }
        
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Projects</h1>" +
                "<p class='dashboard-subtitle'>View and manage all projects</p></div>" +
                "<button class='header-action-btn' onclick='showAddProjectForm()'><i class='fas fa-plus'></i> Add Project</button></div>" +
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-tasks'></i> Ongoing Projects</h3>" +
                "<table class='admin-table' style='margin-bottom: 3rem;'><thead><tr><th>Thumbnail</th><th>Title</th><th>Client</th><th>Location</th><th>Start Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (ongoingProjects.isEmpty()) {
                response.getWriter().println("<tr><td colspan='6' style='text-align:center; padding: 2rem; color: #666;'>No ongoing projects. Click 'Add Project' to create one.</td></tr>");
            } else {
                for (Project project : ongoingProjects) {
                    String startDate = project.getStartDate() != null ? project.getStartDate().toString() : "N/A";
                    String thumbnailHtml = project.getThumbnailUrl() != null && !project.getThumbnailUrl().isEmpty() 
                        ? "<img src='" + project.getThumbnailUrl() + "' style='width: 60px; height: 60px; object-fit: cover; border-radius: 8px;'>" 
                        : "<div style='width: 60px; height: 60px; background: #f0f0f0; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: #999;'><i class='fas fa-image'></i></div>";
                    response.getWriter().println(
                        "<tr><td>" + thumbnailHtml + "</td><td><strong>" + project.getTitle() + "</strong></td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                        "</td><td>" + startDate + "</td><td>" +
                        "<button class='action-btn view' onclick='viewProject(" + project.getProjectId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='editProject(" + project.getProjectId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='projects?action=delete&id=" + project.getProjectId() + "' class='action-btn delete' onclick='return confirm(\"Delete this project?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
            
            response.getWriter().println(
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-check-circle'></i> Accomplished Projects</h3>" +
                "<table class='admin-table'><thead><tr><th>Thumbnail</th><th>Title</th><th>Client</th><th>Location</th><th>Start Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (accomplishedProjects.isEmpty()) {
                response.getWriter().println("<tr><td colspan='6' style='text-align:center; padding: 2rem; color: #666;'>No accomplished projects yet.</td></tr>");
            } else {
                for (Project project : accomplishedProjects) {
                    String startDate = project.getStartDate() != null ? project.getStartDate().toString() : "N/A";
                    String thumbnailHtml = project.getThumbnailUrl() != null && !project.getThumbnailUrl().isEmpty() 
                        ? "<img src='" + project.getThumbnailUrl() + "' style='width: 60px; height: 60px; object-fit: cover; border-radius: 8px;'>" 
                        : "<div style='width: 60px; height: 60px; background: #f0f0f0; border-radius: 8px; display: flex; align-items: center; justify-content: center; color: #999;'><i class='fas fa-image'></i></div>";
                    response.getWriter().println(
                        "<tr><td>" + thumbnailHtml + "</td><td><strong>" + project.getTitle() + "</strong></td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                        "</td><td>" + startDate + "</td><td>" +
                        "<button class='action-btn view' onclick='viewProject(" + project.getProjectId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='editProject(" + project.getProjectId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='projects?action=delete&id=" + project.getProjectId() + "' class='action-btn delete' onclick='return confirm(\"Delete this project?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("ongoingProjects", ongoingProjects);
            request.setAttribute("accomplishedProjects", accomplishedProjects);
            request.getRequestDispatcher("/admin-projects.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String projectIdStr = request.getParameter("projectId");
        String title = request.getParameter("title");
        String shortDescription = request.getParameter("shortDescription");
        String fullDescription = request.getParameter("fullDescription");
        String category = request.getParameter("category");
        String clientName = request.getParameter("clientName");
        String location = request.getParameter("location");
        String thumbnailUrl = null;
        
        if (title == null || title.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Title is required");
            return;
        }
        
        // Handle file upload
        try {
            Part filePart = request.getPart("projectImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String webappPath = getServletContext().getRealPath("/");
                File uploadsDir = new File(webappPath, "uploads/projects");
                if (!uploadsDir.exists()) uploadsDir.mkdirs();
                
                File targetFile = new File(uploadsDir, fileName);
                try (java.io.InputStream input = filePart.getInputStream();
                     java.io.FileOutputStream output = new java.io.FileOutputStream(targetFile)) {
                    input.transferTo(output);
                }
                thumbnailUrl = "/alluring-decors/uploads/projects/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        System.out.println("=== FINAL RESULT ===");
        System.out.println("thumbnailUrl to save: " + thumbnailUrl);
        System.out.println("====================");
        
        Project project = new Project(title, shortDescription, fullDescription, category);
        project.setClientName(clientName);
        project.setLocation(location);
        project.setThumbnailUrl(thumbnailUrl);
        
        String startDateStr = request.getParameter("startDate");
        if (startDateStr != null && !startDateStr.isEmpty()) {
            project.setStartDate(LocalDate.parse(startDateStr));
        }
        
        boolean success;
        if (projectIdStr != null && !projectIdStr.isEmpty()) {
            project.setProjectId(Integer.parseInt(projectIdStr));
            success = projectBean.updateProject(project);
        } else {
            success = projectBean.addProject(project);
        }
        
        response.sendRedirect("http://localhost:8082/alluring-decors/admin/dashboard");
    }
}