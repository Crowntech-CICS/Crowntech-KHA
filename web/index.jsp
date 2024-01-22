<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires","0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if(!logState) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kingsville Homeowners Association</title>
    <body>
        <%@include file="navbar.jsp" %>
        
        <h1>Welcome ${username} , Access Level: ${level}</h1>
        
    </body>
</html>
