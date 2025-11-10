package com.alluringdecors.bean;

import com.alluringdecors.model.Project;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectBean {
    
    public List<Project> getProjectsByCategory(String category) {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects WHERE category = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, category);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                projects.add(mapResultSetToProject(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }
    
    public List<Project> getUpcomingProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects WHERE start_date > CURDATE() AND (end_date IS NULL OR end_date > CURDATE()) ORDER BY start_date ASC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                projects.add(mapResultSetToProject(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }
    
    public List<Project> getOngoingProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects WHERE (start_date IS NULL OR start_date <= CURDATE()) AND (end_date IS NULL OR end_date > CURDATE()) ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                projects.add(mapResultSetToProject(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }
    
    public List<Project> getAccomplishedProjects() {
        List<Project> projects = new ArrayList<>();
        String sql = "SELECT * FROM projects WHERE end_date IS NOT NULL AND end_date <= CURDATE() ORDER BY end_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                projects.add(mapResultSetToProject(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }
    
    public Project getProjectById(int projectId) {
        String sql = "SELECT * FROM projects WHERE project_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, projectId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToProject(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addProject(Project project) {
        String sql = "INSERT INTO projects (title, short_description, full_description, category, client_name, location, start_date, end_date, thumbnail_url, is_featured) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, project.getTitle());
            stmt.setString(2, project.getShortDescription());
            stmt.setString(3, project.getFullDescription());
            stmt.setString(4, project.getCategory());
            stmt.setString(5, project.getClientName());
            stmt.setString(6, project.getLocation());
            stmt.setDate(7, project.getStartDate() != null ? Date.valueOf(project.getStartDate()) : null);
            stmt.setDate(8, project.getEndDate() != null ? Date.valueOf(project.getEndDate()) : null);
            stmt.setString(9, project.getThumbnailUrl());
            stmt.setBoolean(10, project.isFeatured());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateProject(Project project) {
        String sql = "UPDATE projects SET title = ?, short_description = ?, full_description = ?, category = ?, client_name = ?, location = ?, start_date = ?, end_date = ?, thumbnail_url = ?, is_featured = ? WHERE project_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, project.getTitle());
            stmt.setString(2, project.getShortDescription());
            stmt.setString(3, project.getFullDescription());
            stmt.setString(4, project.getCategory());
            stmt.setString(5, project.getClientName());
            stmt.setString(6, project.getLocation());
            stmt.setDate(7, project.getStartDate() != null ? Date.valueOf(project.getStartDate()) : null);
            stmt.setDate(8, project.getEndDate() != null ? Date.valueOf(project.getEndDate()) : null);
            stmt.setString(9, project.getThumbnailUrl());
            stmt.setBoolean(10, project.isFeatured());
            stmt.setInt(11, project.getProjectId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteProject(int projectId) {
        String sql = "DELETE FROM projects WHERE project_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, projectId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Project mapResultSetToProject(ResultSet rs) throws SQLException {
        Project project = new Project();
        project.setProjectId(rs.getInt("project_id"));
        project.setTitle(rs.getString("title"));
        project.setShortDescription(rs.getString("short_description"));
        project.setFullDescription(rs.getString("full_description"));
        project.setCategory(rs.getString("category"));
        project.setClientName(rs.getString("client_name"));
        project.setLocation(rs.getString("location"));
        
        Date startDate = rs.getDate("start_date");
        if (startDate != null) {
            project.setStartDate(startDate.toLocalDate());
        }
        
        Date endDate = rs.getDate("end_date");
        if (endDate != null) {
            project.setEndDate(endDate.toLocalDate());
        }
        
        project.setThumbnailUrl(rs.getString("thumbnail_url"));
        project.setFeatured(rs.getBoolean("is_featured"));
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            project.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            project.setUpdatedAt(updatedAt.toLocalDateTime());
        }
        
        return project;
    }
}