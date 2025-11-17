package com.alluringdecors.servlet;

import com.alluringdecors.bean.BillBean;
import com.alluringdecors.model.Bill;
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
    
    @Override
    public void init() throws ServletException {
        super.init();
        billBean = new BillBean();
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
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            BigDecimal totalAmount = new BigDecimal(request.getParameter("totalAmount"));
            String notes = request.getParameter("notes");
            
            Bill bill = new Bill();
            bill.setRequestId(requestId);
            bill.setTotalAmount(totalAmount);
            bill.setNotes(notes);
            
            billBean.createBill(bill);
            response.sendRedirect("bills");
        }
    }
}