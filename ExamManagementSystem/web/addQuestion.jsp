<%-- 
    Document   : addQuestion
    Created on : Mar 17, 2025, 12:40:17 AM
    Author     : user
--%>

<%@page import="util.DBConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <%@ page import="java.sql.*" %>
<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Instructor")) {
        response.sendRedirect("dashboard.jsp");
    }

    Connection con = DBConnection.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM tblExams");
%>

<form action="AddQuestionServlet" method="post">
    <label>Select Exam:</label>
    <select name="exam_id">
        <% while (rs.next()) { %>
            <option value="<%= rs.getInt("exam_id") %>">
                <%= rs.getString("exam_title") %> - <%= rs.getString("subject") %>
            </option>
        <% } %>
    </select>

    <label>Question Text:</label>
    <textarea name="question_text" required></textarea>

    <label>Option A:</label>
    <input type="text" name="option_a" required />

    <label>Option B:</label>
    <input type="text" name="option_b" required />

    <label>Option C:</label>
    <input type="text" name="option_c" required />

    <label>Option D:</label>
    <input type="text" name="option_d" required />

    <label>Correct Answer:</label>
    <select name="correct_option">
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
        <option value="D">D</option>
    </select>

    <button type="submit">Add Question</button>
</form>

    </body>
</html>
