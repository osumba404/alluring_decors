package com.alluringdecors.servlet;

import com.alluringdecors.bean.ContentBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/content")
public class AdminContentServlet extends HttpServlet {
    
    private ContentBean contentBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        contentBean = new ContentBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String ajax = request.getParameter("ajax");
        Map<String, String> content = contentBean.getAllContent();
        
        String homeContent = content.getOrDefault("home_center", "Welcome to Alluring Decors");
        String aboutContent = content.getOrDefault("about_us", "About Alluring Decors content");
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            
            out.println("<div class='dashboard-header'>");
            out.println("<div><h1 class='dashboard-title'>Manage Content</h1></div>");
            out.println("<button class='header-action-btn' onclick='showAddContentForm()'><i class='fas fa-plus'></i> Add Content</button>");
            out.println("</div>");
            
            out.println("<table class='admin-table'>");
            out.println("<thead><tr><th>Section Key</th><th>Title</th><th>Content Preview</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            
            // Display existing content sections
            for (Map.Entry<String, String> entry : content.entrySet()) {
                String key = entry.getKey();
                String contentText = entry.getValue();
                String preview = contentText.length() > 100 ? contentText.substring(0, 100) + "..." : contentText;
                String title = key.replace("_", " ").toUpperCase();
                String safeContent = contentText.replace("\"", "&quot;");
                
                out.println("<tr>");
                out.println("<td>" + key + "</td>");
                out.println("<td>" + title + "</td>");
                out.println("<td>" + preview + "</td>");
                out.println("<td>");
                out.println("<button class='action-btn' onclick='showEditContentForm(\"" + key + "\", \"" + key + "\", \"" + safeContent + "\")'><i class='fas fa-edit'></i> Edit</button>");
                out.println("</td>");
                out.println("</tr>");
            }
            
            out.println("</tbody></table>");
        } else {
            request.setAttribute("content", content);
            request.getRequestDispatcher("/admin-content.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String sectionKey = request.getParameter("sectionKey");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        
        System.out.println("=== CONTENT FORM DEBUG ===");
        System.out.println("sectionKey: " + sectionKey);
        System.out.println("title: " + title);
        System.out.println("content: " + content);
        
        if (sectionKey == null || sectionKey.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Section key is required");
            return;
        }
        
        boolean success = false;
        if (sectionKey != null && content != null) {
            // Check if it's an update (existing section) or add new
            Map<String, String> existingContent = contentBean.getAllContent();
            if (existingContent.containsKey(sectionKey)) {
                success = contentBean.updateContent(sectionKey, content);
                System.out.println("Update result: " + success);
            } else {
                success = contentBean.addContent(sectionKey, title != null ? title : sectionKey, content);
                System.out.println("Add result: " + success);
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
    }
}