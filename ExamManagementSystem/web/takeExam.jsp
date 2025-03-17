<%@ page import="java.sql.*" %>
<%@ page import="util.DBConnection" %>

<%
    int examId = Integer.parseInt(request.getParameter("exam_id"));
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM tblQuestions WHERE exam_id = ?");
    ps.setInt(1, examId);
    ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Take Exam</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            width: 50%;
            margin: 20px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        fieldset {
            border: 1px solid #ccc;
            padding: 10px;
            margin-bottom: 15px;
            text-align: left;
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
    <h2>Exam Questions</h2>

    <form action="SubmitExamServlet" method="post">
        <input type="hidden" name="exam_id" value="<%= examId %>">

        <% while (rs.next()) { %>
            <fieldset>
                <legend><%= rs.getString("question_text") %></legend>
                <input type="radio" name="q_<%= rs.getInt("question_id") %>" value="A"> <%= rs.getString("option_a") %><br>
                <input type="radio" name="q_<%= rs.getInt("question_id") %>" value="B"> <%= rs.getString("option_b") %><br>
                <input type="radio" name="q_<%= rs.getInt("question_id") %>" value="C"> <%= rs.getString("option_c") %><br>
                <input type="radio" name="q_<%= rs.getInt("question_id") %>" value="D"> <%= rs.getString("option_d") %><br>
            </fieldset>
        <% } con.close(); %>

        <button type="submit">Submit Exam</button>
    </form>
</div>

</body>
</html>
