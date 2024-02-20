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
        <title>KHA | Login</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav> 
                <a href="."><img src="images/khalogo_newwhite.png" class="logo"></a>
            </nav>
        </header>
        <div class="main-body">
            <div class="login-box">
                <form action="Login" method="POST">
                    <h1 class="h1-bold">Login</h1>
                    <div class="changepass-label-container">
                        <label for="email">Email:</label><input type="text" name="email" class="form" required/><br/><br/>
                        <label for="password"> Password:</label><input type="password" name="password" class="form" required><br/><br/>
                        <a href="./accounts/password/reset.jsp" class="login-ref">Forgot Password?</a>
                        <br>
                        <c:if test = "${tries > 0}">
                            <p style="text-align: center;"><span style="color: red; font-size: 50;">You have <% out.print(3 - tries); %> tries left</span></p> 
                        </c:if>
                        <br>
                    </div>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Login">
                    </div>
                    <br>
                    <div class="button-container">
                        <a href="signup-homeowners.jsp" class="login-ref">Not yet a member? Apply Here.</a>
                    </div>
                </form>      
            </div>
        </div>
    </body>
</html>