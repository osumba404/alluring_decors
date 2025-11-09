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
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/admin/projects")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5MB max file size
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
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
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
                response.getWriter().println("\"startDate\": \"" + (project.getStartDate() != null ? project.getStartDate().toString(): "") + "\"");
                response.getWriter().println("}");
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Project not found");
            }
            return;
        }
        
        List<Project> upcomingProjects = projectBean.getProjectsByCategory("upcoming");
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Projects</h1>" +
                "<p class='dashboard-subtitle'>View and manage all projects</p></div>" +
                "<button class='header-action-btn' onclick='showAddProjectForm()'><i class='fas fa-plus'></i> Add Project</button></div>" +
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-clock'></i> Upcoming Projects</h3>" +
                "<table class='admin-table' style='margin-bottom: 3rem;'><thead><tr><th>Title</th><th>Client</th><th>Location</th><th>Start Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (upcomingProjects.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No upcoming projects.</td></tr>");
            } else {
                for (Project project : upcomingProjects) {
                    String startDate = project.getStartDate() != null ? project.getStartDate().toString() : "N/A";
                    response.getWriter().println(
                        "<tr><td><strong>" + project.getTitle() + "</strong></td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                        "</td><td>" + startDate + "</td><td>" +
                        "<button class='action-btn view' onclick='showViewProject(" + project.getProjectId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='showEditProject(" + project.getProjectId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='projects?action=delete&id=" + project.getProjectId() + "' class='action-btn delete' onclick='return confirm(\"Delete this project?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
            
            response.getWriter().println(
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-tasks'></i> Ongoing Projects</h3>" +
                "<table class='admin-table' style='margin-bottom: 3rem;'><thead><tr><th>Title</th><th>Client</th><th>Location</th><th>Start Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (ongoingProjects.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No ongoing projects. Click 'Add Project' to create one.</td></tr>");
            } else {
                for (Project project : ongoingProjects) {
                    String startDate = project.getStartDate() != null ? project.getStartDate().toString() : "N/A";
                    String shortDesc = project.getShortDescription() != null ? project.getShortDescription().replace("'", "\\'").replace("\"", "&quot;") : "";
                    String fullDesc = project.getFullDescription() != null ? project.getFullDescription().replace("'", "\\'").replace("\"", "&quot;") : "";
                    response.getWriter().println(
                        "<tr><td><strong>" + project.getTitle() + "</strong></td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                        "</td><td>" + startDate + "</td><td>" +
                        "<button class='action-btn view' onclick='showViewProject(" + project.getProjectId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='showEditProject(" + project.getProjectId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='projects?action=delete&id=" + project.getProjectId() + "' class='action-btn delete' onclick='return confirm(\"Delete this project?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
            
            response.getWriter().println(
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-check-circle'></i> Accomplished Projects</h3>" +
                "<table class='admin-table'><thead><tr><th>Title</th><th>Client</th><th>Location</th><th>Start Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (accomplishedProjects.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No accomplished projects yet.</td></tr>");
            } else {
                for (Project project : accomplishedProjects) {
                    String startDate = project.getStartDate() != null ? project.getStartDate().toString() : "N/A";
                    response.getWriter().println(
                        "<tr><td><strong>" + project.getTitle() + "</strong></td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                        "</td><td>" + startDate + "</td><td>" +
                        "<button class='action-btn view' onclick='showViewProject(" + project.getProjectId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='showEditProject(" + project.getProjectId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='projects?action=delete&id=" + project.getProjectId() + "' class='action-btn delete' onclick='return confirm(\"Delete this project?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
            
            // Add JavaScript for form
            response.getWriter().println(
                "<script>" +
                "function showAddProjectForm() {" +
                "openModal('Add New Project', '" +
                "<form method=\"post\" action=\"admin/projects\">" +
                "<div class=\"form-group\"><label>Title:</label><input type=\"text\" name=\"title\" required></div>" +
                "<div class=\"form-group\"><label>Short Description:</label><textarea name=\"shortDescription\" rows=\"3\" required></textarea></div>" +
                "<div class=\"form-group\"><label>Full Description:</label><textarea name=\"fullDescription\" rows=\"4\"></textarea></div>" +
                "<div class=\"form-group\"><label>Category:</label><select name=\"category\" required><option value=\"ongoing\">Ongoing</option><option value=\"accomplished\">Accomplished</option></select></div>" +
                "<div class=\"form-group\"><label>Client Name:</label><input type=\"text\" name=\"clientName\" required></div>" +
                "<div class=\"form-group\"><label>Location:</label><input type=\"text\" name=\"location\" required></div>" +
                "<div class=\"form-group\"><label>Start Date:</label><input type=\"date\" name=\"startDate\"></div>" +
                "<button type=\"submit\" class=\"btn-primary\">Add Project</button></form>');" +
                "}" +
                "</script>"
            );
        } else {
            request.setAttribute("ongoingProjects", ongoingProjects);
            request.setAttribute("accomplishedProjects", accomplishedProjects);
            request.getRequestDispatcher("/admin-projects.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("AdminProjectsServlet doPost called");
        System.out.println("All parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println(key + " = " + String.join(", ", values));
        });
        
        String title = request.getParameter("title");
        String shortDescription = request.getParameter("shortDescription");
        String fullDescription = request.getParameter("fullDescription");
        String clientName = request.getParameter("clientName");
        String location = request.getParameter("location");
        String thumbnailUrl = request.getParameter("thumbnailUrl");
        
        // Handle file upload
        Part filePart = request.getPart("projectImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/") + "uploads/projects/";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            
            filePart.write(uploadPath + fileName);
            thumbnailUrl = request.getContextPath() + "/uploads/projects/" + fileName;
        }
        
        LocalDate startDate = null, endDate = null;
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        
        if (startDateStr != null && !startDateStr.isEmpty()) {
            startDate = LocalDate.parse(startDateStr);
        }
        if (endDateStr != null && !endDateStr.isEmpty()) {
            endDate = LocalDate.parse(endDateStr);
        }
        
        // Auto-determine category based on dates
        String category = "upcoming";
        LocalDate today = LocalDate.now();
        if (startDate != null) {
            if (startDate.isAfter(today)) {
                category = "upcoming";
            } else if (endDate != null && endDate.isBefore(today)) {
                category = "accomplished";
            } else {
                category = "ongoing";
            }
        }
        
        Project project = new Project(title, shortDescription, fullDescription, category);
        project.setClientName(clientName);
        project.setLocation(location);
        project.setStartDate(startDate);
        project.setEndDate(endDate);
        project.setThumbnailUrl(thumbnailUrl);
        
        // Validate required fields
        if (title == null || title.trim().isEmpty()) {
            System.out.println("Title is null or empty!");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Title is required");
            return;
        }
        
        System.out.println("Adding project with title: " + title);
        boolean success = projectBean.addProject(project);
        System.out.println("Project add result: " + success);
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}