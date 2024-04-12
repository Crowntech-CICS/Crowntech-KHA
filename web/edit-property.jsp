<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Property Edit</title>
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
                    <h1 class="h1-bold" id="h1small">Property Information</h1>
                    <div class="line"></div><br>
                    <p>Use of Property</p><br>
                    <fieldset>  
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_RES" value="yes">Residential</label>
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_BUS" value="no">Business</label>
                        <label for="PRP_USE" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PRP_BOTH" value="no">Both</label>
                    </fieldset><br>
                    <label for="BUS_NAME">If used for business, registered name of business:</label><input type="text" name="BUS_NAME" placeholder="Business Name"  class="form"><br>
                    <label for="BUS_TYPE">Type of business:</label><input type="text" name="BUS_TYPE" placeholder="Business Type"  class="form"><br>
                    <br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>  
            </div>
        </div>
    </body>
</html>