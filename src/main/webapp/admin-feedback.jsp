<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Feedback - Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../css/fontawesome-fix.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/admin-sidebar.css">
</head>
<body>
    <div class="admin-layout">
        <main class="main-content">
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
                                   onclick="return confirm('Delete this feedback?')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </div>

    <!-- Feedback View Modal -->
    <div id="feedbackModal" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Feedback Details</h3>
                <span class="close" onclick="closeFeedbackModal()">&times;</span>
            </div>
            <div class="modal-body" id="feedbackModalBody">
                <!-- Content will be populated by JavaScript -->
            </div>
        </div>
    </div>

    <script>
        function viewFeedback(id, name, email, type, message, date) {
            const modalBody = document.getElementById('feedbackModalBody');
            modalBody.innerHTML = `
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
            `;
            document.getElementById('feedbackModal').style.display = 'block';
        }

        function closeFeedbackModal() {
            document.getElementById('feedbackModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('feedbackModal');
            if (event.target == modal) {
                closeFeedbackModal();
            }
        }
    </script>

    <style>
        .modal {
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background: rgba(22, 78, 49, 0.8);
            backdrop-filter: blur(5px);
        }
        
        .modal-content {
            background: white;
            margin: 5% auto;
            padding: 0;
            border-radius: 20px;
            width: 90%;
            max-width: 600px;
            box-shadow: 0 25px 50px rgba(22, 78, 49, 0.3);
            border: 3px solid #D4A017;
        }
        
        .modal-header {
            background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%);
            color: #D4A017;
            padding: 25px 30px;
            border-bottom: 3px solid #D4A017;
            position: relative;
        }
        
        .modal-header h3 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .close {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: #D4A017;
            font-size: 32px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: rgba(212, 160, 23, 0.1);
        }
        
        .close:hover {
            background: #D4A017;
            color: #164e31;
            transform: translateY(-50%) rotate(90deg);
        }
        
        .modal-body {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #164e31;
        }
        
        .form-group input, .form-group textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            font-size: 1rem;
            background: #f8f9fa;
            color: #6c757d;
        }
        
        .action-btn {
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 8px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .action-btn.view {
            background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%);
            color: #D4A017;
        }
        
        .action-btn.delete {
            background: linear-gradient(135deg, #dc3545 0%, #e74c3c 100%);
            color: white;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.2);
        }
        
        .admin-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .admin-table th {
            background: linear-gradient(135deg, #164e31 0%, #1a5a38 100%);
            color: #D4A017;
            padding: 18px 15px;
            text-align: left;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }
        
        .admin-table td {
            padding: 15px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .admin-table tr:hover {
            background: rgba(212, 160, 23, 0.05);
        }
    </style>
</body>
</html>