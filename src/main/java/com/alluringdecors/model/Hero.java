package com.alluringdecors.model;

public class Hero {
    private int heroId;
    private String title;
    private String subtitle;
    private String bodyText;
    private String backgroundImage;
    private String primaryButton;
    private String primaryButtonLink;
    private String secondaryButton;
    private String secondaryButtonLink;
    private int displayOrder;
    private boolean isActive;

    public Hero() {}

    public Hero(String title, String subtitle, String bodyText, String backgroundImage) {
        this.title = title;
        this.subtitle = subtitle;
        this.bodyText = bodyText;
        this.backgroundImage = backgroundImage;
        this.isActive = true;
    }

    // Getters and Setters
    public int getHeroId() { return heroId; }
    public void setHeroId(int heroId) { this.heroId = heroId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getSubtitle() { return subtitle; }
    public void setSubtitle(String subtitle) { this.subtitle = subtitle; }

    public String getBodyText() { return bodyText; }
    public void setBodyText(String bodyText) { this.bodyText = bodyText; }

    public String getBackgroundImage() { return backgroundImage; }
    public void setBackgroundImage(String backgroundImage) { this.backgroundImage = backgroundImage; }

    public String getPrimaryButton() { return primaryButton; }
    public void setPrimaryButton(String primaryButton) { this.primaryButton = primaryButton; }

    public String getPrimaryButtonLink() { return primaryButtonLink; }
    public void setPrimaryButtonLink(String primaryButtonLink) { this.primaryButtonLink = primaryButtonLink; }

    public String getSecondaryButton() { return secondaryButton; }
    public void setSecondaryButton(String secondaryButton) { this.secondaryButton = secondaryButton; }

    public String getSecondaryButtonLink() { return secondaryButtonLink; }
    public void setSecondaryButtonLink(String secondaryButtonLink) { this.secondaryButtonLink = secondaryButtonLink; }

    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
}