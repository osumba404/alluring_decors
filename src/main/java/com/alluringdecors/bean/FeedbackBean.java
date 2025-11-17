package com.alluringdecors.bean;

import com.alluringdecors.model.Feedback;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackBean {
    
    public List<Feedback> getAllFeedback() {
        List<Feedback> feedbacks = new ArrayList<>();
        String sql = "SELECT * FROM feedbacks ORDER BY submitted_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                feedbacks.add(mapResultSetToFeedback(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
    
    public boolean submitFeedback(Feedback feedback) {
        String sql = "INSERT INTO feedbacks (user_id, name, email, message, type) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setObject(1, feedback.getUserId());
            stmt.setString(2, feedback.getName());
            stmt.setString(3, feedback.getEmail());
            stmt.setString(4, feedback.getMessage());
            stmt.setString(5, feedback.getType());
            
            int result = stmt.executeUpdate();
            System.out.println("Feedback insert result: " + result);
            return result > 0;
        } catch (SQLException e) {
            System.err.println("Error submitting feedback: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    public Feedback getFeedbackById(int feedbackId) {
        String sql = "SELECT * FROM feedbacks WHERE feedback_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedbackId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToFeedback(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean deleteFeedback(int feedbackId) {
        String sql = "DELETE FROM feedbacks WHERE feedback_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, feedbackId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Feedback mapResultSetToFeedback(ResultSet rs) throws SQLException {
        Feedback feedback = new Feedback();
        feedback.setFeedbackId(rs.getInt("feedback_id"));
        feedback.setUserId(rs.getObject("user_id", Integer.class));
        feedback.setName(rs.getString("name"));
        feedback.setEmail(rs.getString("email"));
        feedback.setMessage(rs.getString("message"));
        feedback.setType(rs.getString("type"));
        feedback.setRead(rs.getBoolean("is_read"));
        
        Timestamp submittedAt = rs.getTimestamp("submitted_at");
        if (submittedAt != null) {
            feedback.setSubmittedAt(submittedAt.toLocalDateTime());
        }
        
        return feedback;
    }
}