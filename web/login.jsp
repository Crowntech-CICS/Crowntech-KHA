<%-- 
    Document   : login
    Created on : 01 20, 24, 3:27:37 PM
    Author     : ejlu1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Expires", "0");

            if (session.getAttribute("username") != null) {
                response.sendRedirect("index.jsp");
            }

        %>
        <header>
            <nav> 
                <img src="images/khalogo.png" class="logo">
            </nav>
        </header>
        <div class="greetingBanner">
            <div class="main-body">
                <div class="container2">
                    <%                  
                        int tries = 0;
                        if (session.getAttribute("tries") != null) {
                            tries = (Integer) session.getAttribute("tries");
                        }
                    %>
                    <br>
                    <br>
                    <div class="login-box">
                        <form action="Login" class="login-content">
                            <label for="email" class="login-title">Username:</label><br>
                            <input type="text" name="username" class="login-form" required/><br/><br/>

                            <label for="password" class="login-title"> Password:</label><br>
                            <input type="password" name="password" class="login-form" required><br/><br/>
                            <br>
                            <p style="text-align: center;"><span style="color: red; font-size: 50;">You have <% out.print(3 - tries); %> tries left</span></p>
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
