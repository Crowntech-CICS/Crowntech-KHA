<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD:web/user/edit-lessee.jsp
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login/login.jsp");
    }
%>
=======
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page):web/edit-lessee.jsp
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Lessee Edit</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="../navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box">
                <div class="step-row">
                    <div id="progressEDIT"></div>
                    <div class="step-col" id="Next1">Personal</div>
                    <div class="step-col" id="Next2">Contact</div>
                    <div class="step-col" id="Next3">Other</div>
                    <div class="step-col" id="Next4">Homeowner</div>
                    <div class="step-col" id="Next5">Caretaker</div>
                    <div class="step-col" id="Next6">Vehicle</div>
                </div>
                <form id='form1'>
                    <h1 class="h1-bold">Lessee Information</h1>
                    <div class="line"></div><br>
                    <label for="LE_LN">Last Name</label><input type="text" name="LE_LN" placeholder="Last Name" class="form"><br>
                    <label for="LE_FN">First Name</label><input type="text" name="LE_FN" placeholder="First Name" class="form"><br>
                    <label for="LE_MI" id="label-margin">Middle Initial</label><label for="LE_AGE" class="marginAge">Age</label><br>
                    <input type="text" name="LE_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="LE_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="LE_ADDRESS">Resident Classification</label><input type="text" name="LE_ADDRESS" placeholder="Select Classification"  class="form"><br>
                    <label for="LE_ADDRESS">Address In Kingsville</label><input type="text" name="LE_ADDRESS" placeholder="Address(House No., Street)"  class="form"><br>
                    <label for="LE_DATE">Date Home Property Was Occupied</label><input type="date" name="LE_DATE" id=""  class="form">
                    <br>
                </form>

                <form id='form2'>
                    <h1 class="h1-bold">Lessee Contact Information</h1>
                    <div class="line"></div><br>
                    <label for="LE_EMAIL">Email Address</label><input type="text" name="LE_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="LE_CONTACTNUM">Landline/Mobile Number</label><input type="text" name="LE_CONTACTNUM" placeholder="Phone Number" required class="form"><br>
                    <br>
                </form>  

                <form id='form3'>
                    <h1 class="h1-bold">Other Persons Staying in Home Property</h1>
                    <div class="line"></div><br>
                    <label for="LE_LN">Last Name</label><input type="text" name="LE_LN" placeholder="Last Name" required class="form"><br>
                    <label for="LE_FN">First Name</label><input type="text" name="LE_FN" placeholder="First Name" required class="form"><br>
                    <label for="LE_MI" id="label-margin">Middle Initial</label><label for="LE_AGE" class="marginAge">Age</label><br>
                    <input type="text" name="LE_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="LE_AGE" placeholder="Age" min="1" max="200" required class="form-small"><br>
                    <label for="LE_REL"">Relationship with Resident</label>
                    <select name="LE_REL" id="" class="form">
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
                    <br>
                </form>     

                <form id="form4">
                    <h1 class="h1-bold">Homeowner Information</h1>
                    <div class="line"></div><br>
                    <label for="LE_HO_LN">Last Name</label><input type="text" name="LE_HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="LE_HO_FN">First Name</label><input type="text" name="LE_HO_FN" placeholder="First Name" class="form"><br>
                    <label for="LE_HO_MI" id="label-margin">Middle Initial</label>
                    <input type="text" name="LE_HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><br>
                    <label for="LE_HO_ADDRESS">Email Address</label><input type="text" name="LE_HO_ADDRESS" placeholder="Email Address"  class="form"><br>
                    <label for="LE_HO_ADDRESS">Landline/Mobile No.</label><input type="text" name="LE_HO_ADDRESS" placeholder="Phone Number" class="form"><br>
                    <label for="LE_HO_DATE">Current Address</label><input type="text" name="LE_HO_DATE" placeholder="Current Address" class="form">
                </form>
                <form id="form5">
                    <h1 class="h1-bold">Representative or Caretaker</h1>
                    <label for="LE_REP_LN">Last Name</label><input type="text" name="LE_REP_LN" placeholder="Last Name" class="form"><br>
                    <label for="LE_REP_FN">First Name</label><input type="text" name="LE_REP_FN" placeholder="First Name" class="form"><br>
                    <label for="LE_REP_MI" id="label-margin">Middle Initial</label>
                    <input type="text" name="LE_REP_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><br>
                    <label for="LE_REP_PHONE">Landline/Mobile No.</label><input type="text" name="LE_REP_PHONE" placeholder="Phone Number" class="form"><br>
                    <br>
                </form>

                <form id="form6">
                    <h1 class="h1-bold">Vehicle Information</h1>
                    <div class="changepass-label-container">
                        <label for="VEH_PLATE" id="label-margin-medium">Plate No.</label><label for="VEH_TYPE" class="marginVehicleType">Type of Vehicle</label><br>
                        <input type="text" name="VEH_PLATE" placeholder="Plate No." class="form-medium" id="form-margin-medium"><input type="text" name="VEH_TYPE" placeholder="Vehicle Type" required class="form-medium"><br>
                        <label for="VEH_BRAND" id="label-margin-medium">Brand</label><label for="VEH_MODEL" class="marginVehicleYear">Year/Model</label><br>
                        <input type="text" name="VEH_BRAND" placeholder="Vehicle Brand" class="form-medium" id="form-margin-medium"><input type="text" name="VEH_MODEL" placeholder="Vehicle Model" required class="form-medium"><br>
                        <label for="VEH_OWNER">Registered Owner</label><input type="text" name="VEH_OWNER" placeholder="Vehicle Owner" required class="form"><br>

                        <div class="add_more">
                            <button class="res_add" onclick="">Add more</button>
                        </div>   
                        <br>
                        <div class="upload_files" id="form_container" class="form_input_title">
                            <p style="text-align: center">Upload Digital Copy of Required Documents</p>
                            <input type="file" class="file_button" name="FILES_UPLOAD" id="input-none" accept="image/*,.pdf" multiple style="margin-left: 33%">
                        </div>
                    </div>
                    <br>
                </form>    
                <div class="button-container" id="edit-button">
                    <input class="button-design" type="button" value="Save" id="button-small" style="margin-right: 10%;">
                    <input class="button-design-reject" type="button" value="Cancel" id="button-small">
                </div>
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

            Next6.onclick = function () {
                form1.style.left = "1000px";
                form2.style.left = "1000px";
                form3.style.left = "1000px";
                form4.style.left = "1000px";
                form5.style.left = "1000px";
                form6.style.left = "32.5%";
            }
        </script>
    </body>
</html>