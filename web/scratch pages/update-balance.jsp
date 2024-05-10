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
    } else if (!session.getAttribute("level").equals("staff")) {
        response.sendRedirect(root + "/index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Update Balance</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-smallest">
                <form action="UpdateBalance" style="left: 32.5%;">
                    <h1 class="h1-bold" id="h1small">Update Balance</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN_B">Last Name</label><input type="text" name="HO_LN_B" placeholder="Last Name" class="form" required><br>
                    <label for="HO_FN_B">First Name</label><input type="text" name="HO_FN_B" placeholder="First Name" class="form" required><br>
                    <label for="HO_MI_B" id="label-margin">Middle Initial</label><br>
                    <input type="text" name="HO_MI_B" placeholder="Middle Initial" class="form-small" id="form-margin" required><br>
                    <label for="RES_REL">Balance Paid</label><input type="number" min="0" name="PAYMENT" placeholder="Balance Paid In Numerical Form" class="form" required><br>
                    <div class="button-container">
                        <input class="button-design-reject" value="Cancel" id="button-small" style="margin-right: 10%;" onclick="location.href = 'records.jsp'">
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