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
        
        request.setAttribute("feedbacks", feedbacks);
        
        if ("true".equals(ajax)) {
            request.getRequestDispatcher("/admin-feedback-content.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin-feedback.jsp").forward(request, response);
        }
    }
}