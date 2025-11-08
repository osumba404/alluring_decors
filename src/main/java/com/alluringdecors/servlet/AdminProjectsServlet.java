package com.alluringdecors.servlet;

import com.alluringdecors.bean.ProjectBean;
import com.alluringdecors.model.Project;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/admin/projects")
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
            response.sendRedirect(request.getContextPath() + "/admin/projects");
            return;
        }
        
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Projects</h1>" +
                "<p class='dashboard-subtitle'>View and manage all ongoing and accomplished projects</p></div>" +
                "<button class='header-action-btn' onclick='showAddProjectForm()'><i class='fas fa-plus'></i> Add Project</button></div>" +
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
                        "<button class='action-btn view' onclick=\"openModal('Project Details', '" +
                        "<div class=\\\"form-group\\\"><label>Title:</label><input type=\\\"text\\\" value=\\\"" + project.getTitle() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Client:</label><input type=\\\"text\\\" value=\\\"" + project.getClientName() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Location:</label><input type=\\\"text\\\" value=\\\"" + project.getLocation() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Start Date:</label><input type=\\\"text\\\" value=\\\"" + startDate + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Short Description:</label><textarea rows=\\\"3\\\" readonly>" + shortDesc + "</textarea></div>" +
                        (fullDesc.isEmpty() ? "" : "<div class=\\\"form-group\\\"><label>Full Description:</label><textarea rows=\\\"4\\\" readonly>" + fullDesc + "</textarea></div>") +
                        "')\"><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick=\"openModal('Edit Project', '" +
                        "<form method=\\\"post\\\" action=\\\"projects?action=edit&id=" + project.getProjectId() + "\\\">" +
                        "<input type=\\\"hidden\\\" name=\\\"projectId\\\" value=\\\"" + project.getProjectId() + "\\\">" +
                        "<div class=\\\"form-group\\\"><label>Title:</label><input type=\\\"text\\\" name=\\\"title\\\" value=\\\"" + project.getTitle() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Client:</label><input type=\\\"text\\\" name=\\\"clientName\\\" value=\\\"" + project.getClientName() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Location:</label><input type=\\\"text\\\" name=\\\"location\\\" value=\\\"" + project.getLocation() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Category:</label><select name=\\\"category\\\" required><option value='ongoing' selected>Ongoing</option><option value='accomplished'>Accomplished</option></select></div>" +
                        "<div class=\\\"form-group\\\"><label>Short Description:</label><textarea name=\\\"shortDescription\\\" rows=\\\"3\\\" required>" + shortDesc + "</textarea></div>" +
                        "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Update Project</button></form>')\"><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='projects?action=delete&id=" + project.getProjectId() + "' class='action-btn delete' onclick='return confirm(\"Delete this project?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
            
            // Accomplished Projects
            response.getWriter().println(
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-check-circle'></i> Accomplished Projects</h3>" +
                "<table class='admin-table'><thead><tr><th>Title</th><th>Client</th><th>Location</th><th>Start Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (accomplishedProjects.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No accomplished projects yet.</td></tr>");
            } else {
                for (Project project : accomplishedProjects) {
                    String startDate = project.getStartDate() != null ? project.getStartDate().toString() : "N/A";
                    String shortDesc = project.getShortDescription() != null ? project.getShortDescription().replace("'", "\\'").replace("\"", "&quot;") : "";
                    String fullDesc = project.getFullDescription() != null ? project.getFullDescription().replace("'", "\\'").replace("\"", "&quot;") : "";
                    response.getWriter().println(
                        "<tr><td><strong>" + project.getTitle() + "</strong></td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                        "</td><td>" + startDate + "</td><td>" +
                        "<button class='action-btn view' onclick=\"openModal('Project Details', '" +
                        "<div class=\\\"form-group\\\"><label>Title:</label><input type=\\\"text\\\" value=\\\"" + project.getTitle() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Client:</label><input type=\\\"text\\\" value=\\\"" + project.getClientName() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Location:</label><input type=\\\"text\\\" value=\\\"" + project.getLocation() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Start Date:</label><input type=\\\"text\\\" value=\\\"" + startDate + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Short Description:</label><textarea rows=\\\"3\\\" readonly>" + shortDesc + "</textarea></div>" +
                        (fullDesc.isEmpty() ? "" : "<div class=\\\"form-group\\\"><label>Full Description:</label><textarea rows=\\\"4\\\" readonly>" + fullDesc + "</textarea></div>") +
                        "')\"><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick=\"openModal('Edit Project', '" +
                        "<form method=\\\"post\\\" action=\\\"projects?action=edit&id=" + project.getProjectId() + "\\\">" +
                        "<input type=\\\"hidden\\\" name=\\\"projectId\\\" value=\\\"" + project.getProjectId() + "\\\">" +
                        "<div class=\\\"form-group\\\"><label>Title:</label><input type=\\\"text\\\" name=\\\"title\\\" value=\\\"" + project.getTitle() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Client:</label><input type=\\\"text\\\" name=\\\"clientName\\\" value=\\\"" + project.getClientName() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Location:</label><input type=\\\"text\\\" name=\\\"location\\\" value=\\\"" + project.getLocation() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Category:</label><select name=\\\"category\\\" required><option value='ongoing'>Ongoing</option><option value='accomplished' selected>Accomplished</option></select></div>" +
                        "<div class=\\\"form-group\\\"><label>Short Description:</label><textarea name=\\\"shortDescription\\\" rows=\\\"3\\\" required>" + shortDesc + "</textarea></div>" +
                        "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Update Project</button></form>')\"><i class='fas fa-edit'></i> Edit</button> " +
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
        System.out.println("Form parameters - Title: " + title);
        String shortDescription = request.getParameter("shortDescription");
        String fullDescription = request.getParameter("fullDescription");
        String category = request.getParameter("category");
        String clientName = request.getParameter("clientName");
        String location = request.getParameter("location");
        
        Project project = new Project(title, shortDescription, fullDescription, category);
        project.setClientName(clientName);
        project.setLocation(location);
        
        String startDateStr = request.getParameter("startDate");
        if (startDateStr != null && !startDateStr.isEmpty()) {
            project.setStartDate(LocalDate.parse(startDateStr));
        }
        
        // Validate required fields
        if (title == null || title.trim().isEmpty()) {
            System.out.println("Title is null or empty!");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Title is required");
            return;
        }
        
        System.out.println("Adding project with title: " + title);
        boolean success = projectBean.addProject(project);
        System.out.println("Project add result: " + success);
        response.sendRedirect(request.getContextPath() + "/admin/projects");
    }
}