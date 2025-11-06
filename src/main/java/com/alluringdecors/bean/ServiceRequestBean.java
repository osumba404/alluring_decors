package com.alluringdecors.bean;

import com.alluringdecors.model.ServiceRequest;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiceRequestBean {
    
    public List<ServiceRequest> getAllRequests() {
        List<ServiceRequest> requests = new ArrayList<>();
        String sql = "SELECT sr.*, s.name as status_name, u.full_name as client_name " +
                    "FROM service_requests sr " +
                    "JOIN statuses s ON sr.status_id = s.status_id " +
                    "JOIN users u ON sr.user_id = u.user_id " +
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
        request.setClientName(rs.getString("client_name"));
        
        Timestamp requestedAt = rs.getTimestamp("requested_at");
        if (requestedAt != null) {
            request.setRequestedAt(requestedAt.toLocalDateTime());
        }
        
        return request;
    }
}