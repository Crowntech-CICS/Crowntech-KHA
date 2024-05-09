<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    Connection conn = ConnectionPoolManager.getDataSource().getConnection();
    String query = "select propertyid,houseno,streetname from userlot order by streetname asc;";
    PreparedStatement ps = conn.prepareStatement(query);
    String area = request.getParameter("area");
    if(area !=  null){
        query = "select propertyid,houseno,streetname from userlot where area = ? order by streetname asc;";
        ps = conn.prepareStatement(query);
        ps.setString(1, area);
        request.setAttribute("area", area);
    }            
    ResultSet rs = ps.executeQuery();
    String[] areas = {"1","1A","2","3","4","5","5A","6","7","8","9","10","11E","11W","12"};
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Create Resident Account</title>
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
                    <h1 class="h1-bold" id="h1small">Resident     Information</h1>
                    <div class="line"></div><br>
                    <label for="RES_PROP">Address</label>
                    <div style="display: flex;">
                        <select style="flex:20%;" onchange="window.location.href = '${root}/accounts/signup/signup-resident.jsp?area=' + this.value" type="text" name="RES_AREA" placeholder="Area" class="form">
                            <% if(area != null){%>
                                <option value="${area}">${area} - Selected</option>
                            <%} else{%>
                                <option value="">Area</option>
                            <%}
                                for (int i = 0; i < areas.length; i++) {%>
                                        <option value="<%= areas[i]%>"><%= areas[i]%></option>
                            <%    }
                            %>
                        </select>
                        <select onchange="finalForm.RES_PROP.value = this.value" type="text" name="RES_PROP" placeholder="Address" class="form">
                            <option value="" selected disabled>Address</option>
                        <%  while(rs.next()){ %>
                            <option value="">Address</option>
                        <%  }
                            rs.close();
                            ps.close();
                            conn.close();
                        %>
                        </select>
                    </div>
                    <label for="RES_FN">First Name</label><input onchange="finalForm.RES_FN.value = this.value" type="text" name="RES_FN" placeholder="First Name" class="form"><br>
                    <label for="RES_LN">Last Name</label><input onchange="finalForm.RES_LN.value = this.value" type="text" name="RES_LN" placeholder="Last Name" class="form"><br>
                    <label for="RES_MI" id="label-margin">Middle Initial</label><label for="RES_AGE" class="marginAge">Age</label><br>
                    <input onchange="finalForm.RES_MI.value = this.value" type="text" type="text" name="RES_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input onchange="finalForm.RES_AGE.value = this.value" type="number" name="RES_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                    <label for="RES_EMAIL">Email Address</label><input onchange="finalForm.RES_EMAIL.value = this.value" type="text" name="RES_EMAIL" placeholder="Email Address" required class="form"><br>
                    <label for="RES_REL"">Relationship with Homeowner</label>
                    <select name="RES_REL" id="" class="form" onchange="finalForm.RES_REL.value = this.value">
                        <option value="" selected disabled>Relationship</option>
                        <option value="Spouse">Spouse</option>
                        <option value="Son/Daughter">Son/Daughter</option>
                        <option value="Grandchild">Grandchild</option>
                        <option value="Househelp">Househelp</option>
                        <option value="Renter">Renter</option>
                        <option value="Parent">Parent</option>
                        <option value="Friend">Friend</option>
                    </select>
                    <br><br>
                    <div class="button-container">
                        <input class="button-design-reject" type="button" value="Cancel" style="margin-right: 10%;" onclick="window.location.href = '${root}/admin/accounts.jsp'" id="button-small">
                        <input id="Next1" class="button-design" type="button" value="Submit">
                    </div>
                </form>

                <form id="finalForm" action="${root}/CreateResident" method="POST">
                    <input type="hidden" name="RES_PROP"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_LN"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_FN"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_MI"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_AGE"> <!-- USER -->
                    <input type="hidden" name="RES_EMAIL"><!-- HOMEOWNER -->
                    <input type="hidden" name="RES_REL"><!-- HOMEOWNER -->
                </form>
            </div>
        </div>
        <script>
            window.onload = function () {
                var params = new URLSearchParams(window.location.search);
                if (params.get('suc') === 'true') {
                    alert('Successfully added Resident in the records.');
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
                    {name: "RES_PROP", message: "Please select the address of the resident."},
                    {name: "RES_LN", message: "Missing Last Name."},
                    {name: "RES_FN", message: "Missing First Name."},
                    {name: "RES_MI", message: "Missing Middle Initial."},
                    {name: "RES_AGE", message: "Missing Age."},
                    {name: "RES_EMAIL", message: "Missing Email."},
                    {name: "RES_REL", message: "Invalid Relationship."}
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
                if(confirm('Are you sure these information you are trying to submit are correct?')){
                    finalForm.submit();
                }
            };
            
        </script>      
    </body>
</html>