<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Create Admin Account</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-small">
                <form id='form1'>
                    <h1 class="h1-bold" id="h1small">Admin Account Information</h1>
                    <div class="line"></div><br>
                    <label for="ADMIN_FN">First Name*</label><input onchange="finalForm.ADMIN_FN.value = this.value" type="text" name="ADMIN_FN" placeholder="First Name" class="form"><br>
                    <label for="ADMIN_LN">Last Name*</label><input onchange="finalForm.ADMIN_LN.value = this.value" type="text" name="ADMIN_LN" placeholder="Last Name" class="form"><br>
                    <label for="ADMIN_MI" id="label-margin">Middle Initial*</label><label for="ADMIN_AGE" class="marginAge">Age*</label><br>
                    <input onchange="finalForm.ADMIN_MI.value = this.value" type="text" type="text" name="ADMIN_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input onchange="finalForm.ADMIN_AGE.value = this.value" type="number" name="ADMIN_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="ADMIN_EMAIL">Email Address*</label><input onchange="finalForm.ADMIN_EMAIL.value = this.value" type="text" name="ADMIN_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="ADMIN_ROLE"">Admin Role*</label>
                    <select name="ADMIN_ROLE" id="" class="form" onchange="finalForm.ADMIN_ROLE.value = this.value">
                        <option value="" selected disabled>Role</option>
                        <option value="Admin">System Admin</option>
                        <option value="Board of Director">Board of Director</option>
                        <option value="Staff">Staff</option>
                    </select>
                    <br><br><br>
                    <div class="button-container">
                        <input class="button-design-reject" type="button" value="Cancel" style="margin-right: 10%;" onclick="window.location.href = '${root}/admin/accounts.jsp'" id="button-small">
                        <input id="Next1" class="button-design" type="button" value="Submit">
                    </div>
                </form>

                <form id="finalForm" action="${root}/CreateAdmin" method="POST">
                    <input type="hidden" name="ADMIN_LN"><!-- ADMIN -->
                    <input type="hidden" name="ADMIN_FN"><!-- ADMIN -->
                    <input type="hidden" name="ADMIN_MI"><!-- ADMIN -->
                    <input type="hidden" name="ADMIN_AGE"> <!-- ADMIN -->
                    <input type="hidden" name="ADMIN_EMAIL"><!-- ADMIN -->
                    <input type="hidden" name="ADMIN_ROLE"><!-- ADMIN -->
                </form>
            </div>
        </div>
        <style>
            body {
                zoom: 80%;
            }
        </style>
        <script>
            window.onload = function () {
                var params = new URLSearchParams(window.location.search);
                if (params.get('suc') === 'true') {
                    var level = params.get('l');
                    alert('Successfully added ' + level + ' to the records.');
                                window.location.href = '${root}/admin/accounts.jsp';
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
                    {name: "ADMIN_LN", message: "Missing Last Name."},
                    {name: "ADMIN_FN", message: "Missing First Name."},
                    {name: "ADMIN_MI", message: "Missing Middle Initial."},
                    {name: "ADMIN_AGE", message: "Missing Age."},
                    {name: "ADMIN_EMAIL", message: "Missing Email."},
                    {name: "ADMIN_ROLE", message: "Invalid Role selected."}
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
                if (confirm('Are you sure these information you are trying to submit are correct?')) {
                    finalForm.submit();
                }

            };
        </script>
    </body>
</html>