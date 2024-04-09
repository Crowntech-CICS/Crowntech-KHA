<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kingsville Homeowners Association</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    <body>
        <%@include file="../navbar.jsp" %>
        <br><br><br><br><br><br>
        <img src="images/khalogo_new.png" style="  display: block;
             margin-left: 40%;
             margin-right: 50%;
             width: 22%;
             height: 7%"/>
        <h1 class="h1-bold" style="font-family: 'Times New Roman'; 
            color: #1e4d23; 
            -webkit-text-stroke-width: 0px; 
            -webkit-text-stroke-color:#1e4d23; 
            margin-top: -.2%; 
            font-size: 16px; 
            font-weight: 200">Records Management System</h1>
        <h1 class="h1-bold" style="font-size: 90px; margin-top: 10%;">Welcome ${username}! (${level})</h1>
        <p style="text-align: center; color: #377d60; margin-top: 10%">Version 1.0.0</p>
        <p style="text-align: center; color: #377d60">Developed by CrownTech, 2024</p>
    </body>
</html>