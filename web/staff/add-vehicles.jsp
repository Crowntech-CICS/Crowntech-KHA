<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    String root = request.getContextPath();
    //Check Logged In State
    boolean logState = session.getAttribute("level") != null ? true : false;
    if (!logState) {
        response.sendRedirect(root + "/accounts/login.jsp");
    }
    if (session.getAttribute("level").equals("staff") || session.getAttribute("level").equals("admin")) {
        //
    } else {
        response.sendRedirect(root + "/index.jsp");
    }

    Connection conn = ConnectionPoolManager.getDataSource().getConnection();
    String query = "select propertyid,houseno,streetname from userlot order by streetname asc;";
    PreparedStatement ps = conn.prepareStatement(query);
    String area = request.getParameter("area");
    if (area != null) {
        query = "select propertyid,houseno,streetname from userlot where area = ? order by streetname asc;";
        ps = conn.prepareStatement(query);
        ps.setString(1, area);
        request.setAttribute("area", area);
    }
    ResultSet rs0 = ps.executeQuery();
    String[] areas = {"1", "1A", "2", "3", "4", "5", "5A", "6", "7", "8", "9", "10", "11E", "11W", "12"};

    ps = conn.prepareStatement("select u.*,r.* from users u join residents r on u.userid = r.userid where u.userid = ?");
    ps.setString(1, request.getParameter("r"));
    ResultSet rs = ps.executeQuery();
    rs.next();
    ps = conn.prepareStatement("select * from userlot where propertyid = ?");
    ps.setString(1, rs.getString("propertyid"));
    ResultSet rs2 = ps.executeQuery();
    rs2.next();
    area = rs2.getString("area");
    request.setAttribute("area", rs2.getString("area"));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Create Homeowner Account</title>
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
                    <h1 class="h1-bold">Vehicle Information</h1>
                    <div class="changepass-label-container">
                        <label for="VEH_OWNER">Registered Owner (Full Name)*</label><input type="text" name="VEH_OWNER" placeholder="Vehicle Owner" required class="form"><br>
                        <label for="VEH_PLATE" id="label-margin-medium">Plate No.*</label><label for="VEH_TYPE" style="margin-left: 4.3%;">Type of Vehicle</label><br>
                        <input type="text" name="VEH_PLATE" placeholder="Plate No." class="form-medium" id="form-margin-medium"><input type="text" name="VEH_TYPE" placeholder="Vehicle Type" required class="form-medium"><br>
                        <label for="VEH_BRAND" id="label-margin-medium">Brand*</label><label for="VEH_MODEL" style="margin-left: 10%;">Year/Model</label><br>
                        <input type="text" name="VEH_BRAND" placeholder="Vehicle Brand" class="form-medium" id="form-margin-medium"><input type="text" name="VEH_MODEL" placeholder="Vehicle Model" required class="form-medium"><br>
                        <label for="VEH_PROP">Address</label>
                        <div style="display: flex;">
                            <select style="flex:20%;" onchange="window.location.href = '${root}/accounts/signup/signup-resident.jsp?r=<%=request.getParameter("r")%>&area=' + this.value" type="text" name="RES_AREA" placeholder="Area" class="form">
                                <% if (area != null) {%>
                                <option value="${area}">${area} - Selected</option>
                                <%} else {%>
                                <option value="">Area</option>
                                <%}
                                for (int i = 0; i < areas.length; i++) {%>
                                <option value="<%= areas[i]%>"><%= areas[i]%></option>
                                <%    }
                                %>
                            </select>
                            <select onchange="finalForm.RES_PROP.value = this.value" type="text" name="RES_PROP" placeholder="Address" class="form">
                                <option value="<%= rs.getString("propertyid")%>" selected disabled><%= rs2.getString("houseno") + " " + rs2.getString("streetname")%></option>
                                <%  while (rs0.next()) {%>
                                <option value="<%= rs0.getString("propertyid")%>"><%= rs0.getString("houseno") + " " + rs0.getString("streetname")%></option>
                                <%  }%>

                            </select>
                        </div>
                        <br><label for="VEH_BRAND" id="label-margin-medium">Does the vehicle has a sticker?</label>
                        <fieldset>  
                            <label for="VEH_STICKER"><input type="radio" name="PRP_USE" id="PRP_RES" value="Residential">Yes </label>
                            <label for="VEH_STICKER"><input type="radio" name="PRP_USE" id="PRP_BUS" value="Business">No</label>
                        </fieldset>
                        <br>
                        <div class="upload_files" id="form_container" class="form_input_title">
                            <p style="text-align: center">Upload Digital Copy of Required Documents</p>
                            <input type="file" class="file_button" name="FILES_UPLOAD" id="input-none" accept="image/*,.pdf" multiple style="margin-left: 33%">
                        </div>
                    </div>
                    <input type="hidden" name="FORM_NO" value="7"> 
                    <br>
                    <div class="button-container">
                        <input id="Next6" type="submit" class="button-design" value="Apply" style="margin-right: 10%;">
                        <input id="Back6" class="button-design-reject" type="button" value="Cancel">
                    </div>
                </form>

                <form id="finalForm" action="${root}/UpdateInfo" method="POST">
                    <input type="hidden" name="VEH_OWNER"><!-- HOMEOWNER -->
                    <input type="hidden" name="VEH_PLATE"><!-- HOMEOWNER -->
                    <input type="hidden" name="VEH_TYPE"><!-- HOMEOWNER -->
                    <input type="hidden" name="VEH_BRAND"> <!-- USER -->
                    <input type="hidden" name="VEH_MODEL"><!-- HOMEOWNER -->
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
                    {name: "VEH_OWNER", message: "Missing Owner's Name."},
                    {name: "VEH_PLATE", message: "Missing Plate Number."},
                    {name: "VEH_TYPE", message: "Missing Vehicle Type."},
                    {name: "VEH_BRAND", message: "Missing Vehicle Brand."},
                    {name: "VEH_MODEL", message: "Missing Vehicle Model."},
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