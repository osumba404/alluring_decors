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

@WebServlet("/admin/faqs")
public class AdminFaqsServlet extends HttpServlet {
    
    private FaqBean faqBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        faqBean = new FaqBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int faqId = Integer.parseInt(request.getParameter("id"));
            faqBean.deleteFaq(faqId);
            response.sendRedirect("faqs");
            return;
        }
        
        List<Faq> faqs = faqBean.getAllFaqs();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>Manage FAQs</h1></div>" +
                "<div class='auth-form' style='max-width: 700px; margin-bottom: 3rem;'>" +
                "<h3>Add New FAQ</h3><form method='post' action='faqs'>" +
                "<div class='form-group'><label>Question:</label><input type='text' name='question' required></div>" +
                "<div class='form-group'><label>Answer:</label><textarea name='answer' rows='4' required></textarea></div>" +
                "<div class='form-group'><label>Display Order:</label><input type='number' name='displayOrder' value='0' required></div>" +
                "<button type='submit' class='btn-primary'>Add FAQ</button></form></div>" +
                "<h3>Existing FAQs</h3><table><thead><tr><th>ID</th><th>Question</th><th>Answer</th><th>Order</th><th>Actions</th></tr></thead><tbody>"
            );
            if (faqs.isEmpty()) {
                response.getWriter().println("<tr><td colspan='5'>No FAQs available. Add some FAQs to get started.</td></tr>");
            } else {
                for (Faq faq : faqs) {
                    String answer = faq.getAnswer().length() > 50 ? faq.getAnswer().substring(0, 50) + "..." : faq.getAnswer();
                    response.getWriter().println(
                        "<tr><td>" + faq.getFaqId() + "</td><td>" + faq.getQuestion() + "</td><td>" + answer + 
                        "</td><td>" + faq.getDisplayOrder() + "</td><td><a href='faqs?action=delete&id=" + faq.getFaqId() + 
                        "' onclick='return confirm(\"Delete this FAQ?\")'>Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("faqs", faqs);
            request.getRequestDispatcher("/admin-faqs.jsp").forward(request, response);
        }
    }
}