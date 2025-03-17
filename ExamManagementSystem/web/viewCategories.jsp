<%-- 
    Document   : viewCategories
    Created on : Mar 17, 2025, 12:35:58 AM
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
    Connection con = DBConnection.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM tblExamCategories");
%>
<table>
    <tr><th>Category Name</th><th>Description</th></tr>
    <% while (rs.next()) { %>
    <tr>
        <td><%= rs.getString("category_name") %></td>
        <td><%= rs.getString("description") %></td>
    </tr>
    <% } %>
</table>
<% con.close(); %>

    </body>
</html>
