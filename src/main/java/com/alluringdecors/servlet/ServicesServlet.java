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

@WebServlet("/services")
public class ServicesServlet extends HttpServlet {
    
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
        
        List<Service> services = serviceBean.getAllServices();
        List<Domain> domains = domainBean.getAllActiveDomains();
        
        request.setAttribute("services", services);
        request.setAttribute("domains", domains);
        
        request.getRequestDispatcher("/services.jsp").forward(request, response);
    }
}