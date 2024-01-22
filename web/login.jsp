<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if(logState) {
        response.sendRedirect("index.jsp");
    }
    //Login Attempts Counter
    int tries = 0;
    if (session.getAttribute("tries") != null) {
        tries = (Integer) session.getAttribute("tries");
    }
    else {
        session.setAttribute("tries", tries);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>Login | Kingsville Homeowners Association</title>
        <link rel="icon" type="image/x-icon" href="images/ApolloLogoOnly.png"/>
        <link href="css/login.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav> 
                <a href="."><img src="images/khalogo.png" class="logo"></a>
            </nav>
        </header>
        <div class="greetingBanner">
            <div class="main-body">
                <div class="container2">
                    <br>
                    <br>
                    <div class="login-box">
                        <form action="Login" class="login-content" method="POST">
                            <label for="email" class="login-title">Email:</label><br>
                            <input type="text" name="email" class="login-form" required/><br/><br/>

                            <label for="password" class="login-title"> Password:</label><br>
                            <input type="password" name="password" class="login-form" required><br/><br/>
                            <br>
                            <c:if test = "${tries > 0}">
                                <p style="text-align: center;"><span style="color: red; font-size: 50;">You have <% out.print(3 - tries); %> tries left</span></p> 
                            </c:if>
                            <br>
                            <div class="button-container">
                                <input class="button-design" type="submit" value="Login">
                            </div>
                        </form>      
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
