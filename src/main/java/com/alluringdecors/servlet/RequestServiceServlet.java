package com.alluringdecors.servlet;

import com.alluringdecors.bean.ServiceRequestBean;
import com.alluringdecors.model.ServiceRequest;
import com.alluringdecors.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/request-service")
public class RequestServiceServlet extends HttpServlet {
    private ServiceRequestBean serviceRequestBean = new ServiceRequestBean();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        if (user == null) {
            String returnUrl = request.getRequestURL().toString();
            if (request.getQueryString() != null) {
                returnUrl += "?" + request.getQueryString();
            }
            response.sendRedirect("login?returnUrl=" + java.net.URLEncoder.encode(returnUrl, "UTF-8"));
            return;
        }
        
        request.setAttribute("loggedInUser", user);
        String domain = request.getParameter("domain");
        request.setAttribute("selectedDomain", domain);
        request.getRequestDispatcher("/request-service.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        if (user == null) {
            response.sendRedirect("login?error=Please login to request a service");
            return;
        }
        
        String domain = request.getParameter("domain");
        String description = request.getParameter("description");

        ServiceRequest serviceRequest = new ServiceRequest();
        serviceRequest.setUserId(user.getUserId());
        serviceRequest.setName(user.getFullName());
        serviceRequest.setEmail(user.getEmail());
        serviceRequest.setPhone(user.getPhone());
        serviceRequest.setDomain(domain);
        serviceRequest.setDescription(description);
        serviceRequest.setRemarks(""); // Empty remarks for client requests

        if (serviceRequestBean.createServiceRequest(serviceRequest)) {
            response.sendRedirect("home?success=Service request submitted successfully");
        } else {
            request.setAttribute("error", "Failed to submit request");
            request.setAttribute("loggedInUser", user);
            request.setAttribute("selectedDomain", domain);
            request.getRequestDispatcher("/request-service.jsp").forward(request, response);
        }
    }
}