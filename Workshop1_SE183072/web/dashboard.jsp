<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
    /* ========== Dashboard Styles ========== */
    main {
        flex: 1;
        padding: 2rem;
        max-width: 1200px;
        margin: 0 auto;
        width: 100%;
    }

    .projects-table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
        overflow: hidden;
    }

    .projects-table th,
    .projects-table td {
        padding: 1rem;
        text-align: left;
        border-bottom: 1px solid #e2e8f0;
    }

    .projects-table th {
        background: #667eea;
        color: white;
    }

    .projects-table tr:hover {
        background: #f7fafc;
    }

    .status-badge {
        padding: 0.25rem 0.75rem;
        border-radius: 1rem;
        font-size: 0.875rem;
        font-weight: 500;
        display: inline-block;
    }

    .status-ideation { background: #c6f6d5; color: #22543d; }
    .status-development { background: #bee3f8; color: #2a4365; }
    .status-launch { background: #fed7d7; color: #742a2a; }
    .status-scaling { background: #e9d8fd; color: #44337a; }

    .action-bar {
        display: flex;
        gap: 1rem;
        margin-bottom: 2rem;
    }

    .search-form {
        flex-grow: 1;
        display: flex;
        gap: 0.5rem;
    }
</style>
</head>
<body>
    <main>
        <c:if test="${not empty success}">
            <div class="success-message">${success}</div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <c:if test="${sessionScope.user.role == 'Founder'}">
            <div class="action-bar">
                <a href="createProject.jsp" class="btn">Create New Project</a>
                <form action="MainController" method="GET" class="search-form">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="searchTerm" placeholder="Search projects..." 
                           value="${param.searchTerm}">
                    <button type="submit" class="btn">Search</button>
                </form>
            </div>
        </c:if>

        <table class="projects-table">
            <thead>
                <tr>
                    <th>Project Name</th>
                    <th>Description</th>
                    <th>Status</th>
                    <th>Estimated Launch</th>
                    <c:if test="${sessionScope.user.role == 'Founder'}">
                        <th>Actions</th>
                    </c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${projects}" var="project">
                    <tr>
                        <td>${project.projectName}</td>
                        <td>${project.description}</td>
                        <td>
                            <span class="status-badge status-${fn:toLowerCase(project.status)}">
                                ${project.status}
                            </span>
                        </td>
                        <td>${project.estimatedLaunch}</td>
                        <c:if test="${sessionScope.user.role == 'Founder'}">
                            <td>
                                <a href="updateStatus.jsp?projectId=${project.projectId}" 
                                   class="btn-action">Update Status</a>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
    <%@include file="footer.jsp" %>
</body>
</html>