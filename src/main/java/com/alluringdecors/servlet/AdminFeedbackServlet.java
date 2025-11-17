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
        
        if ("view".equals(action)) {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            Feedback feedback = feedbackBean.getFeedbackById(feedbackId);
            
            response.setContentType("application/json;charset=UTF-8");
            if (feedback != null) {
                String submittedAt = feedback.getSubmittedAt() != null ? 
                    feedback.getSubmittedAt().format(DateTimeFormatter.ofPattern("MMM dd, yyyy 'at' HH:mm")) : "Unknown";
                
                response.getWriter().print("{");
                response.getWriter().print("\"feedbackId\":" + feedback.getFeedbackId() + ",");
                response.getWriter().print("\"name\":\"" + (feedback.getName() != null ? feedback.getName().replace("\"", "\\\"") : "") + "\",");
                response.getWriter().print("\"email\":\"" + (feedback.getEmail() != null ? feedback.getEmail() : "") + "\",");
                response.getWriter().print("\"type\":\"" + (feedback.getType() != null ? feedback.getType().replace("\"", "\\\"") : "") + "\",");
                response.getWriter().print("\"message\":\"" + (feedback.getMessage() != null ? feedback.getMessage().replace("\"", "\\\"").replace("\n", "\\n") : "") + "\",");
                response.getWriter().print("\"submittedAt\":\"" + submittedAt + "\"");
                response.getWriter().print("}");
            } else {
                response.getWriter().print("{}");
            }
            return;
        }
        
        if ("delete".equals(action)) {
            int feedbackId = Integer.parseInt(request.getParameter("id"));
            feedbackBean.deleteFeedback(feedbackId);
            response.sendRedirect("feedback");
            return;
        }
        
        List<Feedback> feedbacks = feedbackBean.getAllFeedback();
        
        request.setAttribute("feedbacks", feedbacks);
        
        if ("true".equals(ajax)) {
            request.getRequestDispatcher("/admin-feedback-content.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin-feedback.jsp").forward(request, response);
        }
    }
}