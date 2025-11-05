package com.alluringdecors.model;

public class Domain {
    private int domainId;
    private String name;
    private String description;
    private String iconUrl;
    private boolean isActive;
    
    public Domain() {}
    
    public Domain(String name, String description) {
        this.name = name;
        this.description = description;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getDomainId() { return domainId; }
    public void setDomainId(int domainId) { this.domainId = domainId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getIconUrl() { return iconUrl; }
    public void setIconUrl(String iconUrl) { this.iconUrl = iconUrl; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}