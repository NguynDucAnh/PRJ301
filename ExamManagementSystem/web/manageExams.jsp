<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<html>
<head>
    <title>Manage Exams</title>
</head>
<body>
    <h2>Create New Exam</h2>
    <form action="ExamServlet" method="post">
        <input type="hidden" name="action" value="add">
        Title: <input type="text" name="exam_title" required><br>
        Subject: <input type="text" name="subject" required><br>
        Category:
        <select name="category_id" required>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "SELECT * FROM tblExamCategories";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
            %>
            <option value="<%= rs.getInt("category_id") %>"><%= rs.getString("category_name") %></option>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </select><br>
        Total Marks: <input type="number" name="total_marks" required><br>
        Duration (minutes): <input type="number" name="duration" required><br>
        <input type="submit" value="Create New Exam">
    </form>

    <h3>Existing Exams</h3>
    <table border="1">
        <tr><th>ID</th><th>Title</th><th>Subject</th><th>Category</th><th>Marks</th><th>Duration</th></tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT e.*, c.category_name FROM tblExams e JOIN tblExamCategories c ON e.category_id = c.category_id";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("exam_id") %></td>
            <td><%= rs.getString("exam_title") %></td>
            <td><%= rs.getString("subject") %></td>
            <td><%= rs.getString("category_name") %></td>
            <td><%= rs.getInt("total_marks") %></td>
            <td><%= rs.getInt("duration") %> min</td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
