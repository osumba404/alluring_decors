<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Icon Test - Alluring Decors</title>
    <link rel="stylesheet" href="css/icons-new.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div style="padding: 2rem; max-width: 800px; margin: 0 auto;">
        <h1>Icon System Test</h1>
        
        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin: 2rem 0;">
            <div style="padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                <h3>Navigation Icons</h3>
                <p><i class="fas fa-home"></i> Home</p>
                <p><i class="fas fa-user"></i> User</p>
                <p><i class="fas fa-cog"></i> Settings</p>
                <p><i class="fas fa-sign-out-alt"></i> Logout</p>
            </div>
            
            <div style="padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                <h3>Action Icons</h3>
                <p><i class="fas fa-plus"></i> Add</p>
                <p><i class="fas fa-edit"></i> Edit</p>
                <p><i class="fas fa-trash"></i> Delete</p>
                <p><i class="fas fa-eye"></i> View</p>
            </div>
            
            <div style="padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                <h3>Communication</h3>
                <p><i class="fas fa-phone"></i> Phone</p>
                <p><i class="fas fa-envelope"></i> Email</p>
                <p><i class="fas fa-comment"></i> Comment</p>
                <p><i class="fas fa-paper-plane"></i> Send</p>
            </div>
            
            <div style="padding: 1rem; border: 1px solid #ddd; border-radius: 8px;">
                <h3>Status Icons</h3>
                <p><i class="fas fa-check-circle"></i> Success</p>
                <p><i class="fas fa-times-circle"></i> Error</p>
                <p><i class="fas fa-exclamation-triangle"></i> Warning</p>
                <p><i class="fas fa-info-circle"></i> Info</p>
            </div>
        </div>
        
        <div style="margin: 2rem 0;">
            <h3>Icon Sizes</h3>
            <p><i class="fas fa-star fa-xs"></i> Extra Small</p>
            <p><i class="fas fa-star fa-sm"></i> Small</p>
            <p><i class="fas fa-star"></i> Normal</p>
            <p><i class="fas fa-star fa-lg"></i> Large</p>
            <p><i class="fas fa-star fa-xl"></i> Extra Large</p>
            <p><i class="fas fa-star fa-2x"></i> 2x</p>
        </div>
        
        <div style="margin: 2rem 0;">
            <h3>Colored Icons</h3>
            <p><i class="fas fa-heart icon-primary"></i> Primary Color</p>
            <p><i class="fas fa-heart icon-accent"></i> Accent Color</p>
            <p><i class="fas fa-heart icon-success"></i> Success Color</p>
            <p><i class="fas fa-heart icon-warning"></i> Warning Color</p>
            <p><i class="fas fa-heart icon-danger"></i> Danger Color</p>
        </div>
        
        <a href="index.jsp" style="display: inline-block; margin-top: 2rem; padding: 1rem 2rem; background: var(--primary); color: white; text-decoration: none; border-radius: 8px;">
            <i class="fas fa-arrow-left"></i> Back to Home
        </a>
    </div>
</body>
</html>