package com.alluringdecors.servlet;

import com.alluringdecors.bean.FaqBean;
import com.alluringdecors.model.Faq;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/faq")
public class FaqServlet extends HttpServlet {
    
    private FaqBean faqBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        faqBean = new FaqBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Faq> faqs = faqBean.getAllFaqs();
        request.setAttribute("faqs", faqs);
        
        request.getRequestDispatcher("/faq.jsp").forward(request, response);
    }
}