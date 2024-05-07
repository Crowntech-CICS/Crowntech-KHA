<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    
    String root = request.getContextPath();
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect(root + "/accounts/login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kingsville Homeowners Association</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    <body>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br><br>
        <img src="${root}/images/khalogo_new.png" id="indexLogo" alt="KHALogo"/>
        <h1 class="h1-bold" id="indexLogoText">Records Management System</h1>
        <h1 class="h1-bold" id="indexWelcome">Welcome ${username}! (${level})</h1>
        <p style="text-align: center; color: #377d60; margin-top: 10%">Version 1.0.0</p>
        <p style="text-align: center; color: #377d60">Developed by CrownTech, 2024</p>
    </body>
</html>