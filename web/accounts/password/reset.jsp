<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Forgot Password</title>
        <link rel="icon" type="image/x-icon" href="../../images/khaicon.png"> <%-- change to <link rel="icon" type="image/x-icon" href="images/khaicon.png"> --%>
        <link href="../../css/main-format.css" rel="stylesheet"/>
        <link href="../../css/form-format.css" rel="stylesheet"/>
        <link href="../../css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav> 
                <a href="/Crowntech-KHA/"><img src="../../images/khalogo_newwhite.png" class="logo"></a> <%-- CHANGE TO INCLUDE NAVBAR LATER --%>
            </nav>
        </header>
                <div class="greetingBanner">
            <div class="main-body">
                <div class="forgot-box">
                    <form action="../../PasswordReset" method="POST">
                    <h1 class="h1-bold">Forgot Password</h1>
                    <div class="changepass-label-container">
                    <p>Having trouble logging in? Enter your email and we will send you a link to reset your account password.</p>
                    <br><br>
                        <label for="email" class="form">Enter Email Address:</label><br>
                        <input type="text" name="email" class="form" required/><br/><br/>
                        <br>
                        <div class="button-container">
                            <input class="button-design" type="submit" value="Login"> 
                        </div>
                    </div>
                    </form>      
                </div>
            </div>
        </div>
    </body>
</html>