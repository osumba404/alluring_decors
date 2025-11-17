package com.alluringdecors.bean;

import com.alluringdecors.model.Payment;
import com.alluringdecors.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentBean {
    
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, b.bill_number, sr.client_name, sr.request_code " +
                    "FROM payments p " +
                    "JOIN bills b ON p.bill_id = b.bill_id " +
                    "JOIN service_requests sr ON b.request_id = sr.request_id " +
                    "ORDER BY p.paid_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                payments.add(mapResultSetToPayment(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    public boolean recordPayment(Payment payment) {
        String insertSql = "INSERT INTO payments (bill_id, amount, method, notes) VALUES (?, ?, ?, ?)";
        String checkSql = "SELECT b.total_amount, COALESCE(SUM(p.amount), 0) as total_paid FROM bills b LEFT JOIN payments p ON b.bill_id = p.bill_id WHERE b.bill_id = ? GROUP BY b.bill_id, b.total_amount";
        String updateBillSql = "UPDATE bills SET is_paid = 1 WHERE bill_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            conn.setAutoCommit(false);
            
            // Insert payment
            try (PreparedStatement stmt = conn.prepareStatement(insertSql)) {
                stmt.setInt(1, payment.getBillId());
                stmt.setBigDecimal(2, payment.getAmount());
                stmt.setString(3, payment.getMethod() != null ? payment.getMethod() : "Cash");
                stmt.setString(4, payment.getNotes());
                stmt.executeUpdate();
            }
            
            // Check if bill is fully paid
            try (PreparedStatement stmt = conn.prepareStatement(checkSql)) {
                stmt.setInt(1, payment.getBillId());
                ResultSet rs = stmt.executeQuery();
                
                if (rs.next()) {
                    double billAmount = rs.getDouble("total_amount");
                    double totalPaid = rs.getDouble("total_paid") + payment.getAmount().doubleValue();
                    
                    if (totalPaid >= billAmount) {
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateBillSql)) {
                            updateStmt.setInt(1, payment.getBillId());
                            updateStmt.executeUpdate();
                        }
                    }
                }
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("payment_id"));
        payment.setBillId(rs.getInt("bill_id"));
        payment.setAmount(rs.getBigDecimal("amount"));
        payment.setMethod(rs.getString("method"));
        payment.setReferenceNo(rs.getString("reference_no"));
        payment.setReceiptUrl(rs.getString("receipt_url"));
        payment.setNotes(rs.getString("notes"));
        payment.setRecordedBy(rs.getInt("recorded_by"));
        
        Timestamp paidAt = rs.getTimestamp("paid_at");
        if (paidAt != null) {
            payment.setPaidAt(paidAt.toLocalDateTime());
        }
        
        payment.setBillNumber(rs.getString("bill_number"));
        payment.setClientName(rs.getString("client_name"));
        payment.setRequestCode(rs.getString("request_code"));
        
        return payment;
    }
}