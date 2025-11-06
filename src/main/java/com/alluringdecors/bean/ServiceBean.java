package com.alluringdecors.bean;

import com.alluringdecors.model.Service;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceBean {
    
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE is_active = 1 ORDER BY name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                services.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }
    
    public boolean addService(Service service) {
        String sql = "INSERT INTO services (domain_id, name, description, base_price, price_per_sqft, unit) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, service.getDomainId());
            stmt.setString(2, service.getName());
            stmt.setString(3, service.getDescription());
            stmt.setBigDecimal(4, service.getBasePrice());
            stmt.setBigDecimal(5, service.getPricePerSqft());
            stmt.setString(6, service.getUnit());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateService(Service service) {
        String sql = "UPDATE services SET name = ?, description = ?, price_per_sqft = ? WHERE service_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, service.getName());
            stmt.setString(2, service.getDescription());
            stmt.setBigDecimal(3, service.getPricePerSqft());
            stmt.setInt(4, service.getServiceId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteService(int serviceId) {
        String sql = "UPDATE services SET is_active = 0 WHERE service_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serviceId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Service mapResultSetToService(ResultSet rs) throws SQLException {
        Service service = new Service();
        service.setServiceId(rs.getInt("service_id"));
        service.setDomainId(rs.getInt("domain_id"));
        service.setName(rs.getString("name"));
        service.setDescription(rs.getString("description"));
        service.setBasePrice(rs.getBigDecimal("base_price"));
        service.setPricePerSqft(rs.getBigDecimal("price_per_sqft"));
        service.setUnit(rs.getString("unit"));
        service.setActive(rs.getBoolean("is_active"));
        return service;
    }
}