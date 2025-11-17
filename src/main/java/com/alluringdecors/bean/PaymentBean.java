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
                    "ORDER BY p.created_at DESC";
        
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
        String sql = "INSERT INTO payments (bill_id, total_billed_amount, total_paid_amount, due_amount, balance_amount, date_paid, payment_method, remarks) " +
                    "SELECT ?, b.total_amount, ?, (b.total_amount - ?), " +
                    "CASE WHEN (b.total_amount - ?) <= 0 THEN 0 ELSE (b.total_amount - ?) END, ?, 'Cash', ? " +
                    "FROM bills b WHERE b.bill_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, payment.getBillId());
            stmt.setBigDecimal(2, payment.getTotalPaidAmount());
            stmt.setBigDecimal(3, payment.getTotalPaidAmount());
            stmt.setBigDecimal(4, payment.getTotalPaidAmount());
            stmt.setBigDecimal(5, payment.getTotalPaidAmount());
            stmt.setDate(6, Date.valueOf(payment.getDatePaid()));
            stmt.setString(7, payment.getRemarks());
            stmt.setInt(8, payment.getBillId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private Payment mapResultSetToPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setPaymentId(rs.getInt("payment_id"));
        payment.setBillId(rs.getInt("bill_id"));
        payment.setTotalBilledAmount(rs.getBigDecimal("total_billed_amount"));
        payment.setTotalPaidAmount(rs.getBigDecimal("total_paid_amount"));
        payment.setDueAmount(rs.getBigDecimal("due_amount"));
        payment.setBalanceAmount(rs.getBigDecimal("balance_amount"));
        payment.setPaymentMethod(rs.getString("payment_method"));
        payment.setRemarks(rs.getString("remarks"));
        
        Date datePaid = rs.getDate("date_paid");
        if (datePaid != null) {
            payment.setDatePaid(datePaid.toLocalDate());
        }
        
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            payment.setCreatedAt(createdAt.toLocalDateTime());
        }
        
        payment.setBillNumber(rs.getString("bill_number"));
        payment.setClientName(rs.getString("client_name"));
        payment.setRequestCode(rs.getString("request_code"));
        
        return payment;
    }
}