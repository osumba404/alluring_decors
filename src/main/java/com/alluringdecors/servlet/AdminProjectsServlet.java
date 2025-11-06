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
            response.sendRedirect("projects");
            return;
        }
        
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>Manage Projects</h1></div>" +
                "<div class='auth-form' style='max-width: 600px; margin-bottom: 3rem;'>" +
                "<h3>Add New Project</h3><form method='post' action='projects'>" +
                "<div class='form-group'><label>Title:</label><input type='text' name='title' required></div>" +
                "<div class='form-group'><label>Short Description:</label><textarea name='shortDescription' rows='2' required></textarea></div>" +
                "<div class='form-group'><label>Category:</label><select name='category' required><option value='ongoing'>Ongoing</option><option value='accomplished'>Accomplished</option></select></div>" +
                "<div class='form-group'><label>Client Name:</label><input type='text' name='clientName'></div>" +
                "<div class='form-group'><label>Location:</label><input type='text' name='location'></div>" +
                "<button type='submit' class='btn-primary'>Add Project</button></form></div>" +
                "<h3>Ongoing Projects</h3><table style='margin-bottom: 3rem;'><thead><tr><th>Title</th><th>Client</th><th>Location</th><th>Actions</th></tr></thead><tbody>"
            );
            for (Project project : ongoingProjects) {
                response.getWriter().println(
                    "<tr><td>" + project.getTitle() + "</td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + 
                    "</td><td><a href='projects?action=delete&id=" + project.getProjectId() + "' onclick='return confirm(\"Delete this project?\")'>Delete</a></td></tr>"
                );
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
        
        String title = request.getParameter("title");
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
        
        projectBean.addProject(project);
        response.sendRedirect("projects");
    }
}