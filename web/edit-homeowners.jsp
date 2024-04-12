<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Homeowner Edit</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box">
                <div class="step-row">
                    <div id="progressEDIT"></div>
                    <div class="step-col"></div>
                    <div class="step-col" id="Next1">Personal</div>
                    <div class="step-col"></div>
                    <div class="step-col" id="Next2">Address</div>
                    <div class="step-col"></div>
                </div>
                <form id='form1' action="UpdateInfo" method="POST">
                    <h1 class="h1-bold" id="h1small">Update Your Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
                    <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_LANDNO" class="marginMobile">Mobile Number</label><br>
                    <input type="text" name="HO_LANDNO" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input type="text" name="HO_MOBNO" placeholder="Mobile Number" class="form-medium"><br>
                    <input type="hidden" name="FORM_NO" value="1">
                    <br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>

                <form id='form2' action="UpdateInfo" method="POST">
                    <h1 class="h1-bold" id="h1small">Update Current Address</h1>
                    <div class="line"></div><br>
                    <label for="ADD_HOUSENO" id="label-margin-medium">House Number</label><label for="ADD_STREET" class="marginStreet">Street Name</label><br>
                    <input type="text" name="ADD_HOUSENO" placeholder="House Number" class="form-medium" id="form-margin-medium"><input type="text" name="ADD_STREET" placeholder="Street Name"  class="form-medium"><br>
                    <label for="ADD_VILL" id="label-margin-medium">Village</label><label for="ADD_BAR" class="marginVehicleYear">Barangay</label><br>
                    <input type="text" name="ADD_VILL" placeholder="Village" class="form-medium" id="form-margin-medium"><input type="text" name="ADD_BAR" placeholder="Barangay"  class="form-medium"><br>
                    <label for="ADD_CITY" id="label-margin-medium">City</label><label for="ADD_PROV" class="marginProvince">Province</label><br>
                    <input type="text" name="ADD_CITY" placeholder="City" class="form-medium" id="form-margin-medium"><input type="text" name="ADD_PROV" placeholder="Province"  class="form-medium"><br>
                    <br>
                    <input type="hidden" name="FORM_NO" value="2">
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>  
<%--
                <form id="form4" action="UpdateInfo">
                    <h1 class="h1-bold" id="h1small">Title Information</h1>
                    <div class="line"></div><br>
                    <p>Title Information</p><br>
                    <label for="TIT_NUM" id="label-margin-medium">Title No.</label><label for="TIT_NAME" class="marginRegName">Registered Name</label><br>
                    <input type="text" name="TIT_NUM" placeholder="Title No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_NAME" placeholder="Full Name"  class="form-medium"><br>
                    <label for="TIT_SURNOM" id="label-margin-medium">Survey No.</label><label for="TIT_LOTNUM" class="marginLot">Lot No.</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Survey No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Lot No."  class="form-medium"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Date Registered</label><label for="TIT_AREA" class="marginArea">Area</label><br>
                    <input type="date" name="TIT_DATE" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_AREA" placeholder="Area"  class="form-medium"><br>
                    <br><br><p>Tax Declaration Information</p><br>
                    <label for="TAX_NUM" id="label-margin-medium">Tax Declaration No.</label><label for="PRP_INDEX" class="marginPropIndex">Property Index No.</label><br>
                    <input type="text" name="TAX_NUM" placeholder="Tax Declaration No." class="form-medium" id="form-margin-medium"><input type="text" name="PRP_INDEX" placeholder="Property Index No."  class="form-medium"><br>
                    <br>
                                        <input type="hidden" name="FORM_NO" value="4">
                    <div class="button-container">
                    <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                    <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>
--%>
            </div>
        </div>
        <script>
            var form1 = document.getElementById("form1");
            var form2 = document.getElementById("form2");

            var Next1 = document.getElementById("Next1");
            var Next2 = document.getElementById("Next2");
            Next1.onclick = function () {
                form1.style.left = "32.5%";
                form2.style.left = "1000px";
                form3.style.left = "1000px";
                form4.style.left = "1000px";
                form5.style.left = "1000px";
                form6.style.left = "1000px";
            }

            Next2.onclick = function () {
                form1.style.left = "1000px";
                form2.style.left = "32.5%";
                form3.style.left = "1000px";
                form4.style.left = "1000px";
                form5.style.left = "1000px";
                form6.style.left = "1000px";
            }
        </script>
    </body>
</html>