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
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        if (!"admin".equals(currentUser.getRole())) {
            response.sendRedirect("../home");
            return;
        }
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("approve".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            requestBean.updateRequestStatusWithRemarks(requestId, 3, "Request approved by admin"); // Accepted status
            response.setStatus(200);
            return;
        } else if ("reject".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            requestBean.updateRequestStatusWithRemarks(requestId, 2, "Request rejected by admin"); // Rejected status
            response.setStatus(200);
            return;
        } else if ("delete".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            requestBean.deleteServiceRequest(requestId);
            response.setStatus(200);
            return;
        } else if ("view".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("id"));
            ServiceRequest serviceRequest = requestBean.getServiceRequestById(requestId);
            
            response.setContentType("application/json;charset=UTF-8");
            if (serviceRequest != null) {
                String json = "{" +
                    "\"requestId\":" + serviceRequest.getRequestId() + "," +
                    "\"clientName\":\"" + (serviceRequest.getClientName() != null ? serviceRequest.getClientName().replace("\"", "\\\"") : "N/A") + "\"," +
                    "\"requestCode\":\"" + (serviceRequest.getRequestCode() != null ? serviceRequest.getRequestCode() : "N/A") + "\"," +
                    "\"location\":\"" + (serviceRequest.getLocation() != null ? serviceRequest.getLocation().replace("\"", "\\\"") : "N/A") + "\"," +
                    "\"description\":\"" + (serviceRequest.getDescription() != null ? serviceRequest.getDescription().replace("\"", "\\\"") : "N/A") + "\"," +
                    "\"areaSqft\":" + (serviceRequest.getAreaSqft() != null ? serviceRequest.getAreaSqft() : 0) + "," +
                    "\"statusId\":" + serviceRequest.getStatusId() + "," +
                    "\"statusName\":\"" + (serviceRequest.getStatusName() != null ? serviceRequest.getStatusName().replace("\"", "\\\"") : "N/A") + "\"," +
                    "\"remarks\":\"" + (serviceRequest.getRemarks() != null ? serviceRequest.getRemarks().replace("\"", "\\\"") : "") + "\"," +
                    "\"requestedAt\":\"" + (serviceRequest.getRequestedAt() != null ? serviceRequest.getRequestedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "N/A") + "\"" +
                    "}";
                response.getWriter().write(json);
            } else {
                response.getWriter().write("{\"error\":\"Request not found\"}");
            }
            return;
        } else if ("getApproved".equals(action)) {
            List<ServiceRequest> approvedRequests = requestBean.getAllRequests().stream()
                .filter(r -> r.getStatusId() == 3) // Only approved requests
                .collect(Collectors.toList());
            
            response.setContentType("application/json;charset=UTF-8");
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < approvedRequests.size(); i++) {
                ServiceRequest req = approvedRequests.get(i);
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"requestId\":").append(req.getRequestId()).append(",");
                json.append("\"requestCode\":\"").append(req.getRequestCode() != null ? req.getRequestCode() : "N/A").append("\",");
                json.append("\"clientName\":\"").append(req.getClientName() != null ? req.getClientName() : "N/A").append("\",");
                json.append("\"areaSqft\":").append(req.getAreaSqft() != null ? req.getAreaSqft() : 0);
                json.append("}");
            }
            json.append("]");
            response.getWriter().write(json.toString());
            return;
        }
        
        List<ServiceRequest> allRequests = requestBean.getAllRequests();
        List<ServiceRequest> pendingRequests = allRequests.stream().filter(r -> r.getStatusId() == 1).collect(Collectors.toList());
        List<ServiceRequest> completedRequests = allRequests.stream().filter(r -> r.getStatusId() >= 5).collect(Collectors.toList());
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Service Requests</h1>" +
                "<p class='dashboard-subtitle'>View and manage customer service requests</p></div>" +
                "<button class='header-action-btn' onclick='showAddRequestForm()'><i class='fas fa-plus'></i> Add New Request</button></div>" +
                "<h3 style='color: #164e31; margin: 2rem 0 1rem 0; font-size: 1.5rem;'><i class='fas fa-list'></i> All Service Requests</h3>" +
                "<table class='admin-table' style='margin-bottom: 3rem;'><thead><tr><th>ID</th><th>Client</th><th>Code</th><th>Domain</th><th>Project Description</th><th>Area (sqft)</th><th>Status</th><th>Date</th><th>Remarks</th><th>Actions</th></tr></thead><tbody>"
            );
            if (allRequests.isEmpty()) {
                response.getWriter().println("<tr><td colspan='10' style='text-align:center; padding: 2rem; color: #666;'>No service requests found.</td></tr>");
            } else {
                for (ServiceRequest req : allRequests) {
                    String date = req.getRequestedAt() != null ? req.getRequestedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "N/A";
                    String location = req.getLocation() != null ? req.getLocation().replace("'", "\\'").replace("\"", "&quot;") : "";
                    response.getWriter().println(
                        "<tr><td>" + req.getRequestId() + "</td><td><strong>" + (req.getClientName() != null ? req.getClientName() : "N/A") + "</strong><br><small style='color: #666;'>" + (req.getEmail() != null ? req.getEmail() : "") + "</small></td><td><code style='background: #f8f9fa; padding: 4px 8px; border-radius: 4px;'>" + (req.getRequestCode() != null ? req.getRequestCode() : "N/A") + 
                        "</code></td><td>" + (req.getLocation() != null ? req.getLocation() : "N/A") + "</td><td>" + (req.getDescription() != null ? req.getDescription().substring(0, Math.min(req.getDescription().length(), 50)) + "..." : "No description") + "</td><td>" + req.getAreaSqft() + "</td><td><span style='background: #ffc107; color: #000; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>" + (req.getStatusName() != null ? req.getStatusName() : "N/A") +
                        "</span></td><td>" + date + "</td><td>" + (req.getRemarks() != null && !req.getRemarks().trim().isEmpty() ? req.getRemarks().substring(0, Math.min(req.getRemarks().length(), 50)) + "..." : "") + "</td><td>" +
                        "<button class='action-btn view' onclick=\"viewServiceRequest(" + req.getRequestId() + ")\"><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick=\"editServiceRequest(" + req.getRequestId() + ")\"><i class='fas fa-edit'></i> Edit</button> " +
                        "<button class='action-btn' style='background: linear-gradient(135deg, #17a2b8 0%, #138496 100%); color: white;' onclick=\"updateRequestStatus(" + req.getRequestId() + ")\"><i class='fas fa-sync'></i> Status</button> " +
                        "<button class='action-btn' style='background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white;' onclick=\"approveRequest(" + req.getRequestId() + ")\"><i class='fas fa-check'></i> Approve</button> " +
                        "<button class='action-btn delete' onclick=\"rejectRequest(" + req.getRequestId() + ")\"><i class='fas fa-times'></i> Reject</button> " +
                        "<button class='action-btn delete' onclick=\"deleteRequest(" + req.getRequestId() + ")\"><i class='fas fa-trash'></i> Delete</button></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("requests", allRequests);
            request.getRequestDispatcher("/admin-requests.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../login");
            return;
        }
        
        User currentUser = (User) session.getAttribute("user");
        if (!"admin".equals(currentUser.getRole())) {
            response.sendRedirect("../home");
            return;
        }
        
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            // Create new service request
            String clientName = request.getParameter("clientName");
            String clientEmail = request.getParameter("clientEmail");
            String clientPhone = request.getParameter("clientPhone");
            String domain = request.getParameter("domain");
            String description = request.getParameter("description");
            String areaSqftStr = request.getParameter("areaSqft");
            String statusIdStr = request.getParameter("statusId");
            String remarks = request.getParameter("remarks");
            
            try {
                java.math.BigDecimal areaSqft = new java.math.BigDecimal(areaSqftStr);
                int statusId = Integer.parseInt(statusIdStr);
                
                ServiceRequest newRequest = new ServiceRequest();
                newRequest.setClientName(clientName);
                newRequest.setEmail(clientEmail);
                newRequest.setPhone(clientPhone);
                newRequest.setLocation(domain);
                newRequest.setDescription(description);
                newRequest.setAreaSqft(areaSqft);
                newRequest.setStatusId(statusId);
                newRequest.setRemarks(remarks);
                
                requestBean.createServiceRequest(newRequest);
                response.sendRedirect("requests");
                
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
            }
            
        } else if ("update".equals(action)) {
            String requestIdStr = request.getParameter("requestId");
            String domain = request.getParameter("domain");
            String areaSqftStr = request.getParameter("areaSqft");
            String statusIdStr = request.getParameter("statusId");
            String remarks = request.getParameter("remarks");
            
            try {
                int requestId = Integer.parseInt(requestIdStr);
                java.math.BigDecimal areaSqft = new java.math.BigDecimal(areaSqftStr);
                int statusId = Integer.parseInt(statusIdStr);
                
                ServiceRequest existingRequest = requestBean.getServiceRequestById(requestId);
                if (existingRequest != null) {
                    existingRequest.setLocation(domain);
                    existingRequest.setAreaSqft(areaSqft);
                    existingRequest.setStatusId(statusId);
                    existingRequest.setRemarks(remarks);
                    
                    requestBean.updateServiceRequest(existingRequest);
                }
                
                response.sendRedirect("requests");
                
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
            }
        } else if ("updateRemarks".equals(action)) {
            String requestIdStr = request.getParameter("requestId");
            String remarks = request.getParameter("remarks");
            
            try {
                int requestId = Integer.parseInt(requestIdStr);
                ServiceRequest existingRequest = requestBean.getServiceRequestById(requestId);
                if (existingRequest != null) {
                    existingRequest.setRemarks(remarks);
                    requestBean.updateServiceRequest(existingRequest);
                }
                response.sendRedirect("requests");
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }
}