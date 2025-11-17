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
                    "ORDER BY b.generated_at DESC";
        
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
        String sql = "INSERT INTO bills (request_id, bill_number, total_amount, notes) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String billNumber = "BILL" + System.currentTimeMillis();
            
            stmt.setInt(1, bill.getRequestId());
            stmt.setString(2, billNumber);
            stmt.setBigDecimal(3, bill.getTotalAmount());
            stmt.setString(4, bill.getNotes());
            
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
        bill.setTotalAmount(rs.getBigDecimal("total_amount"));
        bill.setTaxAmount(rs.getBigDecimal("tax_amount"));
        bill.setDiscountAmount(rs.getBigDecimal("discount_amount"));
        bill.setNetAmount(rs.getBigDecimal("net_amount"));
        bill.setNotes(rs.getString("notes"));
        bill.setPaid(rs.getBoolean("is_paid"));
        
        Timestamp generatedAt = rs.getTimestamp("generated_at");
        if (generatedAt != null) {
            bill.setGeneratedAt(generatedAt.toLocalDateTime());
        }
        
        bill.setClientName(rs.getString("client_name"));
        bill.setRequestCode(rs.getString("request_code"));
        bill.setServiceDomain(rs.getString("service_domain"));
        
        return bill;
    }
}