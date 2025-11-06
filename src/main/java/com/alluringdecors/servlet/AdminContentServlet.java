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
                "<div class='dashboard-header'><h1 class='dashboard-title'>Edit Content</h1></div>" +
                "<div class='auth-form' style='max-width: 800px; margin-bottom: 3rem;'>" +
                "<h3>Home Page Content</h3><form method='post' action='content'>" +
                "<div class='form-group'><label>Home Center Content:</label><textarea name='homeContent' rows='6' required>" + homeContent + "</textarea></div>" +
                "<div class='form-group'><label>About Us Content:</label><textarea name='aboutContent' rows='6' required>" + aboutContent + "</textarea></div>" +
                "<button type='submit' class='btn-primary'>Update Content</button></form></div>"
            );
        } else {
            request.setAttribute("content", content);
            request.getRequestDispatcher("/admin-content.jsp").forward(request, response);
        }
    }
}