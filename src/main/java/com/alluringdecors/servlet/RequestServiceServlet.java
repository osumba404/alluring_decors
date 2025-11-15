package com.alluringdecors.servlet;

import com.alluringdecors.bean.ServiceRequestBean;
import com.alluringdecors.model.ServiceRequest;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/request-service")
public class RequestServiceServlet extends HttpServlet {
    private ServiceRequestBean serviceRequestBean = new ServiceRequestBean();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String domain = request.getParameter("domain");
        request.setAttribute("selectedDomain", domain);
        request.getRequestDispatcher("/request-service.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String domain = request.getParameter("domain");
        String description = request.getParameter("description");

        ServiceRequest serviceRequest = new ServiceRequest();
        serviceRequest.setName(name);
        serviceRequest.setEmail(email);
        serviceRequest.setPhone(phone);
        serviceRequest.setDomain(domain);
        serviceRequest.setDescription(description);

        if (serviceRequestBean.createServiceRequest(serviceRequest)) {
            response.sendRedirect("index.jsp?success=true");
        } else {
            request.setAttribute("error", "Failed to submit request");
            request.getRequestDispatcher("/request-service.jsp").forward(request, response);
        }
    }
}