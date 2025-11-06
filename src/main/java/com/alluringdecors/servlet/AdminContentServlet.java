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
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Content</h1></div>" +
                "<button class='header-action-btn' onclick=\"openModal('Add New Content', '" +
                "<form method=\\\"post\\\" action=\\\"content\\\">" +
                "<div class=\\\"form-group\\\"><label>Section Key:</label><input type=\\\"text\\\" name=\\\"sectionKey\\\" required></div>" +
                "<div class=\\\"form-group\\\"><label>Title:</label><input type=\\\"text\\\" name=\\\"title\\\" required></div>" +
                "<div class=\\\"form-group\\\"><label>Content:</label><textarea name=\\\"content\\\" rows=\\\"6\\\" required></textarea></div>" +
                "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Add Content</button></form>')\"><i class='fas fa-plus'></i> Add Content</button></div>" +
                "<table class='admin-table'><thead><tr><th>Section Key</th><th>Title</th><th>Content Preview</th><th>Actions</th></tr></thead><tbody>"
            );
            
            // Display existing content sections
            for (Map.Entry<String, String> entry : content.entrySet()) {
                String key = entry.getKey();
                String contentText = entry.getValue();
                String preview = contentText.length() > 100 ? contentText.substring(0, 100) + "..." : contentText;
                String title = key.equals("home_center") ? "Home Center" : "About Us";
                
                response.getWriter().println(
                    "<tr><td>" + key + "</td><td>" + title + "</td><td>" + preview + "</td><td>" +
                    "<button class='action-btn' onclick=\"openModal('Edit Content - " + title + "', '" +
                    "<form method=\\\"post\\\" action=\\\"content\\\">" +
                    "<input type=\\\"hidden\\\" name=\\\"sectionKey\\\" value=\\\"" + key + "\\\">" +
                    "<div class=\\\"form-group\\\"><label>Title:</label><input type=\\\"text\\\" name=\\\"title\\\" value=\\\"" + title + "\\\" required></div>" +
                    "<div class=\\\"form-group\\\"><label>Content:</label><textarea name=\\\"content\\\" rows=\\\"8\\\" required>" + contentText.replace("\"", "&quot;") + "</textarea></div>" +
                    "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Update Content</button></form>')\"><i class='fas fa-edit'></i> Edit</button></td></tr>"
                );
            }
            
            response.getWriter().println("</tbody></table>");
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
        
        if (sectionKey != null && title != null && content != null) {
            // Check if it's an update (existing section) or add new
            Map<String, String> existingContent = contentBean.getAllContent();
            if (existingContent.containsKey(sectionKey)) {
                contentBean.updateContent(sectionKey, content);
            } else {
                contentBean.addContent(sectionKey, title, content);
            }
        }
        
        response.sendRedirect("content");
    }
}