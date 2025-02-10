<%-- 
    Document   : example03
    Created on : Feb 10, 2025, 8:10:07 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
            <% 
            for(int i = 2; i <=9; i++){
                %>
                <hr/>
                <h3> CỬU CHƯƠNG <%=i%> </h3>
                <%
                for(int t = 1; t <=9;t++){
                    int c = i*t;
                
                %>
                   <%=i%> * <%=t%> = <%=c%> <br/>
                <%
            }
        }
        %>
    </body>
</html>
