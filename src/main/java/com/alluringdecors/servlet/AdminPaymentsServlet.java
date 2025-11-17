package com.alluringdecors.servlet;

import com.alluringdecors.bean.PaymentBean;
import com.alluringdecors.model.Payment;
import com.alluringdecors.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/payments")
public class AdminPaymentsServlet extends HttpServlet {
    
    private PaymentBean paymentBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        paymentBean = new PaymentBean();
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
            List<Payment> payments = paymentBean.getAllPayments();
            
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Payment Details</h1>" +
                "<p class='dashboard-subtitle'>Track payments, due amounts, and balance details</p></div>" +
                "<button class='header-action-btn' onclick='showAddPaymentForm()'><i class='fas fa-plus'></i> Record Payment</button></div>" +
                "<table class='admin-table'><thead><tr><th>Payment ID</th><th>Bill Number</th><th>Client</th><th>Total Billed</th><th>Total Paid</th><th>Due Amount</th><th>Balance</th><th>Date Paid</th><th>Method</th><th>Actions</th></tr></thead><tbody>"
            );
            
            if (payments.isEmpty()) {
                response.getWriter().println("<tr><td colspan='10' style='text-align:center; padding: 2rem; color: #666;'>No payments found.</td></tr>");
            } else {
                for (Payment payment : payments) {
                    String datePaid = payment.getPaidAt() != null ? payment.getPaidAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "N/A";
                    response.getWriter().println(
                        "<tr><td>" + payment.getPaymentId() + "</td><td><code>" + payment.getBillNumber() + "</code></td>" +
                        "<td>" + (payment.getClientName() != null ? payment.getClientName() : "N/A") + "</td>" +
                        "<td>KES " + payment.getAmount() + "</td>" +
                        "<td><strong>KES " + payment.getAmount() + "</strong></td>" +
                        "<td>KES 0</td>" +
                        "<td>KES 0</td>" +
                        "<td>" + datePaid + "</td><td>" + payment.getMethod() + "</td>" +
                        "<td><button class='action-btn view' onclick='viewPayment(" + payment.getPaymentId() + ")'><i class='fas fa-eye'></i> View</button> " +
                        "<button class='action-btn' onclick='editPayment(" + payment.getPaymentId() + ")'><i class='fas fa-edit'></i> Edit</button> " +
                        "<button class='action-btn delete' onclick='deletePayment(" + payment.getPaymentId() + ")'><i class='fas fa-trash'></i> Delete</button></td></tr>"
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
            int billId = Integer.parseInt(request.getParameter("billId"));
            BigDecimal amount = new BigDecimal(request.getParameter("amount"));
            String notes = request.getParameter("notes");
            
            Payment payment = new Payment();
            payment.setBillId(billId);
            payment.setAmount(amount);
            payment.setNotes(notes);
            
            paymentBean.recordPayment(payment);
            response.sendRedirect("payments");
        }
    }
}