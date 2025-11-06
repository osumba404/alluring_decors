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
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Service Domains</h1>" +
                "<p class='dashboard-subtitle'>Configure service domains and categories</p></div>" +
                "<button class='header-action-btn' onclick=\"openModal('Add New Domain', '" +
                "<form method=\\\"post\\\" action=\\\"domains\\\">" +
                "<div class=\\\"form-group\\\"><label>Domain Name:</label><input type=\\\"text\\\" name=\\\"name\\\" required></div>" +
                "<div class=\\\"form-group\\\"><label>Description:</label><textarea name=\\\"description\\\" rows=\\\"3\\\" required></textarea></div>" +
                "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Add Domain</button></form>')\"><i class='fas fa-plus'></i> Add Domain</button></div>" +
                "<table class='admin-table'><thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Actions</th></tr></thead><tbody>"
            );
            if (domains.isEmpty()) {
                response.getWriter().println("<tr><td colspan='4' style='text-align:center; padding: 2rem; color: #666;'>No domains available. Click 'Add Domain' to create one.</td></tr>");
            } else {
                for (Domain domain : domains) {
                    String description = domain.getDescription() != null ? domain.getDescription().replace("'", "\\'").replace("\"", "&quot;") : "";
                    response.getWriter().println(
                        "<tr><td>" + domain.getDomainId() + "</td><td><strong>" + domain.getName() + "</strong></td><td>" + domain.getDescription() + 
                        "</td><td><button class='action-btn' onclick=\"openModal('Edit Domain', '" +
                        "<form method=\\\"post\\\" action=\\\"domains\\\">" +
                        "<input type=\\\"hidden\\\" name=\\\"domainId\\\" value=\\\"" + domain.getDomainId() + "\\\">" +
                        "<div class=\\\"form-group\\\"><label>Domain Name:</label><input type=\\\"text\\\" name=\\\"name\\\" value=\\\"" + domain.getName() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Description:</label><textarea name=\\\"description\\\" rows=\\\"3\\\" required>" + description + "</textarea></div>" +
                        "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Update Domain</button></form>')\"><i class='fas fa-edit'></i> Edit</button> " +
                        "<a href='domains?action=delete&id=" + domain.getDomainId() + "' class='action-btn delete' onclick='return confirm(\"Delete this domain?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
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