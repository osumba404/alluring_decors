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
            response.sendRedirect("users");
            return;
        }
        
        List<User> users = userBean.getAllUsers();
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Users</h1>" +
                "<p class='dashboard-subtitle'>View and manage registered users</p></div></div>" +
                "<table class='admin-table'><thead><tr><th>ID</th><th>Username</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Actions</th></tr></thead><tbody>"
            );
            if (users.isEmpty()) {
                response.getWriter().println("<tr><td colspan='7' style='text-align:center; padding: 2rem; color: #666;'>No users found.</td></tr>");
            } else {
                for (User user : users) {
                    String roleBadge = "";
                    if ("admin".equalsIgnoreCase(user.getRole())) {
                        roleBadge = "<span style='background: linear-gradient(135deg, #D4A017 0%, #f4c430 100%); color: #164e31; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>Admin</span>";
                    } else {
                        roleBadge = "<span style='background: #e9ecef; color: #495057; padding: 4px 12px; border-radius: 12px; font-weight: 600; font-size: 0.85rem;'>User</span>";
                    }
                    response.getWriter().println(
                        "<tr><td>" + user.getUserId() + "</td><td><strong>" + user.getUsername() + "</strong></td><td>" + user.getFullName() + 
                        "</td><td>" + user.getEmail() + "</td><td>" + user.getPhone() + "</td><td>" + roleBadge + 
                        "</td><td><button class='action-btn view' onclick=\"openModal('User Details', '" +
                        "<div class=\\\"form-group\\\"><label>User ID:</label><input type=\\\"text\\\" value=\\\"" + user.getUserId() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Username:</label><input type=\\\"text\\\" value=\\\"" + user.getUsername() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Full Name:</label><input type=\\\"text\\\" value=\\\"" + user.getFullName() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Email:</label><input type=\\\"email\\\" value=\\\"" + user.getEmail() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Phone:</label><input type=\\\"text\\\" value=\\\"" + user.getPhone() + "\\\" readonly></div>" +
                        "<div class=\\\"form-group\\\"><label>Role:</label><input type=\\\"text\\\" value=\\\"" + user.getRole() + "\\\" readonly></div>')\"><i class='fas fa-eye'></i> View</button> " +
                        "<a href='users?action=delete&id=" + user.getUserId() + "' class='action-btn delete' onclick='return confirm(\"Delete this user?\")' style='text-decoration:none'><i class='fas fa-trash'></i> Delete</a></td></tr>"
                    );
                }
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        }
    }
}