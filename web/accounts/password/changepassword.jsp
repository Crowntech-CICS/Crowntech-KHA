<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="model.Encryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean state = session.getAttribute("pw_rt") != null ? true : false;
    if (!state) {
        response.sendRedirect(request.getContextPath() + "/accounts/login.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <a href="${root}"><img src="${root}/images/khalogo_newwhite.png" class="logo"></a>
        </nav>
        <div class="main-body">
            <div class="changepass-box">
                <form action="${root}/ResetPassword" method="POST" id="passForm" onsubmit="return validate()">
                    <h1 class="h1-bold">Change Password</h1>
                    <h2 class="changepass-text"><span class="h2-bold">Username:</span>${sessionScope.pw_fn}</h2>
                    <h2 class="changepass-text"><span class="h2-bold">Email:</span>${sessionScope.pw_em}</h2>
                    <div class="changepass-label-container">
                        <label for="newPassword">Create New Password:</label><br><input type="text" name="newPassword" id="newPassword" class="form" required><br>
                        <label for="newPasswordConfirm">Confirm New Password:</label><br><input type="text" name="newPasswordConfirm" id="newPasswordConfirm" class="form" required>
                        <p>Upon successful password change, you will be redirected back to the login page.</p>
                    </div>
                    <div class="button-container" style="margin-top: 1rem;">
                        <button class="button-design">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        function validate(){
            if(document.getElementById('newPassword').value === document.getElementById('newPasswordConfirm').value){               
                return true;
            } else {
                alert("The two passwords inputted are not identical. Please recheck your inputs.");
                return false;
            }
        }
    </script>
</html>
