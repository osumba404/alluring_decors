package com.alluringdecors.model;

public class Contact {
    private int contactId;
    private String label;
    private String address;
    private String phone;
    private String email;
    private String mapUrl;
    private boolean isPrimary;
    private boolean isActive;
    
    public Contact() {}
    
    // Getters and Setters
    public int getContactId() { return contactId; }
    public void setContactId(int contactId) { this.contactId = contactId; }
    
    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getMapUrl() { return mapUrl; }
    public void setMapUrl(String mapUrl) { this.mapUrl = mapUrl; }
    
    public boolean isPrimary() { return isPrimary; }
    public void setPrimary(boolean primary) { isPrimary = primary; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}