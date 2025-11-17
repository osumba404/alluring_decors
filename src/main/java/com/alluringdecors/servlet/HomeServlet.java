package com.alluringdecors.servlet;

import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.bean.ProjectBean;
import com.alluringdecors.bean.HeroBean;
import com.alluringdecors.model.Domain;
import com.alluringdecors.model.Project;
import com.alluringdecors.model.Hero;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"", "/home"})
public class HomeServlet extends HttpServlet {
    
    private DomainBean domainBean;
    private ProjectBean projectBean;
    private HeroBean heroBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        domainBean = new DomainBean();
        projectBean = new ProjectBean();
        heroBean = new HeroBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Domain> domains = domainBean.getAllActiveDomains();
            
            // Add service count to each domain
            com.alluringdecors.bean.ServiceBean serviceBean = new com.alluringdecors.bean.ServiceBean();
            for (Domain domain : domains) {
                int serviceCount = serviceBean.getServiceCountByDomainId(domain.getDomainId());
                domain.setServiceCount(serviceCount);
            }
            
            List<Project> recentProjects = projectBean.getAccomplishedProjects();
            List<Hero> heroes = heroBean.getAllActiveHeroes();
            
            request.setAttribute("domains", domains);
            request.setAttribute("recentProjects", recentProjects);
            request.setAttribute("heroes", heroes);
        } catch (Exception e) {
            e.printStackTrace();
            // Set empty lists if database fails
            request.setAttribute("domains", new java.util.ArrayList<>());
            request.setAttribute("recentProjects", new java.util.ArrayList<>());
            request.setAttribute("heroes", new java.util.ArrayList<>());
        }
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}