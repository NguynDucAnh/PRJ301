<%-- 
    Document   : viewResults
    Created on : Mar 17, 2025, 12:46:34 AM
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
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
    }

    int examId = Integer.parseInt(request.getParameter("exam_id"));
    Connection con = DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement("SELECT score FROM tblResults WHERE username = ? AND exam_id = ?");
    ps.setString(1, username);
    ps.setInt(2, examId);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
%>
    <h2>Your Score: <%= rs.getInt("score") %>%</h2>
<%
    } else {
%>
    <h2>No result found.</h2>
<%
    }
    con.close();
%>

    </body>
</html>
