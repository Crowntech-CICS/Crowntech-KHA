<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Update Balance</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-smallest">
                <form style="left: 32.5%;">
                    <h1 class="h1-bold" id="h1small">Update Balance</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN_B">Last Name</label><input type="text" name="HO_LN_B" placeholder="Last Name" class="form" required><br>
                    <label for="HO_FN_B">First Name</label><input type="text" name="HO_FN_B" placeholder="First Name" class="form" required><br>
                    <label for="HO_MI_B" id="label-margin">Middle Initial</label><br>
                    <input type="text" name="HO_MI_B" placeholder="Middle Initial" class="form-small" id="form-margin" required><br>
                    <label for="RES_REL">Balance Paid</label><input type="text" name="HO_LN_B" placeholder="Balance Paid In Numerical Form" class="form" required><br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'records.jsp'">
                    </div>
                </form>  
            </div>
        </div>
    </body>
</html>