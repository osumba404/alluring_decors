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
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Service Requests</h1>" +
                "<p class='dashboard-subtitle'>View and manage customer service requests</p></div></div>" +
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-clock'></i> Pending Requests</h3>" +
                "<table class='admin-table' style='margin-bottom: 3rem;'><thead><tr><th>ID</th><th>Client</th><th>Code</th><th>Location</th><th>Area (sqft)</th><th>Status</th><th>Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (pendingRequests.isEmpty()) {
                response.getWriter().println("<tr><td colspan='8' style='text-align:center; padding: 2rem; color: #666;'>No pending requests.</td></tr>");
            } else {
                for (ServiceRequest req : pendingRequests) {
                    String date = req.getRequestedAt() != null ? req.getRequestedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "N/A";
                    String location = req.getLocation() != null ? req.getLocation().replace("'", "\\'").replace("\"", "&quot;") : "";
                    response.getWriter().println(
                        "<tr><td>" + req.getRequestId() + "</td><td><strong>" + req.getClientName() + "</strong></td><td><code style='background: #f8f9fa; padding: 4px 8px; border-radius: 4px;'>" + req.getRequestCode() + 
                        "</code></td><td>" + req.getLocation() + "</td><td>" + req.getAreaSqft() + "</td><td><span style='background: #ffc107; color: #000; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>" + req.getStatusName() + 
                        "</span></td><td>" + date + "</td><td><button class='action-btn view' onclick=\"viewServiceRequest(" + req.getRequestId() + 
                        ", '" + req.getClientName().replace("'", "\\'") + "', '" + req.getRequestCode() + "', '" + location + "', " + req.getAreaSqft() + 
                        ", '" + req.getStatusName() + "', '" + date + "')\"><i class='fas fa-eye'></i> View</button> " +
                        "<a href='requests?action=approve&id=" + req.getRequestId() + 
                        "' class='action-btn' style='background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; text-decoration:none'><i class='fas fa-check'></i> Approve</a> " +
                        "<a href='requests?action=reject&id=" + req.getRequestId() + 
                        "' class='action-btn delete' onclick='return confirm(\"Reject this request?\")' style='text-decoration:none'><i class='fas fa-times'></i> Reject</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>" +
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-check-circle'></i> Completed Requests</h3>" +
                "<table class='admin-table'><thead><tr><th>ID</th><th>Client</th><th>Code</th><th>Status</th><th>Date</th></tr></thead><tbody>");
            if (completedRequests.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No completed requests.</td></tr>");
            } else {
                for (ServiceRequest req : completedRequests) {
                    String date = req.getRequestedAt() != null ? req.getRequestedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "N/A";
                    String statusColor = req.getStatusId() == 5 ? "#28a745" : "#6c757d";
                    response.getWriter().println(
                        "<tr><td>" + req.getRequestId() + "</td><td><strong>" + req.getClientName() + "</strong></td><td><code style='background: #f8f9fa; padding: 4px 8px; border-radius: 4px;'>" + req.getRequestCode() + 
                        "</code></td><td><span style='background: " + statusColor + "; color: white; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>" + req.getStatusName() + "</span></td><td>" + date + "</td></tr>"
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