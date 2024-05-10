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
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect(root + "/accounts/login.jsp");
    }
    String goBack = request.getContextPath() + "/staff/records-vehicles.jsp";

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
        <title>KHA | Vehicle Edit</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <%            String vhid = request.getParameter("VHID");
            System.out.println("vhid = " + vhid);
        %>
        <div class="main-body">
            <div class="signup-box-small">
                <form style="left: 32.5%;" action="${root}\UpdateInfo">
                    <h1 class="h1-bold">Edit Vehicle Information</h1>
                    <div class="line"></div><br>
                    <div class="changepass-label-container">
                        <label for="VEH_PLATE" id="label-margin-medium">Plate No.</label><label for="VEH_TYPE" class="marginVehicleType">Type of Vehicle</label><br>
                        <input type="text" name="VEH_PLATE" placeholder="Plate No." class="form-medium" id="form-margin-medium"><input type="text" name="VEH_TYPE" placeholder="Vehicle Type" class="form-medium"><br>
                        <label for="VEH_BRAND" id="label-margin-medium">Brand</label><label for="VEH_MODEL" class="marginVehicleYear">Year/Model</label><br>
                        <input type="text" name="VEH_BRAND" placeholder="Vehicle Brand" class="form-medium" id="form-margin-medium"><input type="text" name="VEH_MODEL" placeholder="Vehicle Model" class="form-medium"><br>
                        <label for="VEH_OWNER">Registered Owner</label><input type="text" name="VEH_OWNER" placeholder="Vehicle Owner" class="form"><br>  
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
                        <div class="upload_files form_input_title" id="form_container">
                            <p style="text-align: center">Upload Digital Copy of Required Documents</p>
                            <input type="file" class="file_button" name="FILES_UPLOAD" id="input-none" accept="image/*,.pdf" multiple style="margin-left: 33%">
                        </div>
                    </div>
                    <br>
                    <input type="hidden" name="VHID" value="<%=vhid%>">
                    <input type="hidden" name="FORM_NO" value="6"> 
                    <div class="button-container" >
                        <%
                            out.print("<input class=\"button-design-reject\" type=\"button\" value=\"Cancel\" id=\"button-small\" style=\"margin-right: 10%;\" onclick=\"location.href='" + goBack + "'\">");
                        %>                                                   
                        <input class="button-design" type="submit" value="Save" id="button-small">
                    </div>
                </form> 
            </div>
        </div>
    </body>
    <style>
        body {
            zoom: 80%;
        }
    </style>
</html>