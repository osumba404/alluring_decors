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
                "<div class='dashboard-header'><h1 class='dashboard-title'>Manage Users</h1></div>" +
                "<h3>Users</h3><table><thead><tr><th>ID</th><th>Username</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Actions</th></tr></thead><tbody>"
            );
            for (User user : users) {
                response.getWriter().println(
                    "<tr><td>" + user.getUserId() + "</td><td>" + user.getUsername() + "</td><td>" + user.getFullName() + 
                    "</td><td>" + user.getEmail() + "</td><td>" + user.getPhone() + "</td><td>" + user.getRole() + 
                    "</td><td><button onclick=\"openModal('User Details', '" +
                    "<div class=\\\"form-group\\\"><label>Username:</label><input type=\\\"text\\\" value=\\\"" + user.getUsername() + "\\\" readonly></div>" +
                    "<div class=\\\"form-group\\\"><label>Full Name:</label><input type=\\\"text\\\" value=\\\"" + user.getFullName() + "\\\" readonly></div>" +
                    "<div class=\\\"form-group\\\"><label>Email:</label><input type=\\\"email\\\" value=\\\"" + user.getEmail() + "\\\" readonly></div>" +
                    "<div class=\\\"form-group\\\"><label>Phone:</label><input type=\\\"text\\\" value=\\\"" + user.getPhone() + "\\\" readonly></div>" +
                    "<div class=\\\"form-group\\\"><label>Role:</label><input type=\\\"text\\\" value=\\\"" + user.getRole() + "\\\" readonly></div>')\">View</button> " +
                    "<a href='users?action=delete&id=" + user.getUserId() + "' onclick='return confirm(\"Delete this user?\")'>Delete</a></td></tr>"
                );
            }
            response.getWriter().println("</tbody></table>");
        } else {
            request.setAttribute("users", users);
            request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
        }
    }
}