package com.alluringdecors.bean;

import com.alluringdecors.model.Faq;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FaqBean {
    
    public List<Faq> getAllFaqs() {
        List<Faq> faqs = new ArrayList<>();
        String sql = "SELECT * FROM faqs WHERE is_active = 1 ORDER BY display_order, faq_id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                faqs.add(mapResultSetToFaq(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return faqs;
    }
    
    public boolean addFaq(Faq faq) {
        String sql = "INSERT INTO faqs (question, answer, display_order) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, faq.getQuestion());
            stmt.setString(2, faq.getAnswer());
            stmt.setInt(3, faq.getDisplayOrder());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteFaq(int faqId) {
        String sql = "UPDATE faqs SET is_active = 0 WHERE faq_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, faqId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Faq mapResultSetToFaq(ResultSet rs) throws SQLException {
        Faq faq = new Faq();
        faq.setFaqId(rs.getInt("faq_id"));
        faq.setQuestion(rs.getString("question"));
        faq.setAnswer(rs.getString("answer"));
        faq.setDisplayOrder(rs.getInt("display_order"));
        faq.setActive(rs.getBoolean("is_active"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            faq.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            faq.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return faq;
    }
}