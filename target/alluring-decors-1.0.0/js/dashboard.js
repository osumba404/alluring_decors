// Dashboard JavaScript Functions

function filterRequests() {
    const filter = document.getElementById('statusFilter').value;
    const cards = document.querySelectorAll('.request-card');
    
    cards.forEach(card => {
        const status = card.dataset.status;
        if (filter === 'all' || status === filter) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

function viewRequest(requestId) {
    // Open request details modal or navigate to details page
    window.location.href = `request-details?id=${requestId}`;
}

function editRequest(requestId) {
    // Navigate to edit request page
    window.location.href = `edit-request?id=${requestId}`;
}

function cancelRequest(requestId) {
    if (confirm('Are you sure you want to cancel this request?')) {
        // Send cancel request
        fetch(`cancel-request?id=${requestId}`, {
            method: 'POST'
        }).then(response => {
            if (response.ok) {
                location.reload();
            } else {
                alert('Failed to cancel request');
            }
        });
    }
}

function openEditProfile() {
    // Open edit profile modal or navigate to profile page
    window.location.href = 'edit-profile';
}

function viewBilling() {
    // Navigate to billing page
    window.location.href = 'billing';
}

function viewProjects() {
    // Navigate to projects page
    window.location.href = 'my-projects';
}

function submitFeedback() {
    // Open feedback modal or navigate to feedback page
    window.location.href = 'feedback';
}

function viewFAQs() {
    // Navigate to FAQs page
    window.location.href = 'faqs';
}

// Auto-refresh notifications every 30 seconds
setInterval(() => {
    fetch('notifications-api')
        .then(response => response.json())
        .then(data => {
            updateNotifications(data);
        })
        .catch(error => console.log('Notification update failed'));
}, 30000);

function updateNotifications(notifications) {
    const container = document.querySelector('.notifications-list');
    if (notifications.length > 0) {
        container.innerHTML = notifications.map(notif => `
            <div class="notification-item">
                <div class="notification-icon">
                    <i class="fas fa-info-circle"></i>
                </div>
                <div class="notification-content">
                    <p>${notif.message}</p>
                    <small>${notif.createdAt}</small>
                </div>
            </div>
        `).join('');
    }
}