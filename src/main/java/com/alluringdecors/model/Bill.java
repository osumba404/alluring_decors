package com.alluringdecors.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Bill {
    private int billId;
    private int requestId;
    private String billNumber;
    private BigDecimal totalAmount;
    private BigDecimal areaSqft;
    private BigDecimal ratePerSqft;
    private String description;
    private LocalDateTime billDate;
    private String status;
    
    // Service request details for display
    private String clientName;
    private String requestCode;
    private String serviceDomain;
    
    public Bill() {}
    
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    
    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }
    
    public String getBillNumber() { return billNumber; }
    public void setBillNumber(String billNumber) { this.billNumber = billNumber; }
    
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    
    public BigDecimal getAreaSqft() { return areaSqft; }
    public void setAreaSqft(BigDecimal areaSqft) { this.areaSqft = areaSqft; }
    
    public BigDecimal getRatePerSqft() { return ratePerSqft; }
    public void setRatePerSqft(BigDecimal ratePerSqft) { this.ratePerSqft = ratePerSqft; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public LocalDateTime getBillDate() { return billDate; }
    public void setBillDate(LocalDateTime billDate) { this.billDate = billDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }
    
    public String getRequestCode() { return requestCode; }
    public void setRequestCode(String requestCode) { this.requestCode = requestCode; }
    
    public String getServiceDomain() { return serviceDomain; }
    public void setServiceDomain(String serviceDomain) { this.serviceDomain = serviceDomain; }
}