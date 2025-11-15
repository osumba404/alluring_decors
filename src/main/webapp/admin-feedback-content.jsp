<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="dashboard-header">
    <h1 class="dashboard-title">View Feedback</h1>
</div>

<table class="admin-table">
    <thead>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Type</th>
            <th>Message</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${not empty feedbacks}">
                <c:forEach var="feedback" items="${feedbacks}">
                    <tr>
                        <td>${feedback.feedbackId}</td>
                        <td>${feedback.name}</td>
                        <td>${feedback.email}</td>
                        <td>${feedback.type}</td>
                        <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            ${feedback.message}
                        </td>
                        <td>${feedback.submittedAt}</td>
                        <td>
                            <button class="action-btn view" onclick="viewFeedback('${feedback.feedbackId}', '${feedback.name}', '${feedback.email}', '${feedback.type}', '${feedback.message}', '${feedback.submittedAt}')">
                                <i class="fas fa-eye"></i> View
                            </button>
                            <a href="feedback?action=delete&id=${feedback.feedbackId}" 
                               class="action-btn delete" 
                               onclick="return confirm('Delete this feedback?')"
                               style="text-decoration: none;">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="7" style="text-align: center; padding: 2rem; color: #666;">
                        No feedback available yet.
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

<script>
function viewFeedback(id, name, email, type, message, date) {
    // Use the global openModal function if available, otherwise create our own modal
    if (typeof openModal === 'function') {
        openModal('Feedback Details', `
            <div class="form-group">
                <label>Feedback ID:</label>
                <input type="text" value="${id}" readonly>
            </div>
            <div class="form-group">
                <label>Name:</label>
                <input type="text" value="${name}" readonly>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="email" value="${email}" readonly>
            </div>
            <div class="form-group">
                <label>Type:</label>
                <input type="text" value="${type}" readonly>
            </div>
            <div class="form-group">
                <label>Date Submitted:</label>
                <input type="text" value="${date}" readonly>
            </div>
            <div class="form-group">
                <label>Message:</label>
                <textarea rows="6" readonly>${message}</textarea>
            </div>
        `);
    } else {
        // Fallback: show alert with feedback details
        alert(`Feedback Details:\n\nID: ${id}\nName: ${name}\nEmail: ${email}\nType: ${type}\nDate: ${date}\n\nMessage:\n${message}`);
    }
}
</script>