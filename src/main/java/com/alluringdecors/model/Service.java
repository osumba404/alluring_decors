package com.alluringdecors.model;

import java.math.BigDecimal;

public class Service {
    private int serviceId;
    private int domainId;
    private String name;
    private String description;
    private BigDecimal basePrice;
    private BigDecimal pricePerSqft;
    private String unit;
    private boolean isActive;
    
    public Service() {}
    
    public Service(int domainId, String name, String description, BigDecimal pricePerSqft) {
        this.domainId = domainId;
        this.name = name;
        this.description = description;
        this.pricePerSqft = pricePerSqft;
        this.unit = "sqft";
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }
    
    public int getDomainId() { return domainId; }
    public void setDomainId(int domainId) { this.domainId = domainId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getBasePrice() { return basePrice; }
    public void setBasePrice(BigDecimal basePrice) { this.basePrice = basePrice; }
    
    public BigDecimal getPricePerSqft() { return pricePerSqft; }
    public void setPricePerSqft(BigDecimal pricePerSqft) { this.pricePerSqft = pricePerSqft; }
    
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}