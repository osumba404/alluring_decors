package com.alluringdecors.bean;

import com.alluringdecors.model.Bill;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillBean {
    
    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT b.*, sr.client_name, sr.request_code, sr.location as service_domain " +
                    "FROM bills b " +
                    "JOIN service_requests sr ON b.request_id = sr.request_id " +
                    "ORDER BY b.bill_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                bills.add(mapResultSetToBill(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }
    
    public boolean createBill(Bill bill) {
        String sql = "INSERT INTO bills (request_id, bill_number, area_sqft, rate_per_sqft, total_amount, description, status) " +
                    "SELECT ?, ?, sr.area_sqft, ?, (sr.area_sqft * ?), ?, 'Generated' " +
                    "FROM service_requests sr WHERE sr.request_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String billNumber = "BILL" + System.currentTimeMillis();
            
            stmt.setInt(1, bill.getRequestId());
            stmt.setString(2, billNumber);
            stmt.setBigDecimal(3, bill.getRatePerSqft());
            stmt.setBigDecimal(4, bill.getRatePerSqft());
            stmt.setString(5, bill.getDescription());
            stmt.setInt(6, bill.getRequestId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Bill mapResultSetToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setRequestId(rs.getInt("request_id"));
        bill.setBillNumber(rs.getString("bill_number"));
        bill.setAreaSqft(rs.getBigDecimal("area_sqft"));
        bill.setRatePerSqft(rs.getBigDecimal("rate_per_sqft"));
        bill.setTotalAmount(rs.getBigDecimal("total_amount"));
        bill.setDescription(rs.getString("description"));
        bill.setStatus(rs.getString("status"));
        
        Timestamp billDate = rs.getTimestamp("bill_date");
        if (billDate != null) {
            bill.setBillDate(billDate.toLocalDateTime());
        }
        
        bill.setClientName(rs.getString("client_name"));
        bill.setRequestCode(rs.getString("request_code"));
        bill.setServiceDomain(rs.getString("service_domain"));
        
        return bill;
    }
}