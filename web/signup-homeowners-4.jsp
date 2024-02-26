<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Lot/Property Information</title>
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
                    <h1 class="h1-bold">Lot/Property Information</h1>
                    <div class="changepass-label-container">
                        <p>Title Information</p><br>
                        <label for="TIT_NUM" id="label-margin-medium">Title No.</label><label for="TIT_NAME" style="margin-left: 7.1%;">Registered Name</label><br>
                        <input type="text" name="TIT_NUM" placeholder="Title No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_NAME" placeholder="Full Name" required class="form-medium"><br>
                        <label for="TIT_SURNOM" id="label-margin-medium">Survey No.</label><label for="TIT_LOTNUM" style="margin-left: 2.5%;">Lot No.</label><br>
                        <input type="text" name="TIT_SURNOM" placeholder="Survey No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Lot No." required class="form-medium"><br>
                        <label for="TIT_DATE" id="label-margin-medium">Date Registered</label><label for="TIT_AREA" style="margin-left: -6%;">Area</label><br>
                        <input type="date" name="TIT_DATE" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_AREA" placeholder="Area" required class="form-medium"><br>
                        <br><br><p>Tax Declaration Information</p><br>
                        <label for="TAX_NUM" id="label-margin-medium">Tax Declaration No.</label><label for="PRP_INDEX" style="margin-left: -12.2%;">Property Index No.</label><br>
                        <input type="text" name="TAX_NUM" placeholder="Tax Declaration No." class="form-medium" id="form-margin-medium"><input type="text" name="PRP_INDEX" placeholder="Property Index No." required class="form-medium"><br>
                        <br><br><p>KHA Membership</p><br>
                        <label for="HO_MI" id="label-margin-medium">Paid Membership Fee?</label><label for="HO_AGE" style="margin-left: -17%;">If paid, input date:</label><br>
                    <fieldset>  
                        <label for="PAID_YES"><input type="radio" name="PAID_MEM" id="PAID_YES" value="yes">Yes</label>
                        <label for="PAID_NO" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PAID_NO" value="no" style="margin-left: 2%;">No</label>
                        <input type="date" name="PAID_DATE" placeholder="" required style="margin-left: 21.4%;">
                    </fieldset><br>
                        <label for="MEM_NAME">Name Used in Membership</label><input type="text" name="MEM_NAME" placeholder="Full Name" required class="form"><br>
                        <br><br><p>Use of Property</p><br>
                    <fieldset>  
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_RES" value="yes">Residential</label>
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_BUS" value="no">Business</label>
                        <label for="PRP_USE" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PRP_BOTH" value="no">Both</label>
                    </fieldset><br>
                        <label for="BUS_NAME">If used for business, registered name of business:</label><input type="text" name="BUS_NAME" placeholder="Business Name" required class="form"><br>
                        <label for="BUS_TYPE">Type of business:</label><input type="text" name="BUS_TYPE" placeholder="Business Type" required class="form"><br>
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