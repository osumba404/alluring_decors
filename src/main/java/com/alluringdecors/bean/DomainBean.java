package com.alluringdecors.bean;

import com.alluringdecors.model.Domain;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DomainBean {
    
    public List<Domain> getAllActiveDomains() {
        List<Domain> domains = new ArrayList<>();
        String sql = "SELECT * FROM domains WHERE is_active = 1 ORDER BY name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                domains.add(mapResultSetToDomain(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return domains;
    }
    
    public Domain getDomainById(int domainId) {
        String sql = "SELECT * FROM domains WHERE domain_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, domainId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToDomain(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean addDomain(Domain domain) {
        String sql = "INSERT INTO domains (name, description, icon_url, is_active) VALUES (?, ?, ?, 1)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, domain.getName());
            stmt.setString(2, domain.getDescription());
            stmt.setString(3, domain.getIconUrl());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateDomain(Domain domain) {
        String sql = "UPDATE domains SET name = ?, description = ?, icon_url = ?, is_active = ? WHERE domain_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, domain.getName());
            stmt.setString(2, domain.getDescription());
            stmt.setString(3, domain.getIconUrl());
            stmt.setBoolean(4, domain.isActive());
            stmt.setInt(5, domain.getDomainId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteDomain(int domainId) {
        String sql = "UPDATE domains SET is_active = 0 WHERE domain_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, domainId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Domain mapResultSetToDomain(ResultSet rs) throws SQLException {
        Domain domain = new Domain();
        domain.setDomainId(rs.getInt("domain_id"));
        domain.setName(rs.getString("name"));
        domain.setDescription(rs.getString("description"));
        domain.setIconUrl(rs.getString("icon_url"));
        domain.setActive(rs.getBoolean("is_active"));
        return domain;
    }
}