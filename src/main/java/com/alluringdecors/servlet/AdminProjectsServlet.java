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
        
        if ("delete".equals(action)) {
            int projectId = Integer.parseInt(request.getParameter("id"));
            projectBean.deleteProject(projectId);
            response.sendRedirect("projects");
            return;
        }
        
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        List<Project> upcomingProjects = projectBean.getProjectsByCategory("upcoming");
        List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
        
        request.setAttribute("ongoingProjects", ongoingProjects);
        request.setAttribute("upcomingProjects", upcomingProjects);
        request.setAttribute("accomplishedProjects", accomplishedProjects);
        
        request.getRequestDispatcher("/admin-projects.jsp").forward(request, response);
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