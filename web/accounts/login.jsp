<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    String root = request.getContextPath();
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (logState) {
        response.sendRedirect(root + "/index.jsp");
    }
    //Login Attempts Counter
    int tries = 0;
    if (session.getAttribute("tries") != null) {
        tries = (Integer) session.getAttribute("tries");
    } else {
        session.setAttribute("tries", tries);
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Login</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>

        <%@include file="/generalpurpose/navbar.jsp" %>

        <div class="main-body">
            <div class="login-box">
                <form action="${root}\Login" method="POST">
                    <h1 class="h1-bold">Login</h1>
                    <div class="changepass-label-container">
                        <label for="email">Email:</label><input type="text" name="email" class="form" required/><br/><br/>
                        <label for="password"> Password:</label><input type="password" name="password" class="form" required><br/><br/>
                        <a href="${root}/accounts/password/reset.jsp" class="login-ref">Forgot Password?</a>
                        <br>
                        <c:if test = "${tries > 0}">
                            <p style="text-align: center;"><span style="color: red; font-size: 50;">You have <% out.print(3 - tries);%> tries left</span></p> 
                        </c:if>
                        <br>
                    </div>
                    <div class="button-container">
                        <input id="login-button" class="button-design" type="submit" value="Login" style="margin-left: 3%">
                    </div>
                    <br>
                    <div class="button-container">
                        <a href="${root}/accounts/SignUp/signup.jsp" class="login-ref">Not yet a member? Apply Here.</a>
                    </div>
                </form>      
            </div>
        </div>
    </body>
    <script>
        window.onload = function () {
            var urlParam = new URLSearchParams(window.location.search);
            var err = urlParam.get('err');
            if (err == 4) {
                alert('The change password link has expired. Please generate a new one to change your password.');
                window.location = '${root}/accounts/login.jsp';
            } else if (err == 3) {
                alert('Invalid link accessed going back to login page.');
                window.location = '${root}/accounts/login.jsp';
            } else if (err == 5) {
                alert('User account not found in the system, returning to login page');
                window.location = '${root}/accounts/login.jsp';
            } else if (err == 0) {
                alert('Your password is changed successfully you may now login.');
                window.location = '${root}/accounts/login.jsp';
            }
            setTimeout(function () {
                $("#login-button").prop("disabled", true).val("Wait...");
            }, 100);

            setTimeout(function () {
                $("#login-button").prop("disabled", false).val("Try again?");
            }, 15000);
        }
    </script>
</html>