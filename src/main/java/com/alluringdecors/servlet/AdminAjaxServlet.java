package com.alluringdecors.servlet;

import com.alluringdecors.bean.UserBean;
import com.alluringdecors.bean.ProjectBean;
import com.alluringdecors.bean.DomainBean;
import com.alluringdecors.model.User;
import com.alluringdecors.model.Project;
import com.alluringdecors.model.Domain;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/admin/ajax/*")
public class AdminAjaxServlet extends HttpServlet {
    
    private UserBean userBean;
    private ProjectBean projectBean;
    private DomainBean domainBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userBean = new UserBean();
        projectBean = new ProjectBean();
        domainBean = new DomainBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String pathInfo = request.getPathInfo();
        
        if ("/users".equals(pathInfo)) {
            generateUsersContent(out);
        } else if ("/projects".equals(pathInfo)) {
            generateProjectsContent(out);
        } else if ("/domains".equals(pathInfo)) {
            generateDomainsContent(out);
        } else {
            out.println("<h1>Section not found</h1>");
        }
    }
    
    private void generateUsersContent(PrintWriter out) {
        List<User> users = userBean.getAllUsers();
        
        out.println("<div class=\"dashboard-header\">");
        out.println("<h1 class=\"dashboard-title\">Manage Users</h1>");
        out.println("</div>");
        
        out.println("<table>");
        out.println("<thead><tr><th>ID</th><th>Username</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Actions</th></tr></thead>");
        out.println("<tbody>");
        
        for (User user : users) {
            out.println("<tr>");
            out.println("<td>" + user.getUserId() + "</td>");
            out.println("<td>" + user.getUsername() + "</td>");
            out.println("<td>" + user.getFullName() + "</td>");
            out.println("<td>" + user.getEmail() + "</td>");
            out.println("<td>" + user.getPhone() + "</td>");
            out.println("<td>" + user.getRole() + "</td>");
            out.println("<td><a href=\"users?action=delete&id=" + user.getUserId() + "\" onclick=\"return confirm('Delete this user?')\">Delete</a></td>");
            out.println("</tr>");
        }
        
        out.println("</tbody></table>");
    }
    
    private void generateProjectsContent(PrintWriter out) {
        List<Project> ongoingProjects = projectBean.getProjectsByCategory("ongoing");
        List<Project> accomplishedProjects = projectBean.getProjectsByCategory("accomplished");
        
        out.println("<div class=\"dashboard-header\">");
        out.println("<h1 class=\"dashboard-title\">Manage Projects</h1>");
        out.println("</div>");
        
        out.println("<div class=\"auth-form\" style=\"max-width: 600px; margin-bottom: 3rem;\">");
        out.println("<h3>Add New Project</h3>");
        out.println("<form method=\"post\" action=\"projects\">");
        out.println("<div class=\"form-group\"><label>Title:</label><input type=\"text\" name=\"title\" required></div>");
        out.println("<div class=\"form-group\"><label>Short Description:</label><textarea name=\"shortDescription\" rows=\"2\" required></textarea></div>");
        out.println("<div class=\"form-group\"><label>Category:</label><select name=\"category\" required><option value=\"ongoing\">Ongoing</option><option value=\"upcoming\">Upcoming</option><option value=\"accomplished\">Accomplished</option></select></div>");
        out.println("<div class=\"form-group\"><label>Client Name:</label><input type=\"text\" name=\"clientName\"></div>");
        out.println("<div class=\"form-group\"><label>Location:</label><input type=\"text\" name=\"location\"></div>");
        out.println("<button type=\"submit\" class=\"btn-primary\">Add Project</button>");
        out.println("</form></div>");
        
        out.println("<h3>Ongoing Projects</h3>");
        out.println("<table style=\"margin-bottom: 3rem;\"><thead><tr><th>Title</th><th>Client</th><th>Location</th><th>Actions</th></tr></thead><tbody>");
        for (Project project : ongoingProjects) {
            out.println("<tr><td>" + project.getTitle() + "</td><td>" + project.getClientName() + "</td><td>" + project.getLocation() + "</td><td><a href=\"projects?action=delete&id=" + project.getProjectId() + "\" onclick=\"return confirm('Delete this project?')\">Delete</a></td></tr>");
        }
        out.println("</tbody></table>");
    }
    
    private void generateDomainsContent(PrintWriter out) {
        List<Domain> domains = domainBean.getAllActiveDomains();
        
        out.println("<div class=\"dashboard-header\">");
        out.println("<h1 class=\"dashboard-title\">Manage Service Domains</h1>");
        out.println("</div>");
        
        out.println("<div class=\"auth-form\" style=\"max-width: 600px; margin-bottom: 3rem;\">");
        out.println("<h3>Add New Domain</h3>");
        out.println("<form method=\"post\" action=\"domains\">");
        out.println("<div class=\"form-group\"><label>Domain Name:</label><input type=\"text\" name=\"name\" required></div>");
        out.println("<div class=\"form-group\"><label>Description:</label><textarea name=\"description\" rows=\"3\" required></textarea></div>");
        out.println("<button type=\"submit\" class=\"btn-primary\">Add Domain</button>");
        out.println("</form></div>");
        
        out.println("<h3>Existing Domains</h3>");
        out.println("<table><thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Actions</th></tr></thead><tbody>");
        for (Domain domain : domains) {
            out.println("<tr><td>" + domain.getDomainId() + "</td><td>" + domain.getName() + "</td><td>" + domain.getDescription() + "</td><td><a href=\"domains?action=delete&id=" + domain.getDomainId() + "\" onclick=\"return confirm('Delete this domain?')\">Delete</a></td></tr>");
        }
        out.println("</tbody></table>");
    }
}