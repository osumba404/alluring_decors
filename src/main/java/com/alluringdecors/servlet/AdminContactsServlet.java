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

@WebServlet("/admin/contacts")
public class AdminContactsServlet extends HttpServlet {
    
    private ContactBean contactBean;
    
    @Override
    public void init() throws ServletException {
        super.init();
        contactBean = new ContactBean();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String ajax = request.getParameter("ajax");
        List<Contact> contacts = contactBean.getAllContacts();
        Contact primaryContact = contacts.isEmpty() ? new Contact() : contacts.get(0);
        
        if ("true".equals(ajax)) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println(
                "<div class='dashboard-header'><h1 class='dashboard-title'>Manage Contacts</h1></div>" +
                "<div class='auth-form' style='max-width: 600px; margin-bottom: 3rem;'>" +
                "<h3>Update Contact Information</h3><form method='post' action='contacts'>" +
                "<input type='hidden' name='contactId' value='" + primaryContact.getContactId() + "'>" +
                "<div class='form-group'><label>Phone Number:</label><input type='tel' name='phone' value='" + (primaryContact.getPhone() != null ? primaryContact.getPhone() : "") + "' required></div>" +
                "<div class='form-group'><label>Email Address:</label><input type='email' name='email' value='" + (primaryContact.getEmail() != null ? primaryContact.getEmail() : "") + "' required></div>" +
                "<div class='form-group'><label>Address:</label><textarea name='address' rows='3' required>" + (primaryContact.getAddress() != null ? primaryContact.getAddress() : "") + "</textarea></div>" +
                "<button type='submit' class='btn-primary'>Update Contact Info</button></form></div>"
            );
        } else {
            request.setAttribute("contacts", contacts);
            request.getRequestDispatcher("/admin-contacts.jsp").forward(request, response);
        }
    }
}