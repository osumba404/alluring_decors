package com.alluringdecors.servlet;

import com.alluringdecors.bean.ProjectBean;
import com.alluringdecors.model.Project;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/projects")
public class ProjectsServlet extends HttpServlet {
    
    private ProjectBean projectBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        projectBean = new ProjectBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("ProjectsServlet: doGet called");
        
        List<Project> upcomingProjects = projectBean.getUpcomingProjects();
        List<Project> ongoingProjects = projectBean.getOngoingProjects();
        List<Project> accomplishedProjects = projectBean.getAccomplishedProjects();
        
        request.setAttribute("upcomingProjects", upcomingProjects);
        request.setAttribute("ongoingProjects", ongoingProjects);
        request.setAttribute("accomplishedProjects", accomplishedProjects);
        
        request.getRequestDispatcher("/projects.jsp").forward(request, response);
    }
}