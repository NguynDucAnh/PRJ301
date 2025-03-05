<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error - Startup Manager</title>
    <style>
        .error-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .error-heading {
            color: #e74c3c;
            margin-bottom: 1.5rem;
        }

        .error-message {
            background: #f8d7da;
            color: #721c24;
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1.5rem;
        }

        .error-details {
            background: #f3f3f3;
            padding: 1rem;
            border-radius: 4px;
            font-family: monospace;
            white-space: pre-wrap;
        }

        .back-link {
            display: inline-block;
            margin-top: 1.5rem;
            color: #3498db;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %>
    
    <main class="container">
        <div class="error-container">
            <h1 class="error-heading">⚠️ Oops! Something went wrong</h1>
            
            <c:if test="${not empty requestScope.ERROR_MESSAGE}">
                <div class="error-message">
                    ${requestScope.ERROR_MESSAGE}
                </div>
            </c:if>

            <c:if test="${not empty requestScope.ERROR_DETAILS}">
                <div class="error-details">
                    ${requestScope.ERROR_DETAILS}
                </div>
            </c:if>

            <a href="MainController?action=viewProjects" class="back-link">
                ← Return to Dashboard
            </a>
        </div>
    </main>

    <%@include file="footer.jsp" %>
</body>
</html>