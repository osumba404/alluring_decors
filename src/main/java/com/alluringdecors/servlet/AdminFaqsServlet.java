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
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        List<Faq> faqs = faqBean.getAllFaqs();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            
            out.println("<div class='dashboard-header'>");
            out.println("<div><h1 class='dashboard-title'>Manage FAQs</h1></div>");
            out.println("<button class='header-action-btn' onclick='showAddFaqForm()'><i class='fas fa-plus'></i> Add FAQ</button>");
            out.println("</div>");
            
            out.println("<table class='admin-table'>");
            out.println("<thead><tr><th>ID</th><th>Question</th><th>Answer</th><th>Order</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            
            if (faqs.isEmpty()) {
                out.println("<tr><td colspan='5' style='text-align:center; padding: 2rem; color: #666;'>No FAQs available. Add some FAQs to get started.</td></tr>");
            } else {
                for (Faq faq : faqs) {
                    String answer = faq.getAnswer().length() > 50 ? faq.getAnswer().substring(0, 50) + "..." : faq.getAnswer();
                    String safeQuestion = faq.getQuestion().replace("\"", "&quot;");
                    String safeAnswer = faq.getAnswer().replace("\"", "&quot;");
                    out.println("<tr>");
                    out.println("<td>" + faq.getFaqId() + "</td>");
                    out.println("<td>" + faq.getQuestion() + "</td>");
                    out.println("<td>" + answer + "</td>");
                    out.println("<td>" + faq.getDisplayOrder() + "</td>");
                    out.println("<td>");
                    out.println("<button class='action-btn' onclick='showEditFaqForm(" + faq.getFaqId() + ", \"" + safeQuestion + "\", \"" + safeAnswer + "\", " + faq.getDisplayOrder() + ")'><i class='fas fa-edit'></i> Edit</button> ");
                    out.println("<a href='faqs?action=delete&id=" + faq.getFaqId() + "' class='action-btn delete' onclick='return confirm(\"Delete this FAQ?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
            out.println("</tbody></table>");
        } else {
            request.setAttribute("faqs", faqs);
            request.getRequestDispatcher("/admin-faqs.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("=== FAQ POST REQUEST DEBUG ===");
        System.out.println("Request Method: " + request.getMethod());
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Content Type: " + request.getContentType());
        
        // Debug all parameters
        System.out.println("All Parameters:");
        request.getParameterMap().forEach((key, values) -> {
            System.out.println("  " + key + " = " + java.util.Arrays.toString(values));
        });
        
        String faqIdStr = request.getParameter("faqId");
        String question = request.getParameter("question");
        String answer = request.getParameter("answer");
        String displayOrderStr = request.getParameter("displayOrder");
        
        System.out.println("Parsed Parameters:");
        System.out.println("  faqIdStr: '" + faqIdStr + "'");
        System.out.println("  question: '" + question + "'");
        System.out.println("  answer: '" + answer + "'");
        System.out.println("  displayOrderStr: '" + displayOrderStr + "'");
        
        // Validate required parameters
        if (question == null || question.trim().isEmpty()) {
            System.out.println("ERROR: Question is null or empty");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Question is required");
            return;
        }
        if (answer == null || answer.trim().isEmpty()) {
            System.out.println("ERROR: Answer is null or empty");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Answer is required");
            return;
        }
        
        int displayOrder = (displayOrderStr != null && !displayOrderStr.isEmpty()) ? Integer.parseInt(displayOrderStr) : 0;
        System.out.println("Display Order: " + displayOrder);
        
        Faq faq = new Faq();
        faq.setQuestion(question.trim());
        faq.setAnswer(answer.trim());
        faq.setDisplayOrder(displayOrder);
        
        boolean success = false;
        if (faqIdStr != null && !faqIdStr.isEmpty()) {
            // Update existing FAQ
            int faqId = Integer.parseInt(faqIdStr);
            faq.setFaqId(faqId);
            System.out.println("Updating FAQ with ID: " + faqId);
            success = faqBean.updateFaq(faq);
        } else {
            // Add new FAQ
            System.out.println("Adding new FAQ");
            success = faqBean.addFaq(faq);
        }
        
        System.out.println("Operation success: " + success);
        System.out.println("Redirecting to: " + request.getContextPath() + "/admin/dashboard");
        System.out.println("=== END FAQ DEBUG ===");
        
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}