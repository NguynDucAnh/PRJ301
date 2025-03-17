<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="dto.Project"%>
<%
    String keyword = request.getParameter("keyword");
    List<Project> projects = (keyword != null) ? ProjectDAO.searchProjects(keyword) : null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Projects</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        table { width: 80%; margin: auto; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        .search-box { margin: 20px auto; width: 50%; }
        input, button { padding: 10px; }
    </style>
</head>
<body>
    <h2>Search Startup Projects</h2>
    <div class="search-box">
        <form action="searchProjects.jsp" method="get">
            <input type="text" name="keyword" placeholder="Enter project name" required>
            <button type="submit">Search</button>
        </form>
    </div>

    <% if (projects != null) { %>
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
    <% } %>
    
    <a href="dashboard.jsp" class="back">🔙 Back to Dashboard</a>
</body>
</html>
