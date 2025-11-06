package com.alluringdecors.servlet;

import com.alluringdecors.bean.FeedbackBean;
import com.alluringdecors.model.Feedback;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/admin/feedback")
public class AdminFeedbackServlet extends HttpServlet {
    
    private FeedbackBean feedbackBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        feedbackBean = new FeedbackBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            feedbackBean.deleteFeedback(feedbackId);
            response.sendRedirect("feedback");
            return;
        }
        
        List<Feedback> feedbacks = feedbackBean.getAllFeedback();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>View Feedback</h1></div>" +
                "<h3>Customer Feedback</h3><table><thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Type</th><th>Message</th><th>Date</th><th>Actions</th></tr></thead><tbody>"
            );
            if (feedbacks.isEmpty()) {
                response.getWriter().println("<tr><td colspan='7'>No feedback available yet.</td></tr>");
            } else {
                for (Feedback feedback : feedbacks) {
                    String date = feedback.getSubmittedAt() != null ? feedback.getSubmittedAt().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) : "";
                    String message = feedback.getMessage().length() > 50 ? feedback.getMessage().substring(0, 50) + "..." : feedback.getMessage();
                    response.getWriter().println(
                        "<tr><td>" + feedback.getFeedbackId() + "</td><td>" + feedback.getName() + "</td><td>" + feedback.getEmail() + 
                        "</td><td>" + feedback.getType() + "</td><td>" + message + "</td><td>" + date + 
                        "</td><td><a href='feedback?action=delete&id=" + feedback.getFeedbackId() + 
                        "' onclick='return confirm(\"Delete this feedback?\")'>Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("/admin-feedback.jsp").forward(request, response);
        }
    }
}