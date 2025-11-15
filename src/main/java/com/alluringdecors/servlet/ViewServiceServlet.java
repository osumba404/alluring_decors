package com.alluringdecors.servlet;

import com.alluringdecors.bean.ServiceBean;
import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.model.Service;
import com.alluringdecors.model.Domain;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/services/view-service")
public class ViewServiceServlet extends HttpServlet {
    
    private ServiceBean serviceBean;
    private DomainBean domainBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        serviceBean = new ServiceBean();
        domainBean = new DomainBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String serviceIdParam = request.getParameter("serviceId");
        
        if (serviceIdParam != null) {
            int serviceId = Integer.parseInt(serviceIdParam);
            Service service = serviceBean.getServiceById(serviceId);
            
            if (service != null) {
                Domain domain = domainBean.getDomainById(service.getDomainId());
                request.setAttribute("service", service);
                request.setAttribute("domain", domain);
            }
        }
        
        request.getRequestDispatcher("/view-service.jsp").forward(request, response);
    }
}