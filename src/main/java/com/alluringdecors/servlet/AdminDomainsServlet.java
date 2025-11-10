package com.alluringdecors.servlet;

import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.model.Domain;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/domains")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
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
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        

        
        List<Domain> domains = domainBean.getAllActiveDomains();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            
            out.println("<div class='dashboard-header'>");
            out.println("<div><h1 class='dashboard-title'>Manage Service Domains</h1>");
            out.println("<p class='dashboard-subtitle'>Configure service domains and categories</p></div>");
            out.println("<button class='header-action-btn' onclick='showAddDomainForm()'><i class='fas fa-plus'></i> Add Domain</button>");
            out.println("</div>");
            
            out.println("<table class='admin-table'>");
            out.println("<thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            
            if (domains.isEmpty()) {
                out.println("<tr><td colspan='4' style='text-align:center; padding: 2rem; color: #666;'>No domains available. Click 'Add Domain' to create one.</td></tr>");
            } else {
                for (Domain domain : domains) {
                    String safeName = domain.getName().replace("\"", "&quot;");
                    String safeDesc = domain.getDescription().replace("\"", "&quot;");
                    out.println("<tr>");
                    out.println("<td>" + domain.getDomainId() + "</td>");
                    out.println("<td><strong>" + domain.getName() + "</strong></td>");
                    out.println("<td>" + domain.getDescription() + "</td>");
                    out.println("<td>");
                    out.println("<button class='action-btn' onclick='showEditDomainForm(" + domain.getDomainId() + ", \"" + safeName + "\", \"" + safeDesc + "\")'><i class='fas fa-edit'></i> Edit</button> ");
                    out.println("<a href='domains?action=delete&id=" + domain.getDomainId() + "' class='action-btn delete' onclick='return confirm(\"Delete this domain?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
            out.println("</tbody></table>");
            

        } else {
            request.setAttribute("domains", domains);
            request.getRequestDispatcher("/admin-domains.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String domainIdStr = request.getParameter("domainId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String isActiveStr = request.getParameter("isActive");
        boolean isActive = "true".equals(isActiveStr);
        String iconUrl = null;
        
        // Handle file upload
        try {
            Part filePart = request.getPart("iconImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String webappPath = getServletContext().getRealPath("/");
                File uploadsDir = new File(webappPath, "uploads/domains");
                if (!uploadsDir.exists()) uploadsDir.mkdirs();
                
                File targetFile = new File(uploadsDir, fileName);
                try (java.io.InputStream input = filePart.getInputStream();
                     java.io.FileOutputStream output = new java.io.FileOutputStream(targetFile)) {
                    input.transferTo(output);
                }
                iconUrl = request.getContextPath() + "/uploads/domains/" + fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if (name == null || name.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Domain name is required");
            return;
        }
        
        boolean success = false;
        if (domainIdStr != null && !domainIdStr.isEmpty()) {
            // Update existing domain
            int domainId = Integer.parseInt(domainIdStr);
            Domain domain = new Domain(name.trim(), description != null ? description.trim() : "");
            domain.setDomainId(domainId);
            if (iconUrl != null) domain.setIconUrl(iconUrl);
            domain.setActive(isActive);
            success = domainBean.updateDomain(domain);
        } else {
            // Add new domain
            Domain domain = new Domain(name.trim(), description != null ? description.trim() : "");
            if (iconUrl != null) domain.setIconUrl(iconUrl);
            domain.setActive(isActive);
            success = domainBean.addDomain(domain);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}