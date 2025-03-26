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
        body { 
            font-family: Arial, sans-serif; 
            background-color: #f4f4f4; 
            text-align: center; 
        }
        .container { 
            width: 80%; 
            margin: 50px auto; 
            padding: 20px; 
            background: white; 
            border-radius: 10px; 
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1); 
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            background: white; 
            border-radius: 10px; 
            overflow: hidden; 
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1); 
        }
        th, td { 
            padding: 12px; 
            border: 1px solid #ddd; 
            text-align: center; 
        }
        th { 
            background: #007BFF; 
            color: white; 
        }
        tr:nth-child(even) { 
            background: #f9f9f9; 
        }
        select, button { 
            padding: 8px; 
            border-radius: 5px; 
            border: 1px solid #ccc; 
        }
        button { 
            background: #007BFF; 
            color: white; 
            border: none; 
            cursor: pointer; 
            font-size: 14px;
        }
        button:hover { background: #0056b3; }
        .back {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back:hover { background: #218838; }
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
