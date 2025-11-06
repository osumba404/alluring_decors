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
            String phone = primaryContact.getPhone() != null ? primaryContact.getPhone() : "";
            String email = primaryContact.getEmail() != null ? primaryContact.getEmail() : "";
            String address = primaryContact.getAddress() != null ? primaryContact.getAddress().replace("'", "\\'").replace("\"", "&quot;") : "";
            
            response.getWriter().println(
                "<div class='dashboard-header'><div><h1 class='dashboard-title'>Manage Contacts</h1>" +
                "<p class='dashboard-subtitle'>Update contact information and addresses</p></div>" +
                "<button class='header-action-btn' onclick=\"openModal('Update Contact Information', '" +
                "<form method=\\\"post\\\" action=\\\"contacts\\\">" +
                "<input type=\\\"hidden\\\" name=\\\"contactId\\\" value=\\\"" + primaryContact.getContactId() + "\\\">" +
                "<div class=\\\"form-group\\\"><label>Phone Number:</label><input type=\\\"tel\\\" name=\\\"phone\\\" value=\\\"" + phone + "\\\" required></div>" +
                "<div class=\\\"form-group\\\"><label>Email Address:</label><input type=\\\"email\\\" name=\\\"email\\\" value=\\\"" + email + "\\\" required></div>" +
                "<div class=\\\"form-group\\\"><label>Address:</label><textarea name=\\\"address\\\" rows=\\\"3\\\" required>" + address + "</textarea></div>" +
                "<button type=\\\"submit\\\" class=\\\"btn-primary\\\">Update Contact Info</button></form>')\"><i class='fas fa-edit'></i> Edit Contact</button></div>" +
                "<div style='background: white; padding: 2rem; border-radius: 15px; box-shadow: 0 8px 25px rgba(0,0,0,0.1); margin-top: 2rem;'>" +
                "<h3 style='color: #164e31; margin-bottom: 1.5rem; font-size: 1.3rem;'><i class='fas fa-address-card'></i> Current Contact Information</h3>" +
                "<div style='display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;'>" +
                "<div style='padding: 1.5rem; background: #f8f9fa; border-radius: 12px; border-left: 4px solid #D4A017;'>" +
                "<div style='display: flex; align-items: center; margin-bottom: 0.5rem;'><i class='fas fa-phone' style='color: #D4A017; margin-right: 10px; font-size: 1.2rem;'></i><strong style='color: #164e31;'>Phone</strong></div>" +
                "<p style='margin: 0; color: #495057; font-size: 1.1rem;'>" + (phone.isEmpty() ? "Not set" : phone) + "</p></div>" +
                "<div style='padding: 1.5rem; background: #f8f9fa; border-radius: 12px; border-left: 4px solid #D4A017;'>" +
                "<div style='display: flex; align-items: center; margin-bottom: 0.5rem;'><i class='fas fa-envelope' style='color: #D4A017; margin-right: 10px; font-size: 1.2rem;'></i><strong style='color: #164e31;'>Email</strong></div>" +
                "<p style='margin: 0; color: #495057; font-size: 1.1rem;'>" + (email.isEmpty() ? "Not set" : email) + "</p></div>" +
                "<div style='padding: 1.5rem; background: #f8f9fa; border-radius: 12px; border-left: 4px solid #D4A017;'>" +
                "<div style='display: flex; align-items: center; margin-bottom: 0.5rem;'><i class='fas fa-map-marker-alt' style='color: #D4A017; margin-right: 10px; font-size: 1.2rem;'></i><strong style='color: #164e31;'>Address</strong></div>" +
                "<p style='margin: 0; color: #495057; font-size: 1.1rem;'>" + (address.isEmpty() ? "Not set" : primaryContact.getAddress()) + "</p></div>" +
                "</div></div>"
            );
        } else {
            request.setAttribute("contacts", contacts);
            request.getRequestDispatcher("/admin-contacts.jsp").forward(request, response);
        }
    }
}