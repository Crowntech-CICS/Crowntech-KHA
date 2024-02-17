<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forgot Password</title>
        <link rel="icon" type="image/x-icon" href="images/ApolloLogoOnly.png"/>
        <link href="../../css/login.css" rel="stylesheet"/>
        <link href="../../css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav> 
                <a href="/Crowntech-KHA/"><img src="../../images/khalogo.png" class="logo"></a>
            </nav>
        </header>
                <div class="greetingBanner">
            <div class="main-body">
                <div class="container2">
                    <div class="login-box">
                        <h2>Trouble Logging in?</h2>
                        <p>Enter your email and we will send you a link to reset your account password.</p>
                        <form action="../../PasswordReset" class="login-content" method="POST">
                            <label for="email" class="login-title">Email:</label><br>
                            <input type="text" name="email" class="login-form" required/><br/><br/>
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
    <style>
        
    </style>
</html>
