<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) sessionObj.getAttribute("username");
    String role = (String) sessionObj.getAttribute("role");
%>

<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        h2 {
            color: #333;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            display: inline;
            margin: 10px;
        }
        a {
            text-decoration: none;
            padding: 10px 15px;
            background: #007bff;
            color: white;
            border-radius: 5px;
        }
        a:hover {
            background: #0056b3;
        }
    </style>
</head>
<body>
    <h2>Welcome, <%= username %>!</h2>
    <p>You are logged in as a <b><%= role %></b></p>

    <h3>Navigation</h3>
    <ul>
        <% if ("Instructor".equals(role)) { %>
            <li><a href="manageCategories.jsp">Manage Exam Categories</a></li>
            <li><a href="manageExams.jsp">Manage Exams</a></li>
            <li><a href="viewResults.jsp">View Student Results</a></li>
        <% } else { %>
            <li><a href="takeExam.jsp">Take an Exam</a></li>
        <% } %>
        <li><a href="LogoutServlet">Logout</a></li>
    </ul>
</body>
</html>
