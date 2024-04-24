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
        <title>KHA | Vehicle Edit</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <% 
            String vhid = request.getParameter("VHID");
        %>
        <div class="main-body">
            <div class="signup-box-small">
                <form style="left: 32.5%;" action="UpdateInfo">
                    <h1 class="h1-bold">Edit Vehicle Information</h1>
                    <div class="line"></div><br>
                    <div class="changepass-label-container">
                        <label for="VEH_PLATE" id="label-margin-medium">Plate No.</label><label for="VEH_TYPE" class="marginVehicleType">Type of Vehicle</label><br>
                        <input type="text" name="VEH_PLATE" placeholder="Plate No." class="form-medium" id="form-margin-medium"><input type="text" name="VEH_TYPE" placeholder="Vehicle Type" required class="form-medium"><br>
                        <label for="VEH_BRAND" id="label-margin-medium">Brand</label><label for="VEH_MODEL" class="marginVehicleYear">Year/Model</label><br>
                        <input type="text" name="VEH_BRAND" placeholder="Vehicle Brand" class="form-medium" id="form-margin-medium"><input type="text" name="VEH_MODEL" placeholder="Vehicle Model" required class="form-medium"><br>
                        <label for="VEH_OWNER">Registered Owner</label><input type="text" name="VEH_OWNER" placeholder="Vehicle Owner" required class="form"><br>  
                        <br>
                        <div class="upload_files form_input_title" id="form_container">
                            <p style="text-align: center">Upload Digital Copy of Required Documents</p>
                            <input type="file" class="file_button" name="FILES_UPLOAD" id="input-none" accept="image/*,.pdf" multiple style="margin-left: 33%">
                        </div>
                    </div>
                    <br>
                    <input type="hidden" name="VHID" value="<%=vhid%>">
                    <input type="hidden" name="FORM_NO" value="6"> 
                <div class="button-container" >
                    <input class="button-design-reject" type="button" value="Cancel" id="button-small" style="margin-right: 10%;" onclick="location.href = 'vehicles.jsp'">
                    <input class="button-design" type="submit" value="Save" id="button-small">
                </div>
                </form> 
            </div>
        </div>
    </body>
</html>