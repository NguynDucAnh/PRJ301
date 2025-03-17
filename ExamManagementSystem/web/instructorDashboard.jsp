<%@ page import="dto.UserDTO" %>
<%
    UserDTO user = (UserDTO) session.getAttribute("user");
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
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .container {
            background: white;
            padding: 20px;
            width: 400px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            text-align: center;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
            margin-top: 10px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Welcome, <%= user.getName() %>!</h2>
    <p>Your role: <%= user.getRole() %></p>

    <% if (user.isInstructor()) { %>
        <a href="createExam.jsp"><button>Create New Exam</button></a>
    <% } else { %>
        <a href="viewExams.jsp"><button>Take an Exam</button></a>
    <% } %>

    <a href="LogoutServlet"><button>Logout</button></a>
</div>

</body>
</html>
