package com.alluringdecors.servlet;

import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.model.Domain;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/domains")
public class AdminDomainsServlet extends HttpServlet {
    
    private DomainBean domainBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        domainBean = new DomainBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int domainId = Integer.parseInt(request.getParameter("id"));
            domainBean.deleteDomain(domainId);
            response.sendRedirect("domains");
            return;
        }
        
        List<Domain> domains = domainBean.getAllActiveDomains();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>Manage Service Domains</h1></div>" +
                "<div class='auth-form' style='max-width: 600px; margin-bottom: 3rem;'>" +
                "<h3>Add New Domain</h3><form method='post' action='domains'>" +
                "<div class='form-group'><label>Domain Name:</label><input type='text' name='name' required></div>" +
                "<div class='form-group'><label>Description:</label><textarea name='description' rows='3' required></textarea></div>" +
                "<button type='submit' class='btn-primary'>Add Domain</button></form></div>" +
                "<h3>Existing Domains</h3><table><thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Actions</th></tr></thead><tbody>"
            );
            for (Domain domain : domains) {
                response.getWriter().println(
                    "<tr><td>" + domain.getDomainId() + "</td><td>" + domain.getName() + "</td><td>" + domain.getDescription() + 
                    "</td><td><a href='domains?action=delete&id=" + domain.getDomainId() + "' onclick='return confirm(\"Delete this domain?\")'>Delete</a></td></tr>"
                );
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("domains", domains);
            request.getRequestDispatcher("/admin-domains.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        
        Domain domain = new Domain(name, description);
        domainBean.addDomain(domain);
        
        response.sendRedirect("domains");
    }
}