package com.alluringdecors.bean;

import com.alluringdecors.model.Contact;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactBean {
    
    public List<Contact> getAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        String sql = "SELECT * FROM contacts WHERE is_active = 1 ORDER BY is_primary DESC, label";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                contacts.add(mapResultSetToContact(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return contacts;
    }
    
    public boolean updateContact(Contact contact) {
        String sql = "UPDATE contacts SET address = ?, phone = ?, email = ? WHERE contact_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, contact.getAddress());
            stmt.setString(2, contact.getPhone());
            stmt.setString(3, contact.getEmail());
            stmt.setInt(4, contact.getContactId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Contact mapResultSetToContact(ResultSet rs) throws SQLException {
        Contact contact = new Contact();
        contact.setContactId(rs.getInt("contact_id"));
        contact.setLabel(rs.getString("label"));
        contact.setAddress(rs.getString("address"));
        contact.setPhone(rs.getString("phone"));
        contact.setEmail(rs.getString("email"));
        contact.setMapUrl(rs.getString("map_url"));
        contact.setPrimary(rs.getBoolean("is_primary"));
        contact.setActive(rs.getBoolean("is_active"));
        return contact;
    }
}