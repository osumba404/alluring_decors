package com.alluringdecors.servlet;

import com.alluringdecors.bean.ContactBean;
import com.alluringdecors.model.Contact;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    
    private ContactBean contactBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        contactBean = new ContactBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<Contact> contacts = contactBean.getAllContacts();
        request.setAttribute("contacts", contacts);
        
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Handle contact form submission
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String projectType = request.getParameter("projectType");
        String message = request.getParameter("message");
        
        // For now, just redirect back with success message
        // In a real application, you would save this to database or send email
        request.setAttribute("successMessage", "Thank you for your message! We will contact you soon.");
        
        List<Contact> contacts = contactBean.getAllContacts();
        request.setAttribute("contacts", contacts);
        
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}