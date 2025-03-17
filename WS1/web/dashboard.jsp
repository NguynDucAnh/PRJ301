<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.User"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    HttpSession sessionObj = request.getSession(false);
    User user = (sessionObj != null) ? (User) sessionObj.getAttribute("user") : null;

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; background-color: #f4f4f4; }
        .container { margin: 50px auto; width: 50%; padding: 20px; background: white; border-radius: 10px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; }
        .nav-links { margin: 20px 0; }
        a { text-decoration: none; margin: 10px; padding: 10px 20px; background: #007BFF; color: white; border-radius: 5px; display: inline-block; }
        a:hover { background: #0056b3; }
        .logout { background: #dc3545; }
        .logout:hover { background: #b02a37; }
    </style>
</head>
<body>
    <div class="container">
        <h2>Welcome, <%= user.getName() %>!</h2>
        <p>Your Role: <b><%= user.getRole() %></b></p>
        <div class="nav-links">
            <a href="viewProjects.jsp">📜 View Projects</a>
            <a href="addProject.jsp">➕ Add Project</a>
            <a href="updateProjectStatus.jsp">✏️ Update Status</a>
            <a href="searchProjects.jsp">🔍 Search Projects</a>
        </div>
        <a href="LogoutServlet" class="logout">🚪 Logout</a>
    </div>
</body>
</html>
