<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Other Persons Staying in Home Property</title>
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
                    <h1 class="h1-bold">Other Persons Staying in Home Property</h1>
                    <div class="changepass-label-container">
                        <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="form"><br>
                        <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="form"><br>
                        <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE">Age</label><br>
                        <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200" required class="form-small"><br>
                        <label for="RES_REL"">Relationship with Resident</label>
                        <select name="RES_REL" id="" class="form">
                            <option value="" selected>Relationship</option>
                            <option value="">Spouse</option>
                            <option value="">Son/Daughter</option>
                            <option value="">Grandchild</option>
                            <option value="">Househelp</option>
                            <option value="">Renter</option>
                            <option value="">Parent</option>
                            <option value="">Friend</option>
                        </select>
            <div class="add_more">
                <button class="res_add" onclick="">Add more</button>
            </div>   
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