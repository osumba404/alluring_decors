package com.alluringdecors.servlet;

import com.alluringdecors.bean.ServiceBean;
import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.model.Service;
import com.alluringdecors.model.Domain;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/admin/add-service")
public class AdminAddServiceServlet extends HttpServlet {
    private ServiceBean serviceBean = new ServiceBean();
    private DomainBean domainBean = new DomainBean();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Load domains for dropdown
        List<Domain> domains = domainBean.getAllDomains();
        request.setAttribute("domains", domains);
        
        // Check if editing existing service
        String serviceIdParam = request.getParameter("id");
        if (serviceIdParam != null) {
            try {
                int serviceId = Integer.parseInt(serviceIdParam);
                Service service = serviceBean.getServiceById(serviceId);
                request.setAttribute("service", service);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid service ID");
            }
        }
        
        request.getRequestDispatcher("/admin-add-service.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Get form parameters
            String serviceIdParam = request.getParameter("serviceId");
            int domainId = Integer.parseInt(request.getParameter("domainId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String basePriceStr = request.getParameter("basePrice");
            BigDecimal pricePerSqft = new BigDecimal(request.getParameter("pricePerSqft"));
            String unit = request.getParameter("unit");
            boolean isActive = "true".equals(request.getParameter("isActive"));
            
            // Handle optional base price
            BigDecimal basePrice = null;
            if (basePriceStr != null && !basePriceStr.trim().isEmpty()) {
                basePrice = new BigDecimal(basePriceStr);
            }
            

            
            Service service = new Service();
            service.setDomainId(domainId);
            service.setName(name);
            service.setDescription(description);
            service.setBasePrice(basePrice);
            service.setPricePerSqft(pricePerSqft);
            service.setUnit(unit);

            service.setActive(isActive);
            
            boolean success;
            if (serviceIdParam != null && !serviceIdParam.isEmpty()) {
                // Update existing service
                service.setServiceId(Integer.parseInt(serviceIdParam));
                success = serviceBean.updateService(service);
            } else {
                // Create new service
                success = serviceBean.createService(service);
            }
            
            if (success) {
                request.setAttribute("success", "Service " + (serviceIdParam != null ? "updated" : "created") + " successfully!");
            } else {
                request.setAttribute("error", "Failed to " + (serviceIdParam != null ? "update" : "create") + " service");
            }
            
        } catch (Exception e) {
            request.setAttribute("error", "Error processing service: " + e.getMessage());
        }
        
        // Reload form with domains
        List<Domain> domains = domainBean.getAllDomains();
        request.setAttribute("domains", domains);
        request.getRequestDispatcher("/admin-add-service.jsp").forward(request, response);
    }
    

}