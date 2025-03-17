<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProjectDAO"%>
<%@page import="dto.Project"%>
<%
    List<Project> projects = ProjectDAO.getAllProjects();
%>
<%@page import="dto.User"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;

    if (user == null || !"Founder".equals(user.getRole())) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Project Status</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; }
        table { width: 80%; margin: auto; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 10px; text-align: center; }
        select, button { padding: 5px; }
    </style>
</head>
<body>
    <h2>Update Project Status</h2>
    <table>
        <tr>
            <th>Project Name</th>
            <th>Description</th>
            <th>Current Status</th>
            <th>Update Status</th>
        </tr>
        <% for (Project p : projects) { %>
        <tr>
            <td><%= p.getProjectName() %></td>
            <td><%= p.getDescription() %></td>
            <td><%= p.getStatus() %></td>
            <td>
                <form action="UpdateProjectServlet" method="post">
                    <input type="hidden" name="projectId" value="<%= p.getProjectId() %>">
                    <select name="status">
                        <option value="Ideation">Ideation</option>
                        <option value="Development">Development</option>
                        <option value="Launch">Launch</option>
                        <option value="Scaling">Scaling</option>
                    </select>
                    <button type="submit">Update</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    
    <a href="dashboard.jsp" class="back">🔙 Back to Dashboard</a>
</body>
</html>
