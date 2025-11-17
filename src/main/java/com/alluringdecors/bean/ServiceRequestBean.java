package com.alluringdecors.bean;

import com.alluringdecors.model.ServiceRequest;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceRequestBean {
    
    public List<ServiceRequest> getAllRequests() {
        List<ServiceRequest> requests = new ArrayList<>();
        String sql = "SELECT sr.*, s.name as status_name " +
                    "FROM service_requests sr " +
                    "JOIN statuses s ON sr.status_id = s.status_id " +
                    "WHERE sr.cancelled = 0 ORDER BY sr.requested_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                requests.add(mapResultSetToServiceRequest(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public boolean createServiceRequest(ServiceRequest request) {
        String sql = "INSERT INTO service_requests (user_id, request_code, location, area_sqft, status_id, client_name, client_email, client_phone, description, remarks) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, request.getUserId() != 0 ? request.getUserId() : 1); // Default to admin user if not set
            stmt.setString(2, "REQ" + System.currentTimeMillis());
            stmt.setString(3, request.getLocation());
            stmt.setBigDecimal(4, request.getAreaSqft());
            stmt.setInt(5, request.getStatusId());
            stmt.setString(6, request.getClientName());
            stmt.setString(7, request.getEmail());
            stmt.setString(8, request.getPhone());
            stmt.setString(9, request.getDescription());
            stmt.setString(10, request.getRemarks());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateRequestStatus(int requestId, int statusId) {
        String sql = "UPDATE service_requests SET status_id = ? WHERE request_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, statusId);
            stmt.setInt(2, requestId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateServiceRequest(ServiceRequest request) {
        String sql = "UPDATE service_requests SET location = ?, area_sqft = ?, status_id = ?, remarks = ? WHERE request_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, request.getLocation());
            stmt.setBigDecimal(2, request.getAreaSqft());
            stmt.setInt(3, request.getStatusId());
            stmt.setString(4, request.getRemarks());
            stmt.setInt(5, request.getRequestId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean updateRequestStatusWithRemarks(int requestId, int statusId, String remarks) {
        String sql = "UPDATE service_requests SET status_id = ?, remarks = ? WHERE request_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, statusId);
            stmt.setString(2, remarks);
            stmt.setInt(3, requestId);
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteServiceRequest(int requestId) {
        String sql = "UPDATE service_requests SET cancelled = 1 WHERE request_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, requestId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public ServiceRequest getServiceRequestById(int requestId) {
        String sql = "SELECT sr.*, s.name as status_name " +
                    "FROM service_requests sr " +
                    "JOIN statuses s ON sr.status_id = s.status_id " +
                    "WHERE sr.request_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, requestId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToServiceRequest(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<ServiceRequest> getUserRequests(int userId) {
        List<ServiceRequest> requests = new ArrayList<>();
        String sql = "SELECT sr.*, s.name as status_name " +
                    "FROM service_requests sr " +
                    "JOIN statuses s ON sr.status_id = s.status_id " +
                    "WHERE sr.user_id = ? AND sr.cancelled = 0 ORDER BY sr.requested_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                requests.add(mapResultSetToServiceRequest(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    private ServiceRequest mapResultSetToServiceRequest(ResultSet rs) throws SQLException {
        ServiceRequest request = new ServiceRequest();
        request.setRequestId(rs.getInt("request_id"));
        request.setUserId(rs.getInt("user_id"));
        request.setRequestCode(rs.getString("request_code"));
        request.setLocation(rs.getString("location"));
        request.setAreaSqft(rs.getBigDecimal("area_sqft"));
        request.setStatusId(rs.getInt("status_id"));
        request.setStatusName(rs.getString("status_name"));
        request.setRemarks(rs.getString("remarks"));
        request.setCancelled(rs.getBoolean("cancelled"));
        
        // Set client details from direct columns
        try {
            request.setClientName(rs.getString("client_name"));
            request.setEmail(rs.getString("client_email"));
            request.setPhone(rs.getString("client_phone"));
            request.setDescription(rs.getString("description"));
        } catch (SQLException e) {
            // client fields might not be available in all queries
        }
        
        Timestamp requestedAt = rs.getTimestamp("requested_at");
        if (requestedAt != null) {
            request.setRequestedAt(requestedAt.toLocalDateTime());
        }
        
        return request;
    }
}