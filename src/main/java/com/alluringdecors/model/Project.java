package com.alluringdecors.model;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Project {
    private int projectId;
    private String title;
    private String shortDescription;
    private String fullDescription;
    private String category;
    private String clientName;
    private String location;
    private LocalDate startDate;
    private LocalDate endDate;
    private String thumbnailUrl;
    private boolean isFeatured;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    public Project() {}
    
    public Project(String title, String shortDescription, String fullDescription, String category) {
        this.title = title;
        this.shortDescription = shortDescription;
        this.fullDescription = fullDescription;
        this.category = category;
        this.isFeatured = false;
    }
    
    // Getters and Setters
    public int getProjectId() { return projectId; }
    public void setProjectId(int projectId) { this.projectId = projectId; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }
    
    public String getFullDescription() { return fullDescription; }
    public void setFullDescription(String fullDescription) { this.fullDescription = fullDescription; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    
    public String getThumbnailUrl() { return thumbnailUrl; }
    public void setThumbnailUrl(String thumbnailUrl) { this.thumbnailUrl = thumbnailUrl; }
    
    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    
    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}