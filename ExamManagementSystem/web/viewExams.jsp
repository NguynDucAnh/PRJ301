<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<!DOCTYPE html>
<html>
<head>
    <title>View Exams</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background-color: #007bff;
            color: white;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            border-radius: 5px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Available Exams</h2>
    
    <table>
        <tr>
            <th>Exam Title</th>
            <th>Subject</th>
            <th>Take Exam</th>
        </tr>

        <%
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM tblExams");

            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("exam_title") %></td>
                <td><%= rs.getString("subject") %></td>
                <td><a href="takeExam.jsp?exam_id=<%= rs.getInt("exam_id") %>">
                    <button>Start</button>
                </a></td>
            </tr>
        <% } con.close(); %>
    </table>
</div>

</body>
</html>
