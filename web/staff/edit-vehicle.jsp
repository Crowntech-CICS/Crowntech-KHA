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

    ps = conn.prepareStatement("select v.*,p.* from vehicle v join userlot p on v.propertyid = p.propertyid where vehicleid = ?");
    ps.setString(1, request.getParameter("VHID"));
    ResultSet rs = ps.executeQuery();
    rs.next();
    System.out.println(rs.getBoolean("hassticker"));
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
                        <input type="text" value="<%= rs.getString("plateno")%>" name="VEH_PLATE" placeholder="Plate No." class="form-medium" id="form-margin-medium"><input value="<%= rs.getString("type")%>" type="text" name="VEH_TYPE" placeholder="Vehicle Type" class="form-medium"><br>
                        <label for="VEH_BRAND"  id="label-margin-medium">Brand</label><label for="VEH_MODEL" class="marginVehicleYear">Year/Model</label><br>
                        <input type="text" value="<%= rs.getString("brand")%>" name="VEH_BRAND" placeholder="Vehicle Brand" class="form-medium" id="form-margin-medium"><input value="<%= rs.getString("model")%>" type="text" name="VEH_MODEL" placeholder="Vehicle Model" class="form-medium"><br>
                        <label for="VEH_OWNER">Registered Owner</label><input value="<%= rs.getString("registeredname")%>" type="text" name="VEH_OWNER" placeholder="Vehicle Owner" class="form"><br>  
                        <label for="VEH_PROP">Address</label>
                        <div style="display: flex;">
                            <select style="flex:20%;" onchange="window.location.href = '${root}/staff/edit-vehicle.jsp?<%if(request.getParameter("VHID") != null){out.print("VHID=" + request.getParameter("VHID") + "&");}%>area=' + this.value" type="text" name="RES_AREA" placeholder="Area" class="form">
                                <% if (area != null) {%>
                                <option value="${area}">${area} - Selected</option>
                                <%} else {%>
                                <option value="<%= rs.getString("area")%>"><%= rs.getString("area")%></option>
                                <%}
                                    for (int i = 0; i < areas.length; i++) {%>
                                <option value="<%= areas[i]%>"><%= areas[i]%></option>
                                <%    }
                                %>
                            </select>
                            <select onchange="finalForm.RES_PROP.value = this.value" type="text" name="RES_PROP" placeholder="Address" class="form">
                                <option value="<%= rs.getString("propertyid")%>" selected disabled><%= rs.getString("houseno") + " " + rs.getString("streetname")%></option>
                                <%  while (rs0.next()) {%>
                                <option value="<%= rs0.getString("propertyid")%>"><%= rs0.getString("houseno") + " " + rs0.getString("streetname")%></option>
                                <%  }%>

                            </select>
                        </div>
                        <br><label for="VEH_STICK" id="label-margin-medium">Does the vehicle has a sticker?</label>
                        <fieldset>  
                            <label for="VEH_STICKER"><input <%if(rs.getBoolean("hassticker")) out.print("checked");%> type="radio" name="VEH_STICK" id="PRP_RES" value="true">Yes </label>
                            <label for="VEH_STICKER"><input <%if(!rs.getBoolean("hassticker")) out.print("checked");%> type="radio" name="VEH_STICK" id="PRP_BUS" value="false">No</label>
                        </fieldset>
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