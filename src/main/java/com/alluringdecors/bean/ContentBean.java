package com.alluringdecors.bean;

import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;

public class ContentBean {
    
    public Map<String, String> getAllContent() {
        Map<String, String> content = new HashMap<>();
        String sql = "SELECT section_key, content FROM content_sections WHERE is_active = 1";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                content.put(rs.getString("section_key"), rs.getString("content"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return content;
    }
    
    public boolean updateContent(String sectionKey, String content) {
        String sql = "UPDATE content_sections SET content = ? WHERE section_key = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, content);
            stmt.setString(2, sectionKey);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean addContent(String sectionKey, String title, String content) {
        String sql = "INSERT INTO content_sections (section_key, title, content) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, sectionKey);
            stmt.setString(2, title);
            stmt.setString(3, content);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public String getContentByKey(String sectionKey) {
        String sql = "SELECT content FROM content_sections WHERE section_key = ? AND is_active = 1";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, sectionKey);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("content");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}