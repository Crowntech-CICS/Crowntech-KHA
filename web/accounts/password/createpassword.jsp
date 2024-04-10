<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Change Password</title>
        <link rel="icon" type="image/x-icon" href="../../images/khaicon.png">
        <link href="../../css/main-format.css" rel="stylesheet"/>
        <link href="../../css/form-format.css" rel="stylesheet"/>
        <link href="../../css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <nav> 
            <a href="/Crowntech-KHA/"><img src="../../images/khalogo_newwhite.png" class="logo"></a>
        </nav>
        <div class="main-body">
            <div class="changepass-box">
                <form action="" method="POST">
                    <h1 class="h1-bold">Create Password</h1>
                    <div class="changepass-label-container">
                        <p>You are now signed into the system! Please create a new password to access your profile.</p><br>
                        <label for="newPassword">Create New Password:</label><br><input type="text" name="newPassword" class="form" required><br>
                        <label for="newPasswordConfirm">Confirm New Password:</label><br><input type="text" name="newPasswordConfirm" class="form" required>
                        <p>Upon successful password change, you will be redirected back to the login page.</p>
                    </div>
                    <div class="button-container" style="margin-top: 1rem;">
                        <button class="button-design">Create Password</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>