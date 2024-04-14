<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Create Homeowner Account</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-big">
                <div class="step-row">
                    <div id="progress"></div>
                    <div class="step-col">Step 1</div>
                    <div class="step-col">Step 2</div>
                    <div class="step-col">Step 3</div>
                    <div class="step-col">Step 4</div>
                </div>
                <form id='form1'>
                    <h1 class="h1-bold" id="h1small">Homeowner Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label><input onchange="finalForm.HO_LN.value = this.value" type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_FN">First Name</label><input onchange="finalForm.HO_FN.value = this.value" type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
                    <input onchange="finalForm.HO_MI.value = this.value" type="text" type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input onchange="finalForm.HO_AGE.value = this.value" type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="HO_EMAIL">Email Address</label><input onchange="finalForm.HO_EMAIL.value = this.value" type="text" name="HO_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_LANDNO" class="marginMobile">Mobile Number</label><br>
                    <input onchange="finalForm.HO_LANDLINE.value = this.value" type="text" name="HO_LANDLINE" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input onchange="finalForm.HO_PHONE.value = this.value" type="text" name="HO_PHONE" placeholder="Mobile Number" class="form-medium"><br>
                    <br><br><br><br>
                    <div class="button-container">
                        <input id="Next1" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                        <input class="button-design-reject" type="button" value="Cancel" onclick="window.location.href='records.jsp'" id="button-small">
                    </div>
                </form>

                <form id='form2'>
                    <h1 class="h1-bold" id="h1small">H.O. and Lot Address</h1>
                    <div class="line"></div><br>
                    <p>Homeowner Address</p>
                    <label for="HO_HOUSENUM" id="label-margin-medium">House Number</label><label for="HO_STREET" class="marginStreet">Street Name</label><br>
                    <input onchange="finalForm.HO_HOUSENUM.value = this.value" type="text" name="HO_HOUSENUM" placeholder="House Number" class="form-medium" id="form-margin-medium"><input onchange="finalForm.HO_STREET.value = this.value" type="text" name="HO_STREET" placeholder="Street Name"  class="form-medium"><br>
                    <label for="HO_VILLAGE" id="label-margin-medium">Village</label><label for="HO_BARANGAY" class="marginVehicleYear">Barangay</label><br>
                    <input onchange="finalForm.HO_VILLAGE.value = this.value" type="text" name="HO_VILLAGE" placeholder="Village" class="form-medium" id="form-margin-medium"><input onchange="finalForm.HO_BARANGAY.value = this.value" type="text" name="HO_BARANGAY" placeholder="Barangay"  class="form-medium"><br>
                    <label for="HO_CITY" id="label-margin-medium">City</label><label for="HO_PROVINCE" class="marginProvince">Province</label><br>
                    <input onchange="finalForm.HO_CITY.value = this.value" type="text" name="HO_CITY" placeholder="City" class="form-medium" id="form-margin-medium"><input onchange="finalForm.HO_PROVINCE.value = this.value" type="text" name="HO_PROVINCE" placeholder="Province"  class="form-medium"><br>
                    <p>Lot Address</p>
                    <label for="USER_HOUSENUM" id="label-margin-medium">House Number</label><label for="USER_STREET" class="marginStreet">Street Name</label><br>
                    <input onchange="finalForm.USER_HOUSENUM.value = this.value" type="text" name="USER_HOUSENUM" placeholder="House Number" class="form-medium" id="form-margin-medium"><input onchange="finalForm.USER_STREET.value = this.value" type="text" name="USER_STREET" placeholder="Street Name"  class="form-medium"><br>
                    <label for="USER_VILLAGE" id="label-margin-medium">Village</label><label for="USER_BARANGAY" class="marginVehicleYear">Barangay</label><br>
                    <input onchange="finalForm.USER_VILLAGE.value = this.value" type="text" name="USER_VILLAGE" placeholder="Village" class="form-medium" id="form-margin-medium"><input onchange="finalForm.USER_BARANGAY.value = this.value" type="text" name="USER_BARANGAY" placeholder="Barangay"  class="form-medium"><br>
                    <label for="USER_CITY" id="label-margin-medium">City</label><label for="USER_PROVINCE" class="marginProvince">Province</label><br>
                    <input onchange="finalForm.USER_CITY.value = this.value" type="text" name="USER_CITY" placeholder="City" class="form-medium" id="form-margin-medium"><input onchange="finalForm.USER_PROVINCE.value = this.value" type="text" name="USER_PROVINCE" placeholder="Province"  class="form-medium"><br>
                    <label for="HO_DATE">Date Home Property Was Occupied</label><input onchange="finalForm.HO_DATE.value = this.value" type="date" name="HO_DATE" id=""  class="form">
                    <div class="button-container">
                        <input id="Next2" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                        <input id="Back2" class="button-design-reject" type="button" value="Back">
                    </div>
                </form>  

                <form id="form3">
                    <h1 class="h1-bold" id="h1small">Title Information</h1>
                    <div class="line"></div><br>
                    <p>Title Information</p><br>
                    <label for="TIT_NUM" id="label-margin-medium">Title No.</label><label for="TIT_NAME" class="marginRegName">Registered Name</label><br>
                    <input onchange="finalForm.TIT_NUM.value = this.value" type="text" name="TIT_NUM" placeholder="Title No." class="form-medium" id="form-margin-medium"><input onchange="finalForm.TIT_NAME.value = this.value" type="text" name="TIT_NAME" placeholder="Full Name"  class="form-medium"><br>
                    <label for="TIT_SURNUM" id="label-margin-medium">Survey No.</label><label for="TIT_LOTNUM" class="marginLot">Lot No.</label><br>
                    <input onchange="finalForm.TIT_SURNUM.value = this.value" type="text" name="TIT_SURNUM" placeholder="Survey No." class="form-medium" id="form-margin-medium"><input onchange="finalForm.TIT_LOTNUM.value = this.value" type="text" name="TIT_LOTNUM" placeholder="Lot No."  class="form-medium"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Date Registered</label><label for="TIT_AREA" class="marginArea">Area</label><br>
                    <input onchange="finalForm.TIT_DATE.value = this.value" type="date" name="TIT_DATE" class="form-medium" id="form-margin-medium"><input onchange="finalForm.TIT_AREA.value = this.value" type="text" name="TIT_AREA" placeholder="Area"  class="form-medium"><br>
                    <br><br><p>Tax Declaration Information</p><br>
                    <label for="TAX_NUM" id="label-margin-medium">Tax Declaration No.</label><label for="PRP_INDEX" class="marginPropIndex">Property Index No.</label><br>
                    <input onchange="finalForm.TAX_NUM.value = this.value" type="text" name="TAX_NUM" placeholder="Tax Declaration No." class="form-medium" id="form-margin-medium"><input onchange="finalForm.PRP_INDEX.value = this.value" type="text" name="PRP_INDEX" placeholder="Property Index No."  class="form-medium"><br>
                    <br>
                    <div class="button-container">
                        <input id="Next3" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                        <input id="Back3" class="button-design-reject" type="button" value="Back">
                    </div>
                </form>

                <form id="form4">
                    <h1 class="h1-bold" id="h1small">Property Information</h1>
                    <p>KHA Membership</p><br>
                    <label for="HO_MI" id="label-margin-medium">Paid Membership Fee?</label><label for="HO_AGE" style="margin-left: -17%;">If paid, input date:</label><br>
                    <fieldset>  
                        <label for="PAID_YES"><input onclick="finalForm.MEM_PAID.value = this.value" type="radio" name="PAID_MEM" id="PAID_YES" value="yes">Yes</label>
                        <label for="PAID_NO" id="form-margin-medium"><input  onclick="finalForm.MEM_PAID.value = this.value" type="radio" name="PAID_MEM" id="PAID_NO" value="no" style="margin-left: 2%;">No</label>
                        <input onchange="finalForm.PAID_DATE.value = this.value" type="date" name="PAID_DATE" placeholder="" required style="margin-left: 21.4%;">
                    </fieldset><br>
                    <label for="MEM_NAME">Name Used in Membership</label><input onchange="finalForm.MEM_NAME.value = this.value" type="text" name="MEM_NAME" placeholder="Full Name" required class="form"><br>
                    <label for="MEM_NAME">OR NUMBER</label><input onchange="finalForm.OR_NUM.value = this.value" type="text" name="OR_NUM" placeholder="OR NUM" required class="form"><br>
                    <p>Use of Property</p><br>
                    <fieldset>  
                        <label for="PRP_USE"><input onclick="finalForm.PRP_USE.value = this.value;form4.BUS_NAME.disabled = true;form4.BUS_TYPE.disabled = true;form4.BUS_NAME.value = 'N/A';form4.BUS_TYPE.value = 'N/A';" type="radio" name="PRP_USE" id="PRP_RES" value="Residential">Residential</label>
                        <label for="PRP_USE"><input onclick="finalForm.PRP_USE.value = this.value;form4.BUS_NAME.disabled = false;form4.BUS_TYPE.disabled = false;form4.BUS_NAME.value = '';form4.BUS_TYPE.value = '';" type="radio" name="PRP_USE" id="PRP_BUS" value="Business">Business</label>
                        <label for="PRP_USE" id="form-margin-medium"><input onclick="finalForm.PRP_USE.value = this.value;form4.BUS_NAME.disabled = false;form4.BUS_TYPE.disabled = false;form4.BUS_NAME.value = '';form4.BUS_TYPE.value = '';" type="radio" name="PRP_USE" id="PRP_BOTH" value="Both">Both</label>
                    </fieldset><br>
                    <label for="BUS_NAME">If used for business, registered name of business:</label><input onchange="finalForm.BUS_NAME.value = this.value" type="text" name="BUS_NAME" placeholder="Business Name" required class="form"><br>
                    <label for="BUS_TYPE">Type of business:</label><input onchange="finalForm.BUS_TYPE.value = this.value" type="text" name="BUS_TYPE" placeholder="Business Type" required class="form"><br>
                    <br>
                    <div class="button-container">
                        <input id="Next4" class="button-design" type="button" value="Submit" style="margin-right: 10%;">
                        <input id="Back4" class="button-design-reject" type="button" value="Back">
                    </div>
                    <br>
                </form>

                <form id="finalForm" action="CreateHomeowner" method="POST">
                    <input type="hidden" name="HO_LN"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_FN"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_MI"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_AGE"> <!-- USER -->
                    <input type="hidden" name="OR_NUM"> <!-- USER -->
                    <input type="hidden" name="HO_HOUSENUM"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_STREET"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_VILLAGE"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_BARANGAY"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_CITY"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_PROVINCE"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_EMAIL"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_LANDLINE"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_PHONE"><!-- HOMEOWNER -->
                    <input type="hidden" name="USER_HOUSENUM"><!-- USERLOT -->
                    <input type="hidden" name="USER_STREET"><!-- USERLOT -->
                    <input type="hidden" name="USER_VILLAGE"><!-- USERLOT -->
                    <input type="hidden" name="USER_BARANGAY"><!-- USERLOT -->
                    <input type="hidden" name="USER_CITY"><!-- USERLOT -->
                    <input type="hidden" name="USER_PROVINCE"><!-- USERLOT -->
                    <input type="hidden" name="HO_DATE"> <!-- USER -->
                    <input type="hidden" name="TIT_NUM"><!--USERLOT-->
                    <input type="hidden" name="TIT_SURNUM"><!--USERLOT-->
                    <input type="hidden" name="TIT_LOTNUM"><!--USERLOT-->
                    <input type="hidden" name="TIT_NAME"><!--USERLOT-->
                    <input type="hidden" name="TIT_DATE"><!--USERLOT-->
                    <input type="hidden" name="TIT_AREA"><!--USERLOT-->
                    <input type="hidden" name="PRP_INDEX"><!--TAXDECINFO-->
                    <input type="hidden" name="TAX_NUM"><!--TAXDECINFO-->
                    <input type="hidden" name="PAID_MEM"><!--KHAMEMBERSHIP-->
                    <input type="hidden" name="PAID_DATE"><!--KHAMEMBERSHIP-->
                    <input type="hidden" name="MEM_NAME"><!--KHAMEMBERSHIP-->
                    <input type="hidden" name="PRP_USE"><!--PROPERTYUSE-->
                    <input type="hidden" name="BUS_NAME"><!--PROPERTYUSE-->
                    <input type="hidden" name="BUS_TYPE"><!--PROPERTYUSE-->
                </form>
            </div>
        </div>
        <script>
            window.onload = function () {
                if (new URLSearchParams(window.location.search).get('suc') === 'true') {
                    alert('Successfully added Homeowner to the records.');
                    window.location.href = 'records.jsp';
                }
            };

            var form1 = document.getElementById("form1");
            var form2 = document.getElementById("form2");
            var form3 = document.getElementById("form3");
            var form4 = document.getElementById("form4");
            var finalForm = document.getElementById('finalForm');

            var Next1 = document.getElementById("Next1");
            var Back1 = document.getElementById("Back1");
            var Next2 = document.getElementById("Next2");
            var Back2 = document.getElementById("Back2");
            var Next3 = document.getElementById("Next3");
            var Back3 = document.getElementById("Back3");
            var Next4 = document.getElementById("Next4");
            var Back4 = document.getElementById("Back4");

            Next1.onclick = function () {
                const f1 = [
                    {name: "HO_LN", message: "Missing Last Name."},
                    {name: "HO_FN", message: "Missing First Name."},
                    {name: "HO_MI", message: "Missing Middle Initial."},
                    {name: "HO_AGE", message: "Missing Age."},
                    {name: "HO_EMAIL", message: "Missing Email."},
                    {name: "HO_LANDLINE", message: "Missing Landline."},
                    {name: "HO_PHONE", message: "Missing Phone Number."}
                ];
                for (let i = 0; i < f1.length; i++) {
                    const field = f1[i];
                    const inputField = form1[field.name];
                    console.log("Checking " + field.name);
                    if (inputField.value === "") {
                        alert(field.message);
                        return false;
                    }
                    finalForm[field.name].value = inputField.value;
                }
                // If all fields are filled
                form1.style.left = "-1000px";
                form2.style.left = "32.5%";
                progress.style.width = "50%";

            };

            Back2.onclick = function () {
                form1.style.left = "32.5%";
                form2.style.left = "1000px";
                progress.style.width = "25%";
            };

            Next2.onclick = function () {
                const f2 = [
                    {name: "HO_HOUSENUM", message: "Missing House Number."},
                    {name: "HO_STREET", message: "Missing Street Name."},
                    {name: "HO_VILLAGE", message: "Missing Village Name."},
                    {name: "HO_BARANGAY", message: "Missing Barangay."},
                    {name: "HO_CITY", message: "Missing City."},
                    {name: "HO_PROVINCE", message: "Missing Province."},
                    {name: "USER_HOUSENUM", message: "Missing Lot House Number."},
                    {name: "USER_STREET", message: "Missing Lot Street Name."},
                    {name: "USER_VILLAGE", message: "Missing Lot Village Name."},
                    {name: "USER_BARANGAY", message: "Missing Lot Barangay."},
                    {name: "USER_CITY", message: "Missing Lot City."},
                    {name: "USER_PROVINCE", message: "Missing Lot Province."},
                    {name: "HO_DATE", message: "Missing Occupation Date."}
                ];
                for (let i = 0; i < f2.length; i++) {
                    const field = f2[i];
                    const inputField = form2[field.name];
                    console.log("Checking " + field.name);
                    if (inputField.value === "") {
                        alert(field.message);
                        return false;
                    }
                    finalForm[field.name].value = inputField.value;
                }
                form2.style.left = "-1000px";
                form3.style.left = "32.5%";
                progress.style.width = "75%";
            };

            Back3.onclick = function () {
                form2.style.left = "32.5%";
                form3.style.left = "1000px";
                progress.style.width = "50%";
            };

            Next3.onclick = function () {
                const f3 = [
                    {name: "TIT_NUM", message: "Missing Title Number."},
                    {name: "TIT_SURNUM", message: "Missing Survey Number."},
                    {name: "TIT_LOTNUM", message: "Missing Lot Number."},
                    {name: "TIT_NAME", message: "Missing Registered Name."},
                    {name: "TIT_DATE", message: "Missing Title Date."},
                    {name: "TIT_AREA", message: "Missing Area."},
                    {name: "PRP_INDEX", message: "Missing Property Index."},
                    {name: "TAX_NUM", message: "Missing Tax Number."}
                ];
                for (let i = 0; i < f3.length; i++) {
                    const field = f3[i];
                    const inputField = form3[field.name];
                    console.log("Checking " + field.name);
                    if (inputField.value === "") {
                        alert(field.message);
                        return false;
                    }
                    finalForm[field.name].value = inputField.value;
                }
                form3.style.left = "-1000px";
                form4.style.left = "32.5%";
                progress.style.width = "100%";
            };

            Back4.onclick = function () {
                form3.style.left = "32.5%";
                form4.style.left = "1000px";
                progress.style.width = "75%";
            };

            Next4.onclick = function () {
                const f4 = [
                    {name: "PAID_MEM", message: "Missing Membership Payment Information."},
                    {name: "PAID_DATE", message: "Missing Membership Payment Date."},
                    {name: "MEM_NAME", message: "Missing Member Name."},
                    {name: "OR_NUM", message: "Missing Official Receipt Number."},
                    {name: "PRP_USE", message: "Missing Property Use Information."},
                    {name: "BUS_NAME", message: "Missing Business Name."},
                    {name: "BUS_TYPE", message: "Missing Business Type."}
                ];
                for (let i = 0; i < f4.length; i++) {
                    const field = f4[i];
                    const inputField = form4[field.name];
                    console.log("Checking " + field.name);
                    if (inputField.value === "") {
                        alert(field.message);
                        return false;
                    }
                    finalForm[field.name].value = inputField.value;
                }

                if (confirm('Are you sure all the information are correct and want to submit this form?')) {
                    finalForm.submit();
                }
            };

            /*Next4.onclick = function(){
             form4.style.left = "-1000px";
             form5.style.left = "32.5%";
             progress.style.width = "100%";
             }*/
        </script>
    </body>
</html>