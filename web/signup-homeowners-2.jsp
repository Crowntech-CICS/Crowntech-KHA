<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Homeowner Contact Information</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box">
                <form action="" method="">
                    <h1 class="h1-bold">Homeowner Contact Information</h1>
                    <div class="changepass-label-container">
                        <label for="HO_EMAIL">Email Address</label><input type="text" name="HO_EMAIL" placeholder="Last Name" required class="form"><br>
                        <label for="HO_CONTACTNUM">Landline/Mobile Number</label><input type="text" name="HO_CONTACTNUM" placeholder="First Name" required class="form"><br>
                    </div>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Next" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" type="submit" value="Cancel" id="button-small">
                    </div>
                    <br>
                </form>      
            </div>
        </div>
    </body>
</html>