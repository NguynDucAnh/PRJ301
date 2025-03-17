<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="dto.Project"%>
<%
    int pageSize = 5; // Number of projects per page
    int currentPage = 1; // Changed 'page' to 'currentPage'

    if (request.getParameter("page") != null) {
        currentPage = Integer.parseInt(request.getParameter("page"));
    }

    int start = (currentPage - 1) * pageSize;
    List<Project> projects = ProjectDAO.getProjectsByPage(start, pageSize);
    int totalProjects = ProjectDAO.getProjectCount();
    int totalPages = (int) Math.ceil((double) totalProjects / pageSize);
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Projects</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background: #f4f4f4; }
        table { width: 80%; margin: auto; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        th, td { padding: 10px; border: 1px solid #ddd; text-align: center; }
        th { background: #007BFF; color: white; }
        tr:nth-child(even) { background: #f9f9f9; }
        .pagination { margin: 20px 0; }
        .pagination a { margin: 5px; padding: 10px; background: #007BFF; color: white; text-decoration: none; border-radius: 5px; }
        .pagination a:hover { background: #0056b3; }
    </style>
</head>
<body>
    <h2>Startup Projects</h2>
    <table>
        <tr>
            <th>Project Name</th>
            <th>Description</th>
            <th>Status</th>
            <th>Estimated Launch</th>
        </tr>
        <% for (Project p : projects) { %>
        <tr>
            <td><%= p.getProjectName() %></td>
            <td><%= p.getDescription() %></td>
            <td><%= p.getStatus() %></td>
            <td><%= p.getEstimatedLaunch() %></td>
        </tr>
        <% } %>
    </table>

    <!-- Pagination -->
    <div class="pagination">
        <% if (currentPage > 1) { %>
            <a href="viewProjects.jsp?page=<%= currentPage - 1 %>">⬅ Previous</a>
        <% } %>
        
        <% for (int i = 1; i <= totalPages; i++) { %>
            <a href="viewProjects.jsp?page=<%= i %>" <% if (i == currentPage) { %> style="background: #0056b3;" <% } %>><%= i %></a>
        <% } %>

        <% if (currentPage < totalPages) { %>
            <a href="viewProjects.jsp?page=<%= currentPage + 1 %>">Next ➡</a>
        <% } %>
    </div>

    <a href="dashboard.jsp">🔙 Back to Dashboard</a>
</body>
</html>
