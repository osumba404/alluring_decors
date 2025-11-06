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
            response.sendRedirect("services");
            return;
        }
        
        List<Service> services = serviceBean.getAllServices();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>Manage Services</h1>" +
                "<button class='btn-primary' onclick=\"openModal('Add New Service', '" +
                "<form method=\\\"post\\\" action=\\\"services\\\">" +
                "<div class=\\\"form-group\\\"><label>Service Name:</label><input type=\\\"text\\\" name=\\\"name\\\" required></div>" +
                "<div class=\\\"form-group\\\"><label>Description:</label><textarea name=\\\"description\\\" rows=\\\"3\\\" required></textarea></div>" +
                "<div class=\\\"form-group\\\"><label>Price per Sqft:</label><input type=\\\"number\\\" name=\\\"pricePerSqft\\\" step=\\\"0.01\\\" required></div>" +
                "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Add Service</button></form>')\">Add Service</button></div>" +
                "<h3>Services</h3><table><thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Price/Sqft</th><th>Actions</th></tr></thead><tbody>"
            );
            if (services.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5'>No services available. Add some services to get started.</td></tr>");
            } else {
                for (Service service : services) {
                    response.getWriter().println(
                        "<tr><td>" + service.getServiceId() + "</td><td>" + service.getName() + "</td><td>" + service.getDescription() + 
                        "</td><td>$" + service.getPricePerSqft() + "</td><td>" +
                        "<button onclick=\"openModal('Edit Service', '" +
                        "<form method=\\\"post\\\" action=\\\"services\\\">" +
                        "<input type=\\\"hidden\\\" name=\\\"serviceId\\\" value=\\\"" + service.getServiceId() + "\\\">" +
                        "<div class=\\\"form-group\\\"><label>Service Name:</label><input type=\\\"text\\\" name=\\\"name\\\" value=\\\"" + service.getName() + "\\\" required></div>" +
                        "<div class=\\\"form-group\\\"><label>Description:</label><textarea name=\\\"description\\\" rows=\\\"3\\\" required>" + service.getDescription() + "</textarea></div>" +
                        "<div class=\\\"form-group\\\"><label>Price per Sqft:</label><input type=\\\"number\\\" name=\\\"pricePerSqft\\\" step=\\\"0.01\\\" value=\\\"" + service.getPricePerSqft() + "\\\" required></div>" +
                        "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Update Service</button></form>')\">Edit</button> " +
                        "<a href='services?action=delete&id=" + service.getServiceId() + 
                        "' onclick='return confirm(\"Delete this service?\")'>Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("services", services);
            request.getRequestDispatcher("/admin-services.jsp").forward(request, response);
        }
    }
}