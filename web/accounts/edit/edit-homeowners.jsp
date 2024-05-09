<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<!DOCTYPE html>
<%
    
    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    try {
        con = ConnectionPoolManager.getDataSource().getConnection();
        ps = con.prepareStatement("select u.*,h.* from users u join homeowner h on u.userid = h.userid where u.userid = ?;");
        ps.setString(1, request.getParameter("h"));
        rs = ps.executeQuery();
        rs.next();

%>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Edit Homeowner Account</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-big">
                <div class="step-row">
                    <div id="progress"></div>
                    <div class="step-col">Personal Info</div>
                    <div class="step-col">Current Address</div>
                </div>
                <form id='form1'>
                    <h1 class="h1-bold" id="h1small">Homeowner Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_FN">First Name</label><input value="<%=rs.getString("firstname")%>" onchange="finalForm.HO_FN.value = this.value" type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                    <label for="HO_LN">Last Name</label><input value="<%=rs.getString("lastname")%>" onchange="finalForm.HO_LN.value = this.value" type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE" class="marginAge">Age</label><br>
                    <input value="<%=rs.getString("middleinitial")%>" onchange="finalForm.HO_MI.value = this.value" type="text" type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input value="<%=rs.getString("age")%>" onchange="finalForm.HO_AGE.value = this.value" type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="HO_EMAIL">Email Address</label><input value="<%=rs.getString("email")%>" onchange="finalForm.HO_EMAIL.value = this.value" type="text" name="HO_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="TIT_DATE" id="label-margin-medium">Landline Number</label><label for="HO_LANDNO" class="marginMobile">Mobile Number</label><br>
                    <input value="<%=rs.getString("landlineno")%>" onchange="finalForm.HO_LANDLINE.value = this.value" type="text" name="HO_LANDLINE" placeholder="Landline Number" class="form-medium" id="form-margin-medium"><input value="<%=rs.getString("mobileno")%>" onchange="finalForm.HO_PHONE.value = this.value" type="text" name="HO_PHONE" placeholder="Mobile Number" class="form-medium"><br>
                    <br><br><br><br>
                    <div class="button-container">
                        <input class="button-design-reject" type="button" value="Cancel" style="margin-right: 10%;" onclick="window.location.href = '${root}/accounts/choose/homeowners.jsp'" id="button-small">
                        <input id="Next1" class="button-design" type="button" value="Next">
                    </div>
                </form>

                <form id='form2'>
                    <h1 class="h1-bold" id="h1small">H.O. Address</h1>
                    <div class="line"></div><br>
                    <p>Homeowner Address</p>
                    <label for="HO_HOUSENUM" id="label-margin-medium">House Number</label><label for="HO_STREET" class="marginStreet">Street Name</label><br>
                    <input value="<%=rs.getString("houseno")%>" onchange="finalForm.HO_HOUSENUM.value = this.value" type="text" name="HO_HOUSENUM" placeholder="House Number" class="form-medium" id="form-margin-medium"><input value="<%=rs.getString("streetname")%>" onchange="finalForm.HO_STREET.value = this.value" type="text" name="HO_STREET" placeholder="Street Name"  class="form-medium"><br>
                    <label for="HO_VILLAGE" id="label-margin-medium">Village</label><label for="HO_BARANGAY" class="marginVehicleYear">Barangay</label><br>
                    <input value="<%=rs.getString("village")%>" onchange="finalForm.HO_VILLAGE.value = this.value" type="text" name="HO_VILLAGE" placeholder="Village" class="form-medium" id="form-margin-medium"><input value="<%=rs.getString("barangay")%>" onchange="finalForm.HO_BARANGAY.value = this.value" type="text" name="HO_BARANGAY" placeholder="Barangay"  class="form-medium"><br>
                    <label for="HO_CITY" id="label-margin-medium">City</label><label for="HO_PROVINCE" class="marginProvince">Province</label><br>
                    <input value="<%=rs.getString("city")%>" onchange="finalForm.HO_CITY.value = this.value" type="text" name="HO_CITY" placeholder="City" class="form-medium" id="form-margin-medium"><input value="<%=rs.getString("province")%>" onchange="finalForm.HO_PROVINCE.value = this.value" type="text" name="HO_PROVINCE" placeholder="Province"  class="form-medium"><br>
                    <div class="button-container">
                        <input id="Back2" class="button-design-reject" type="button" value="Back" style="margin-right: 10%;">
                        <input id="Next2" class="button-design" type="button" value="Submit">
                    </div>
                </form>  

                <form id="finalForm" action="${root}/EditHomeowner" method="POST">
                    <input type="hidden" name="USERID" value="<%= rs.getString("userid")%>"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_LN"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_FN"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_MI"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_AGE"> <!-- USER -->
                    <input type="hidden" name="HO_HOUSENUM"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_STREET"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_VILLAGE"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_BARANGAY"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_CITY"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_PROVINCE"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_EMAIL"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_LANDLINE"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_PHONE"><!-- HOMEOWNER -->
                </form>
            </div>
        </div>
        <%            
            } catch (SQLException sqle) {
                System.out.println("SQLException IN error occured - " + sqle.getMessage());
                response.sendError(500);
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException sqle) {
                    System.out.println("SQLException OUT error occured - " + sqle.getMessage());
                    response.sendError(500);
                }
            }   
        %>
        <script>
            window.onload = function () {
                progress.style.width = "50%";
                var params = new URLSearchParams(window.location.search);
                if (params.get('suc') === 'true') {
                    alert('Successfully edited Homeowner in the records.');
                    window.location.href = '${root}/admin/accounts.jsp';
                }
                if (params.get('err') == 1) {
                    alert('Record already exists or there is a conflicting record in the database.');
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
                progress.style.width = "100%";

            };

            Back2.onclick = function () {
                form1.style.left = "32.5%";
                form2.style.left = "1000px";
                progress.style.width = "50%";
            };

            Next2.onclick = function () {
                const f2 = [
                    {name: "HO_HOUSENUM", message: "Missing House Number."},
                    {name: "HO_STREET", message: "Missing Street Name."},
                    {name: "HO_VILLAGE", message: "Missing Village Name."},
                    {name: "HO_BARANGAY", message: "Missing Barangay."},
                    {name: "HO_CITY", message: "Missing City."},
                    {name: "HO_PROVINCE", message: "Missing Province."}
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
                if (confirm('Are you sure all the information are correct and want to submit this form?')) {
                    finalForm.submit();
                }
            };

        </script>
    </body>
</html>