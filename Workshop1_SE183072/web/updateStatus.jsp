<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Status</title>
    <style>
    /* ========== Form Styles ========== */
    .form-container {
        background: white;
        padding: 2rem;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        max-width: 800px;
        margin: 2rem auto;
    }

    .form-group {
        margin-bottom: 1.5rem;
    }

    .form-group label {
        display: block;
        margin-bottom: 0.5rem;
        color: #4a5568;
        font-weight: 500;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 0.75rem;
        border: 1px solid #e2e8f0;
        border-radius: 6px;
        font-size: 1rem;
    }

    .form-group textarea {
        height: 120px;
        resize: vertical;
    }

    .error-message {
        color: #e53e3e;
        background: #fed7d7;
        padding: 1rem;
        border-radius: 6px;
        margin-bottom: 1.5rem;
    }

    .success-message {
        color: #22543d;
        background: #c6f6d5;
        padding: 1rem;
        border-radius: 6px;
        margin-bottom: 1.5rem;
    }
</style>
</head>
<body>
    <main>
        <div class="form-container">
            <h2>Update Project Status</h2>
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="updateStatus">
                <input type="hidden" name="projectId" value="${param.projectId}">
                
                <div class="form-group">
                    <label>New Status</label>
                    <select name="newStatus" required>
                        <option value="Ideation">Ideation</option>
                        <option value="Development">Development</option>
                        <option value="Launch">Launch</option>
                        <option value="Scaling">Scaling</option>
                    </select>
                </div>
                
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                
                <button type="submit" class="btn">Update Status</button>
            </form>
        </div>
    </main>
    <%@include file="footer.jsp" %>
</body>
</html>