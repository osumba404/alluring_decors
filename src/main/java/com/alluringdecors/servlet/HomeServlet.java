package com.alluringdecors.servlet;

import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.bean.ProjectBean;
import com.alluringdecors.model.Domain;
import com.alluringdecors.model.Project;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"", "/home"})
public class HomeServlet extends HttpServlet {
    
    @EJB
    private DomainBean domainBean;
    
    @EJB
    private ProjectBean projectBean;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Domain> domains = domainBean.getAllActiveDomains();
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        
        request.setAttribute("domains", domains);
        request.setAttribute("ongoingProjects", ongoingProjects);
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}