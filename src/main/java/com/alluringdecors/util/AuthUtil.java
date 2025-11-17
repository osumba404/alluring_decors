package com.alluringdecors.util;

import com.alluringdecors.model.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthUtil {
    
    public static boolean checkAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../login");
            return false;
        }
        return true;
    }
    
    public static boolean checkAdminRole(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (!checkAuthentication(request, response)) {
            return false;
        }
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect("../home");
            return false;
        }
        return true;
    }
    
    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }
}