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
import java.util.List;

@WebServlet("/client/dashboard")
public class ClientDashboardServlet extends HttpServlet {
    private ServiceRequestBean serviceRequestBean = new ServiceRequestBean();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        List<ServiceRequest> userRequests = serviceRequestBean.getUserRequests(user.getUserId());
        
        int pendingCount = 0, ongoingCount = 0, completedCount = 0;
        double totalBilled = 0.0, totalPaid = 0.0, balanceDue = 0.0;
        int pendingPayments = 0;
        
        for (ServiceRequest req : userRequests) {
            String status = req.getStatusName().toLowerCase();
            if (status.contains("pending")) pendingCount++;
            else if (status.contains("progress") || status.contains("ongoing") || status.contains("accepted")) ongoingCount++;
            else if (status.contains("completed")) completedCount++;
        }
        
        // Mock billing data - replace with actual billing logic
        totalBilled = completedCount * 150000.0; // Average KES 150,000 per project
        totalPaid = completedCount * 120000.0;   // 80% payment rate
        balanceDue = totalBilled - totalPaid;
        pendingPayments = (int) (balanceDue / 30000); // Assuming KES 30,000 average pending payment
        
        request.setAttribute("userRequests", userRequests);
        request.setAttribute("pendingCount", pendingCount);
        request.setAttribute("ongoingCount", ongoingCount);
        request.setAttribute("completedCount", completedCount);
        request.setAttribute("totalBilled", String.format("%.2f", totalBilled));
        request.setAttribute("totalPaid", String.format("%.2f", totalPaid));
        request.setAttribute("balanceDue", String.format("%.2f", balanceDue));
        request.setAttribute("pendingPayments", pendingPayments);
        
        request.getRequestDispatcher("/client-dashboard.jsp").forward(request, response);
    }
}