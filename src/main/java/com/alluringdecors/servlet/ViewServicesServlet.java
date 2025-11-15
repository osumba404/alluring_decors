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
import java.util.List;

@WebServlet("/services/view-services")
public class ViewServicesServlet extends HttpServlet {
    
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
        
        String domainIdParam = request.getParameter("domainId");
        String domainName = request.getParameter("domainName");
        
        if (domainIdParam != null) {
            int domainId = Integer.parseInt(domainIdParam);
            List<Service> services = serviceBean.getServicesByDomainId(domainId);
            Domain domain = domainBean.getDomainById(domainId);
            
            request.setAttribute("services", services);
            request.setAttribute("domain", domain);
            request.setAttribute("domainName", domainName);
        }
        
        request.getRequestDispatcher("/view-services.jsp").forward(request, response);
    }
}