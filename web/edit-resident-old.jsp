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
            <div class="signup-box-small">
                <div class="step-row">
                    <div id="progressEDIT"></div>
                    <div class="step-col" id="Next1">Personal</div>
                    <div class="step-col" id="Next2">Homeowner</div>
                    <div class="step-col" id="Next3">Address</div>
                    <div class="step-col" id="Next4">Other</div>
                    <div class="step-col" id="Next5">Caretaker</div>
                </div>
                <form id='form1'>
                    <h1 class="h1-bold" id="h1small">Resident Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
                    <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="HO_DATE">Date Home Property Was Occupied</label><input type="date" name="HO_DATE" id=""  class="form">
                    <label for="HO_EMAIL">Email Address</label><input type="text" name="HO_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_CONTACTNUM" class="marginMobile">Mobile Number</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input type="text" name="HO_CONTACTNUM" placeholder="Mobile Number" required class="form-medium"><br>
                    <input type="hidden" name="FORM_NO" value="1">
                    <br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>

                <form id='form2'>
                    <h1 class="h1-bold" id="h1small">Homeowner Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><br>
                    <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><br>
                    <label for="HO_EMAIL">Email Address</label><input type="text" name="HO_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_CONTACTNUM" class="marginMobile">Mobile Number</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input type="text" name="HO_CONTACTNUM" placeholder="Mobile Number" required class="form-medium"><br>
                    <input type="hidden" name="FORM_NO" value="1">
                    <br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>  

                <form id='form3'>
                                        <h1 class="h1-bold" id="h1small">Address</h1>
                    <div class="line"></div>
                    <p>Resident Address</p>
                    <label for="TIT_NUM" id="label-margin-medium">House Number</label><label for="TIT_NAME" class="marginStreet">Street Name</label><br>
                    <input type="text" name="TIT_NUM" placeholder="House Number" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_NAME" placeholder="Street Name" required class="form-medium"><br>
                    <label for="TIT_SURNOM" id="label-margin-medium">Village</label><label for="TIT_LOTNUM" class="marginVehicleYear">Barangay</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Village" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Barangay" required class="form-medium"><br>
                    <label for="TIT_DATE" id="label-margin-medium">City</label><label for="TIT_AREA" class="marginProvince">Province</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="City" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Province" required class="form-medium"><br>
                    <p>Homeowner Address</p>
                    <label for="TIT_NUM" id="label-margin-medium">House Number</label><label for="TIT_NAME" class="marginStreet">Street Name</label><br>
                    <input type="text" name="TIT_NUM" placeholder="House Number" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_NAME" placeholder="Street Name" required class="form-medium"><br>
                    <label for="TIT_SURNOM" id="label-margin-medium">Village</label><label for="TIT_LOTNUM" class="marginVehicleYear">Barangay</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Village" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Barangay" required class="form-medium"><br>
                    <label for="TIT_DATE" id="label-margin-medium">City</label><label for="TIT_AREA" class="marginProvince">Province</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="City" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Province" required class="form-medium"><br>
                    <br>
                    <input type="hidden" name="FORM_NO" value="2">
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>     

                <form id="form4">
                                        <h1 class="h1-bold" id="h1small">Other Persons Staying in Home Property</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
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
                    <br>
                                        <input type="hidden" name="FORM_NO" value="3">
                    <div class="button-container">
                    <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                    <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                    </div>
                </form>
                
                <form id="form5">
                    <h1 class="h1-bold" id="h1small">Caretaker Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><br>
                    <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_CONTACTNUM" class="marginMobile">Mobile Number</label><br>
                    <input type="text" name="TIT_SURNOM" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input type="text" name="HO_CONTACTNUM" placeholder="Mobile Number" required class="form-medium"><br>
                    <input type="hidden" name="FORM_NO" value="1">
                    <br>
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