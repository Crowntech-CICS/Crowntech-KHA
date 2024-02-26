<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Homeowner Information</title>
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
                    <h1 class="h1-bold">Homeowner Information</h1>
                    <div class="changepass-label-container">
                        <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="form"><br>
                        <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="form"><br>
                        <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE">Age</label><br>
                        <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200" required class="form-small"><br>
                        <label for="HO_ADDRESS">Resident Classification</label><input type="text" name="HO_ADDRESS" placeholder="Select Classification" required class="form"><br>
                        <label for="HO_ADDRESS">Address In Kingsville</label><input type="text" name="HO_ADDRESS" placeholder="Address(House No., Street)" required class="form"><br>
                        <label for="HO_DATE">Date Home Property Was Occupied</label><input type="date" name="HO_DATE" id="" required class="form">
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