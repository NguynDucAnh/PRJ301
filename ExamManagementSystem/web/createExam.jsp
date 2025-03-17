<%-- 
    Document   : createExam
    Created on : Mar 17, 2025, 12:38:25 AM
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
    // Ensure only instructors can access this page
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("Instructor")) {
        response.sendRedirect("dashboard.jsp");
    }
%>

<form action="CreateExamServlet" method="post">
    <label>Exam Title:</label>
    <input type="text" name="exam_title" required />

    <label>Subject:</label>
    <input type="text" name="subject" required />

    <label>Category:</label>
    <select name="category_id">
        <%
            Connection con = DBConnection.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM tblExamCategories");
            while (rs.next()) {
        %>
            <option value="<%= rs.getInt("category_id") %>">
                <%= rs.getString("category_name") %>
            </option>
        <% } %>
    </select>

    <label>Total Marks:</label>
    <input type="number" name="total_marks" required />

    <label>Duration (minutes):</label>
    <input type="number" name="duration" required />

    <button type="submit">Create Exam</button>
</form>

    </body>
</html>
