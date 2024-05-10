<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Change Password</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <nav> 
            <a href="${root}/"><img src="${root}/images/khalogo_newwhite.png" class="logo"></a>
        </nav>
        <div class="main-body">
            <div class="changepass-box">
                <form action="${root}/CreateLogin" method="POST" onsubmit="return validate()">
                    <h1 class="h1-bold">Create Password</h1>
                    <div class="changepass-label-container">
                        <input type="hidden" name="EMAIL" value="${requestScope.email}">
                        <input type="hidden" name="USERID" value="${requestScope.userid}">
                        <p>You have been verified in the system! Please create a new password to access your profile.</p><br>
                        <label for="newPassword">Create New Password:</label><br><input type="text" name="newPassword" id="newPassword"class="form" required><br>
                        <label for="newPasswordConfirm">Confirm New Password:</label><br><input type="text" name="newPasswordConfirm" id="newPasswordConfirm" class="form" required>
                        <p>Upon successful password change, you will be redirected back to the sign up page.</p>
                    </div>
                    <div class="button-container" style="margin-top: 1rem;">
                        <button class="button-design">Create Password</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <style>
        body {
            zoom: 80%;
        }
    </style>
    <script>
        function validate() {
            if (document.getElementById('newPassword').value === document.getElementById('newPasswordConfirm').value) {
                return true;
            } else {
                alert("The two passwords inputted are not identical. Please recheck your inputs.");
                return false;
            }
        }
    </script>
</html>