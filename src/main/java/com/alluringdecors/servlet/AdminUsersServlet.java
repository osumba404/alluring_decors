package com.alluringdecors.servlet;

import com.alluringdecors.bean.UserBean;
import com.alluringdecors.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
    
    private UserBean userBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        userBean = new UserBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        
        if ("delete".equals(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            userBean.deleteUser(userId);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }
        
        List<User> users = userBean.getAllUsers();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            java.io.PrintWriter out = response.getWriter();
            
            out.println("<div class='dashboard-header'>");
            out.println("<div><h1 class='dashboard-title'>Manage Users</h1>");
            out.println("<p class='dashboard-subtitle'>View and manage registered users</p></div>");
            out.println("</div>");
            
            out.println("<table class='admin-table'>");
            out.println("<thead><tr><th>ID</th><th>Username</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Actions</th></tr></thead>");
            out.println("<tbody>");
            
            if (users.isEmpty()) {
                out.println("<tr><td colspan='7' style='text-align:center; padding: 2rem; color: #666;'>No users found.</td></tr>");
            } else {
                for (User user : users) {
                    String roleBadge = "";
                    if ("admin".equalsIgnoreCase(user.getRole())) {
                        roleBadge = "<span style='background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); color: #164e31; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>Admin</span>";
                    } else {
                        roleBadge = "<span style='background: #e9ecef; color: #495057; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>User</span>";
                    }
                    out.println("<tr>");
                    out.println("<td>" + user.getUserId() + "</td>");
                    out.println("<td><strong>" + user.getUsername() + "</strong></td>");
                    out.println("<td>" + user.getFullName() + "</td>");
                    out.println("<td>" + user.getEmail() + "</td>");
                    out.println("<td>" + user.getPhone() + "</td>");
                    out.println("<td>" + roleBadge + "</td>");
                    out.println("<td>");
                    out.println("<button class='action-btn view' onclick='showUserDetails(" + user.getUserId() + ", \"" + user.getUsername() + "\", \"" + user.getFullName() + "\", \"" + user.getEmail() + "\", \"" + user.getPhone() + "\", \"" + user.getRole() + "\")'><i class='fas fa-eye'></i> View</button> ");
                    out.println("<a href='users?action=delete&id=" + user.getUserId() + "' class='action-btn delete' onclick='return confirm(\"Delete this user?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
            out.println("</tbody></table>");
        } else {
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        }
    }
}