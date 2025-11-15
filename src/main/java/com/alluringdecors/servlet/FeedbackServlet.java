package com.alluringdecors.servlet;

import com.alluringdecors.bean.FeedbackBean;
import com.alluringdecors.model.Feedback;
import com.alluringdecors.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {
    
    private FeedbackBean feedbackBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        feedbackBean = new FeedbackBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/feedback.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");
        String type = request.getParameter("type");
        
        Feedback feedback = new Feedback();
        feedback.setUserId(user != null ? user.getUserId() : null);
        feedback.setName(name);
        feedback.setEmail(email);
        feedback.setMessage(message);
        feedback.setType(type);
        
        boolean success = feedbackBean.submitFeedback(feedback);
        
        if (success) {
            request.setAttribute("success", "Thank you for your feedback! We'll get back to you soon.");
        } else {
            request.setAttribute("error", "Failed to submit feedback. Please try again.");
        }
        
        request.getRequestDispatcher("/feedback.jsp").forward(request, response);
    }
}