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
            <div class="signup-box-small">
                <form id='form1'>
                    <h1 class="h1-bold" id="h1small">Resident     Information</h1>
                    <div class="line"></div><br>
                    <label for="RES_FN">First Name</label><input onchange="finalForm.RES_FN.value = this.value" type="text" name="RES_FN" placeholder="First Name" class="form"><br>
                    <label for="RES_LN">Last Name</label><input onchange="finalForm.RES_LN.value = this.value" type="text" name="RES_LN" placeholder="Last Name" class="form"><br>
                    <label for="RES_MI" id="label-margin">Middle Initial</label><label for="RES_AGE" class="marginAge">Age</label><br>
                    <input onchange="finalForm.RES_MI.value = this.value" type="text" type="text" name="RES_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input onchange="finalForm.RES_AGE.value = this.value" type="number" name="RES_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="RES_EMAIL">Email Address</label><input onchange="finalForm.RES_EMAIL.value = this.value" type="text" name="RES_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="RES_LANDNO" class="marginMobile">Mobile Number</label><br>
                    <input onchange="finalForm.RES_LANDLINE.value = this.value" type="text" name="RES_LANDLINE" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input onchange="finalForm.RES_PHONE.value = this.value" type="text" name="RES_PHONE" placeholder="Mobile Number" class="form-medium"><br>
                    <label for="LE_REL"">Relationship with Homeowner</label>
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
                    <br><br><br>
                    <div class="button-container">
                        <input class="button-design-reject" type="button" value="Cancel" style="margin-right: 10%;" onclick="window.location.href = 'records.jsp'" id="button-small">
                        <input id="Next1" class="button-design" type="button" value="Next">
                    </div>
                </form>

                <form id="finalForm" action="CreateHomeowner" method="POST">
                    <input type="hidden" name="RES_LN"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_FN"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_MI"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_AGE"> <!-- USER -->
                    <input type="hidden" name="RES_EMAIL"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_LANDLINE"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_PHONE"><!-- HOMEOWNER -->
                </form>
            </div>
        </div>
        <script>
            window.onload = function () {
                var params = new URLSearchParams(window.location.search);
                if (params.get('suc') === 'true') {
                    alert('Successfully added Homeowner to the records.');
                    window.location.href = 'records.jsp';
                }
                if (params.get('err') == 1) {
                    alert('Record already exists or there is a conflicting record in the database.');
                }
            };

            var form1 = document.getElementById("form1");
            var finalForm = document.getElementById('finalForm');

            var Next1 = document.getElementById("Next1");
            var Back1 = document.getElementById("Back1");

            Next1.onclick = function () {
                const f1 = [
                    {name: "RES_LN", message: "Missing Last Name."},
                    {name: "RES_FN", message: "Missing First Name."},
                    {name: "RES_MI", message: "Missing Middle Initial."},
                    {name: "RES_AGE", message: "Missing Age."},
                    {name: "RES_EMAIL", message: "Missing Email."},
                    {name: "RES_LANDLINE", message: "Missing Landline."},
                    {name: "RES_PHONE", message: "Missing Phone Number."}
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
        </script>
    </body>
</html>