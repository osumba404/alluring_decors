package com.alluringdecors.servlet;

import com.alluringdecors.bean.BillBean;
import com.alluringdecors.bean.ServiceRequestBean;
import com.alluringdecors.model.Bill;
import com.alluringdecors.model.ServiceRequest;
import com.alluringdecors.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/bills")
public class AdminBillsServlet extends HttpServlet {
    
    private BillBean billBean;
    private ServiceRequestBean serviceRequestBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        billBean = new BillBean();
        serviceRequestBean = new ServiceRequestBean();
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
        
        String ajax = request.getParameter("ajax");
        String action = request.getParameter("action");
        
        if ("getApprovedRequests".equals(action)) {
            List<ServiceRequest> approvedRequests = serviceRequestBean.getApprovedRequests();
            System.out.println("Found " + approvedRequests.size() + " approved requests");
            
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print("[");
            
            for (int i = 0; i < approvedRequests.size(); i++) {
                ServiceRequest req = approvedRequests.get(i);
                System.out.println("Request " + i + ": ID=" + req.getRequestId() + ", Code=" + req.getRequestCode() + ", Client=" + req.getClientName());
                if (i > 0) response.getWriter().print(",");
                response.getWriter().print("{");
                response.getWriter().print("\"requestId\":" + req.getRequestId() + ",");
                response.getWriter().print("\"requestCode\":\"" + (req.getRequestCode() != null ? req.getRequestCode() : "REQ" + req.getRequestId()) + "\",");
                response.getWriter().print("\"clientName\":\"" + (req.getClientName() != null ? req.getClientName() : "Unknown Client") + "\",");
                response.getWriter().print("\"location\":\"" + (req.getLocation() != null ? req.getLocation() : "No Location") + "\",");
                response.getWriter().print("\"areaSqft\":" + (req.getAreaSqft() != null ? req.getAreaSqft() : "0"));
                response.getWriter().print("}");
            }
            
            response.getWriter().print("]");
            return;
        }
        
        if ("getBills".equals(action)) {
            List<Bill> bills = billBean.getAllBills();
            
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().print("[");
            
            for (int i = 0; i < bills.size(); i++) {
                Bill bill = bills.get(i);
                if (i > 0) response.getWriter().print(",");
                response.getWriter().print("{");
                response.getWriter().print("\"billId\":" + bill.getBillId() + ",");
                response.getWriter().print("\"billNumber\":\"" + (bill.getBillNumber() != null ? bill.getBillNumber() : "BILL" + bill.getBillId()) + "\",");
                response.getWriter().print("\"requestCode\":\"" + (bill.getRequestCode() != null ? bill.getRequestCode() : "N/A") + "\",");
                response.getWriter().print("\"clientName\":\"" + (bill.getClientName() != null ? bill.getClientName() : "Unknown Client") + "\",");
                response.getWriter().print("\"totalAmount\":" + (bill.getTotalAmount() != null ? bill.getTotalAmount() : "0"));
                response.getWriter().print("}");
            }
            
            response.getWriter().print("]");
            return;
        }
        
        if ("true".equals(ajax)) {
            List<Bill> bills = billBean.getAllBills();
            
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Bill Details</h1>" +
                "<p class='dashboard-subtitle'>Manage bills based on service requests and area</p></div>" +
                "<button class='header-action-btn' onclick='showAddBillForm()'><i class='fas fa-plus'></i> Generate Bill</button></div>" +
                "<table class='admin-table'><thead><tr><th>Bill ID</th><th>Bill Number</th><th>Client</th><th>Request Code</th><th>Area (sqft)</th><th>Rate/sqft</th><th>Total Amount</th><th>Date</th><th>Status</th><th>Actions</th></tr></thead><tbody>"
            );
            
            if (bills.isEmpty()) {
                response.getWriter().println("<tr><td colspan='10' style='text-align:center; padding: 2rem; color: #666;'>No bills found.</td></tr>");
            } else {
                for (Bill bill : bills) {
                    String date = bill.getGeneratedAt() != null ? bill.getGeneratedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "N/A";
                    response.getWriter().println(
                        "<tr><td>" + bill.getBillId() + "</td><td><code>" + bill.getBillNumber() + "</code></td>" +
                        "<td>" + (bill.getClientName() != null ? bill.getClientName() : "N/A") + "</td>" +
                        "<td>" + (bill.getRequestCode() != null ? bill.getRequestCode() : "N/A") + "</td>" +
                        "<td>N/A</td><td>N/A</td>" +
                        "<td><strong>KES " + bill.getTotalAmount() + "</strong></td><td>" + date + "</td>" +
                        "<td><span style='background: #28a745; color: white; padding: 4px 12px; border-radius: 12px; font-weight: 600;'>" + (bill.isPaid() ? "Paid" : "Pending") + "</span></td>" +
                        "<td><button class='action-btn view' onclick='viewBill(" + bill.getBillId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='editBill(" + bill.getBillId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<button class='action-btn delete' onclick='deleteBill(" + bill.getBillId() + ")'><i class='fas fa-trash'></i> Delete</button></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
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
            String requestCode = request.getParameter("requestCode");
            BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));
            String notes = request.getParameter("notes");
            
            // Get request ID from request code
            ServiceRequest serviceRequest = serviceRequestBean.getRequestByCode(requestCode);
            if (serviceRequest != null) {
                Bill bill = new Bill();
                bill.setRequestId(serviceRequest.getRequestId());
                bill.setTotalAmount(totalAmount);
                bill.setNotes(notes);
                
                billBean.createBill(bill);
            }
            response.sendRedirect("dashboard");
        }
    }
}