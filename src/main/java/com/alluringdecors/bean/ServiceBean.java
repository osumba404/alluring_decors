package com.alluringdecors.bean;

import com.alluringdecors.model.Service;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceBean {
    
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT s.*, d.name as domain_name FROM services s LEFT JOIN domains d ON s.domain_id = d.domain_id ORDER BY s.name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Service service = mapResultSetToServiceSafe(rs);
                try {
                    service.setDomainName(rs.getString("domain_name"));
                } catch (SQLException e) {
                    // Domain name not available
                }
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }
    
    public boolean createService(Service service) {
        String sql = "INSERT INTO services (domain_id, name, description, base_price, price_per_sqft, unit, is_active) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, service.getDomainId());
            stmt.setString(2, service.getName());
            stmt.setString(3, service.getDescription());
            stmt.setBigDecimal(4, service.getBasePrice());
            stmt.setBigDecimal(5, service.getPricePerSqft());
            stmt.setString(6, service.getUnit());
            stmt.setBoolean(7, service.isActive());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean addService(Service service) {
        return createService(service);
    }
    
    public boolean updateService(Service service) {
        String sql = "UPDATE services SET domain_id = ?, name = ?, description = ?, base_price = ?, price_per_sqft = ?, unit = ?, is_active = ? WHERE service_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, service.getDomainId());
            stmt.setString(2, service.getName());
            stmt.setString(3, service.getDescription());
            stmt.setBigDecimal(4, service.getBasePrice());
            stmt.setBigDecimal(5, service.getPricePerSqft());
            stmt.setString(6, service.getUnit());
            stmt.setBoolean(7, service.isActive());
            stmt.setInt(8, service.getServiceId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Service getServiceById(int serviceId) {
        String sql = "SELECT s.*, d.name as domain_name FROM services s LEFT JOIN domains d ON s.domain_id = d.domain_id WHERE s.service_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, serviceId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Service service = mapResultSetToService(rs);
                service.setDomainName(rs.getString("domain_name"));
                return service;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
    
    public List<Service> getServicesByDomainId(int domainId) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM services WHERE domain_id = ? AND is_active = 1 ORDER BY name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, domainId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                services.add(mapResultSetToService(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
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
        service.setImageUrl(rs.getString("image_url"));
        service.setActive(rs.getBoolean("is_active"));
        return service;
    }
    
    private Service mapResultSetToServiceSafe(ResultSet rs) throws SQLException {
        Service service = new Service();
        service.setServiceId(rs.getInt("service_id"));
        service.setDomainId(rs.getInt("domain_id"));
        service.setName(rs.getString("name"));
        service.setDescription(rs.getString("description"));
        service.setBasePrice(rs.getBigDecimal("base_price"));
        service.setPricePerSqft(rs.getBigDecimal("price_per_sqft"));
        service.setUnit(rs.getString("unit"));
        
        // Safely handle image_url column that might not exist
        try {
            service.setImageUrl(rs.getString("image_url"));
        } catch (SQLException e) {
            service.setImageUrl(null);
        }
        
        service.setActive(rs.getBoolean("is_active"));
        return service;
    }
}