<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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
    } else if (!session.getAttribute("level").equals("staff")) {
        response.sendRedirect(root + "/index.jsp");
    }
%>
<%
    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;

    String propId = request.getParameter("propID");
    System.out.println(propId);

    String lastname = "", firstname = "", middleInitial = "", address = "";
    double balance = 0;

    try {
        con = ConnectionPoolManager.getDataSource().getConnection();
        ps = con.prepareStatement("SELECT H.USERID,L.PROPERTYID,L.BALANCE, (L.HOUSENO||' '||L.STREETNAME) AS ADDRESS FROM USERLOT L LEFT JOIN HOMEOWNER H ON H.USERID = L.USERID WHERE L.PROPERTYID = ?");
        ps.setString(1, propId);
        rs = ps.executeQuery();
        if (rs.next()) {
            String userId = rs.getString("USERID").trim();
            balance = rs.getDouble("BALANCE");
            address = rs.getString("ADDRESS").trim();
            //Get name
            ps = con.prepareStatement("select lastname,firstname,middleinitial from users where userid = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                lastname = rs.getString("LASTNAME").trim();
                firstname = rs.getString("FIRSTNAME").trim();
                middleInitial = rs.getString("MIDDLEINITIAL").trim();
            }
        }

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
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Lot Payment</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-smallest">
                <form action="${root}/PayLot" style="left: 32.5%;">
                    <input type="hidden" name="PROP_ID" value="<%= propId%>">
                    <h1 class="h1-bold" id="h1small">Update Balance</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN_B">Full Name</label><input type="text" name="HO_LN_B" placeholder="Last Name" class="form" disabled value="<%= lastname + "," + firstname + " " + middleInitial%>"><br>
                    <label for="HO_FN_B">Lot Address</label><input type="text" name="HO_FN_B" placeholder="First Name" class="form" disabled value="<%= address%>"><br>
                    <label for="HO_MI_B" id="label-margin">Balance</label><br>
                    <input type="text" name="HO_MI_B" placeholder="Middle Initial" class="form-small" id="form-margin" disabled value="<%= balance%>"><br>
                    <label for="RES_REL">Balance Paid*</label><input type="number" min="0" name="PAYMENT" placeholder="Balance Paid In Numerical Form" class="form" required><br>
                    <div class="button-container">
                        <input class="button-design-reject" value="Cancel" id="button-small" style="margin-right: 10%;" onclick="location.href = 'records.jsp'">
                        <input class="button-design" type="submit" value="Update" id="button-small">
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