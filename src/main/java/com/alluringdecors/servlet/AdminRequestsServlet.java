package com.alluringdecors.servlet;

import com.alluringdecors.bean.ServiceRequestBean;
import com.alluringdecors.model.ServiceRequest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/admin/requests")
public class AdminRequestsServlet extends HttpServlet {
    
    private ServiceRequestBean requestBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        requestBean = new ServiceRequestBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("approve".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            requestBean.updateRequestStatus(requestId, 3); // Accepted status
            response.sendRedirect("requests");
            return;
        } else if ("reject".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            requestBean.updateRequestStatus(requestId, 2); // Rejected status
            response.sendRedirect("requests");
            return;
        }
        
        List<ServiceRequest> allRequests = requestBean.getAllRequests();
        List<ServiceRequest> pendingRequests = allRequests.stream().filter(r -> r.getStatusId() == 1).collect(Collectors.toList());
        List<ServiceRequest> completedRequests = allRequests.stream().filter(r -> r.getStatusId() >= 5).collect(Collectors.toList());
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>Service Requests</h1></div>" +
                "<h3>Pending Requests</h3><table style='margin-bottom: 3rem;'><thead><tr><th>ID</th><th>Client</th><th>Code</th><th>Location</th><th>Area</th><th>Status</th><th>Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (pendingRequests.isEmpty()) {
                response.getWriter().println("<tr><td colspan='8'>No pending requests.</td></tr>");
            } else {
                for (ServiceRequest req : pendingRequests) {
                    String date = req.getRequestedAt() != null ? req.getRequestedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
                    response.getWriter().println(
                        "<tr><td>" + req.getRequestId() + "</td><td>" + req.getClientName() + "</td><td>" + req.getRequestCode() + 
                        "</td><td>" + req.getLocation() + "</td><td>" + req.getAreaSqft() + "</td><td>" + req.getStatusName() + 
                        "</td><td>" + date + "</td><td><a href='requests?action=approve&id=" + req.getRequestId() + 
                        "'>Approve</a> | <a href='requests?action=reject&id=" + req.getRequestId() + 
                        "' onclick='return confirm(\"Reject this request?\")'>Reject</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table><h3>Completed Requests</h3><table><thead><tr><th>ID</th><th>Client</th><th>Code</th><th>Status</th><th>Date</th></tr></thead><tbody>");
            if (completedRequests.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5'>No completed requests.</td></tr>");
            } else {
                for (ServiceRequest req : completedRequests) {
                    String date = req.getRequestedAt() != null ? req.getRequestedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
                    response.getWriter().println(
                        "<tr><td>" + req.getRequestId() + "</td><td>" + req.getClientName() + "</td><td>" + req.getRequestCode() + 
                        "</td><td>" + req.getStatusName() + "</td><td>" + date + "</td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("requests", allRequests);
            request.getRequestDispatcher("/admin-requests.jsp").forward(request, response);
        }
    }
}