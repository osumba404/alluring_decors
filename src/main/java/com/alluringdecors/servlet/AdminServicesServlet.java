package com.alluringdecors.servlet;

import com.alluringdecors.bean.ServiceBean;
import com.alluringdecors.model.Service;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/services")
public class AdminServicesServlet extends HttpServlet {
    
    private ServiceBean serviceBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        serviceBean = new ServiceBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int serviceId = Integer.parseInt(request.getParameter("id"));
            serviceBean.deleteService(serviceId);
            response.sendRedirect(request.getContextPath() + "/admin/services");
            return;
        }
        
        List<Service> services = serviceBean.getAllServices();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            
            out.println("<div class='dashboard-header'>");
            out.println("<div><h1 class='dashboard-title'>Manage Services</h1></div>");
            out.println("<button class='header-action-btn' onclick='showAddServiceForm()'><i class='fas fa-plus'></i> Add Service</button>");
            out.println("</div>");
            
            out.println("<table class='admin-table'>");
            out.println("<thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Price/Sqft</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            
            if (services.isEmpty()) {
                out.println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No services available. Add some services to get started.</td></tr>");
            } else {
                for (Service service : services) {
                    String safeName = service.getName().replace("\"", "&quot;");
                    String safeDesc = service.getDescription().replace("\"", "&quot;");
                    out.println("<tr>");
                    out.println("<td>" + service.getServiceId() + "</td>");
                    out.println("<td>" + service.getName() + "</td>");
                    out.println("<td>" + service.getDescription() + "</td>");
                    out.println("<td>$" + service.getPricePerSqft() + "</td>");
                    out.println("<td>");
                    out.println("<button class='action-btn' onclick='showEditServiceForm(" + service.getServiceId() + ", \"" + safeName + "\", \"" + safeDesc + "\", " + service.getPricePerSqft() + ")'><i class='fas fa-edit'></i> Edit</button> ");
                    out.println("<a href='services?action=delete&id=" + service.getServiceId() + "' class='action-btn delete' onclick='return confirm(\"Delete this service?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
            out.println("</tbody></table>");
        } else {
            request.setAttribute("services", services);
            request.getRequestDispatcher("/admin-services.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String serviceIdStr = request.getParameter("serviceId");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        double pricePerSqft = Double.parseDouble(request.getParameter("pricePerSqft"));
        
        Service service = new Service();
        service.setName(name);
        service.setDescription(description);
        service.setPricePerSqft(java.math.BigDecimal.valueOf(pricePerSqft));
        service.setDomainId(1); // Default domain
        
        if (serviceIdStr != null && !serviceIdStr.isEmpty()) {
            // Update existing service
            int serviceId = Integer.parseInt(serviceIdStr);
            service.setServiceId(serviceId);
            serviceBean.updateService(service);
        } else {
            // Add new service
            serviceBean.addService(service);
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/services");
    }
}