<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login.jsp");
    }
%>
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
                    <div class="step-col" id="Next1">Personal</div>
                    <div class="step-col" id="Next2">Address</div>
                    <div class="step-col" id="Next3">Other</div>
                    <div class="step-col" id="Next4">Title</div>
                    <div class="step-col" id="Next5">Property</div>
                </div>
                <form id='form1' action="UpdateInfo">
                    <h1 class="h1-bold" id="h1small">Homeowner Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
                    <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="HO_DATE">Date Home Property Was Occupied</label><input type="date" name="HO_DATE" class="form">
                    <label for="HO_EMAIL">Email Address</label><input type="text" name="HO_EMAIL" placeholder="Email Address" class="form"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_LANDNO" class="marginMobile">Mobile Number</label><br>
                    <input type="text" name="HO_LANDNO" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input type="text" name="HO_MOBNO" placeholder="Mobile Number" class="form-medium"><br>
                    <input type="hidden" name="FORM_NO" value="1">
                    <br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>

                <form id='form2' action="UpdateInfo">
                    <h1 class="h1-bold" id="h1small">Homeowner Address</h1>
                    <div class="line"></div><br>
                    <label for="ADD_HOUSENO" id="label-margin-medium">House Number</label><label for="ADD_STREET" class="marginStreet">Street Name</label><br>
                    <input type="text" name="ADD_HOUSENO" placeholder="House Number" class="form-medium" id="form-margin-medium"><input type="text" name="ADD_STREET" placeholder="Street Name" required class="form-medium"><br>
                    <label for="ADD_VILL" id="label-margin-medium">Village</label><label for="ADD_BAR" class="marginVehicleYear">Barangay</label><br>
                    <input type="text" name="ADD_VIL" placeholder="Village" class="form-medium" id="form-margin-medium"><input type="text" name="ADD_BAR" placeholder="Barangay" required class="form-medium"><br>
                    <label for="ADD_CITY" id="label-margin-medium">City</label><label for="ADD_PROV" class="marginProvince">Province</label><br>
                    <input type="text" name="ADD_CITY" placeholder="City" class="form-medium" id="form-margin-medium"><input type="text" name="ADD_PROV" placeholder="Province" required class="form-medium"><br>
                    <br>
                    <input type="hidden" name="FORM_NO" value="2">
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>  

                <form id='form3' action="UpdateInfo">
                    <h1 class="h1-bold" id="h1small">Other Persons Staying in Home Property</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
                    <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200" required class="form-small"><br>
                    <label for="RES_REL">Relationship with Resident</label>
                    <select name="RES_REL" class="form">
                        <option value="" selected>Relationship</option>
                        <option value="">Spouse</option>
                        <option value="">Son/Daughter</option>
                        <option value="">Grandchild</option>
                        <option value="">Househelp</option>
                        <option value="">Renter</option>
                        <option value="">Parent</option>
                        <option value="">Friend</option>
                    </select>
                    <br>
                                        <input type="hidden" name="FORM_NO" value="3">
                    <div class="button-container">
                    <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                    <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>     

                <form id="form4" action="UpdateInfo">
                    <h1 class="h1-bold" id="h1small">Title Information</h1>
                    <div class="line"></div><br>
                    <p>Title Information</p><br>
                    <label for="TIT_NUM" id="label-margin-medium">Title No.</label><label for="TIT_NAME" class="marginRegName">Registered Name</label><br>
                    <input type="text" name="TIT_NUM" placeholder="Title No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_NAME" placeholder="Full Name" required class="form-medium"><br>
                    <label for="TIT_SURNOM" id="label-margin-medium">Survey No.</label><label for="TIT_LOTNUM" class="marginLot">Lot No.</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Survey No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Lot No." required class="form-medium"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Date Registered</label><label for="TIT_AREA" class="marginArea">Area</label><br>
                    <input type="date" name="TIT_DATE" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_AREA" placeholder="Area" required class="form-medium"><br>
                    <br><br><p>Tax Declaration Information</p><br>
                    <label for="TAX_NUM" id="label-margin-medium">Tax Declaration No.</label><label for="PRP_INDEX" class="marginPropIndex">Property Index No.</label><br>
                    <input type="text" name="TAX_NUM" placeholder="Tax Declaration No." class="form-medium" id="form-margin-medium"><input type="text" name="PRP_INDEX" placeholder="Property Index No." required class="form-medium"><br>
                    <br>
                                        <input type="hidden" name="FORM_NO" value="4">
                    <div class="button-container">
                    <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                    <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>
                <form id="form5" action="UpdateInfo">
                    <h1 class="h1-bold" id="h1small">Property Information</h1>
                    <div class="line"></div><br>
                    <p>KHA Membership</p><br>
                    <label for="HO_MI" id="label-margin-medium">Paid Membership Fee?</label><label for="HO_AGE" class="marginPaidDate">If paid, input date:</label><br>
                    <fieldset>  
                        <label for="PAID_YES"><input type="radio" name="PAID_MEM" id="PAID_YES" value="yes">Yes</label>
                        <label for="PAID_NO" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PAID_NO" value="no" style="margin-left: 2%;">No</label>
                        <input type="date" name="PAID_DATE" placeholder="" required id="marginPaidDateButton" class="date_button">
                    </fieldset><br>
                    <label for="MEM_NAME">Name Used in Membership</label><input type="text" name="MEM_NAME" placeholder="Full Name" required class="form"><br>
                    <p>Use of Property</p><br>
                    <fieldset>  
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_RES" value="yes">Residential</label>
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_BUS" value="no">Business</label>
                        <label for="PRP_USE" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PRP_BOTH" value="no">Both</label>
                    </fieldset><br>
                    <label for="BUS_NAME">If used for business, registered name of business:</label><input type="text" name="BUS_NAME" placeholder="Business Name" required class="form"><br>
                    <label for="BUS_TYPE">Type of business:</label><input type="text" name="BUS_TYPE" placeholder="Business Type" required class="form"><br>
                    <br>
                    <input type="hidden" name="FORM_NO" value="5"> 
                    <div class="button-container">
                    <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                    <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>
            </div>
        </div>
        <script>
            var form1 = document.getElementById("form1");
            var form2 = document.getElementById("form2");
            var form3 = document.getElementById("form3");
            var form4 = document.getElementById("form4");
            var form5 = document.getElementById("form5");
            var form6 = document.getElementById("form6");

            var Next1 = document.getElementById("Next1");
            var Next2 = document.getElementById("Next2");
            var Next3 = document.getElementById("Next3");
            var Next4 = document.getElementById("Next4");
            var Next5 = document.getElementById("Next5");
            var Next6 = document.getElementById("Next6");

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

            Next3.onclick = function () {
                form1.style.left = "1000px";
                form2.style.left = "1000px";
                form3.style.left = "32.5%";
                form4.style.left = "1000px";
                form5.style.left = "1000px";
                form6.style.left = "1000px";
            }

            Next4.onclick = function () {
                form1.style.left = "1000px";
                form2.style.left = "1000px";
                form3.style.left = "1000px";
                form4.style.left = "32.5%";
                form5.style.left = "1000px";
                form6.style.left = "1000px";
            }

            Next5.onclick = function () {
                form1.style.left = "1000px";
                form2.style.left = "1000px";
                form3.style.left = "1000px";
                form4.style.left = "1000px";
                form5.style.left = "32.5%";
                form6.style.left = "1000px";
            }
        </script>
    </body>
</html>