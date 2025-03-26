<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, util.DBConnection" %>
<html>
<head>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 20px;
        }
        h2 {
            color: #333;
        }
        form {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
            text-align: left;
            margin-bottom: 20px;
        }
        input[type="text"], input[type="submit"] {
            padding: 8px;
            margin: 5px;
            width: 90%;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ddd;
        }
        th {
            background: #007bff;
            color: white;
        }
        .delete-btn {
            background: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 4px;
        }
        .delete-btn:hover {
            background: darkred;
        }
    </style>
</head>
<body>
    <h2>Exam Categories</h2>
    <form action="ExamCategoryServlet" method="post">
        <input type="hidden" name="action" value="add">
        Category Name: <input type="text" name="category_name" required><br>
        Description: <input type="text" name="description"><br>
        <input type="submit" value="Add Category">
    </form>

    <h3>Existing Categories</h3>
    <table border="1">
        <tr><th>ID</th><th>Name</th><th>Description</th><th>Action</th></tr>
        <%
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT * FROM tblExamCategories";
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("category_id") %></td>
            <td><%= rs.getString("category_name") %></td>
            <td><%= rs.getString("description") %></td>
            <td>
                <form action="ExamCategoryServlet" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="category_id" value="<%= rs.getInt("category_id") %>">
                    <input type="submit" value="Delete">
                </form>
            </td>
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
