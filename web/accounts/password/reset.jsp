<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Forgot Password</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav> 
                <a href="/Crowntech-KHA/"><img src="${root}/images/khalogo_newwhite.png" class="logo"></a>
            </nav>
        </header>
        <div class="greetingBanner">
            <div class="main-body">
                <div class="forgot-box">
                    <form action="${root}/RequestPasswordReset" method="POST">
                        <h1 class="h1-bold">Forgot Password</h1>
                        <div class="changepass-label-container">
                            <p>Having trouble logging in? Enter your email and we will send you a link to reset your account password.</p>
                            <br>
                            <label for="email" class="form">Enter Email Address*:</label><br>
                            <input type="text" name="email" class="form" required/><br/><br/>
                            <div class="button-container">
                                <input class="button-design" type="submit" value="Reset"> 
                            </div>
                        </div>
                    </form>      
                </div>
            </div>
        </div>
    </body>
    <style>
        body {
            zoom: 80%;
        }
    </style>
    <script>
        window.onload = function () {
            var err = new URLSearchParams(window.location.search).get('err');
            if (err == 0) {
                alert("Password reset email has been sent to your email.");
                window.location.href = "${root}";
            } else if (err == 1)
            {
                alert("The given email address is not registered in the system.");
            }
        };
    </script>
</html>