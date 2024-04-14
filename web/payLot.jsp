<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    //Connect to DB
    try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
            String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
                   password = getServletContext().getInitParameter("dbPassword"),
                   driverURL = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(driverURL, username, password); //create connection
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - " + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - " + nfe.getMessage());
    }
    
    String propId = request.getParameter("propID");
    System.out.println(propId);
    String homeownerId = "";
    String lastname = "";
    String firstname = "";
    String middleInitial = "";
    Double balance = 0.0;
    String address = "";
    try {
        ps = con.prepareStatement("SELECT H.HOMEOWNERID,L.PROPERTYID,H.LASTNAME,H.FIRSTNAME,H.MIDDLEINITIAL,L.BALANCE, (L.HOUSENO||' '||L.STREETNAME) AS ADDRESS FROM USERLOT L LEFT JOIN HOMEOWNER H ON H.HOMEOWNERID = L.HOMEOWNERID WHERE L.PROPERTYID = ?");
        ps.setString(1, propId);
        rs = ps.executeQuery();
        if(rs.next()) {
            homeownerId = rs.getString("HOMEOWNERID").trim();
            lastname = rs.getString("LASTNAME").trim();
            firstname  = rs.getString("FIRSTNAME").trim();
            middleInitial = rs.getString("MIDDLEINITIAL").trim();
            balance = rs.getDouble("BALANCE");
            address = rs.getString("ADDRESS").trim();
        }
            
    } catch(SQLException sqle){
        System.out.println("SQLException IN error occured - " + sqle.getMessage());
        response.sendError(500);
    } finally {
        try {
            if(rs != null)
                rs.close();
            if(ps != null)
                ps.close();
            if(con != null)
                con.close();
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
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-smallest">
                <form action="PayLot" style="left: 32.5%;">
                    <input type="hidden" name="PROP_ID" value="<%= propId %>">
                    <h1 class="h1-bold" id="h1small">Update Balance</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN_B">Full Name</label><input type="text" name="HO_LN_B" placeholder="Last Name" class="form" disabled value="<%= lastname + "," + firstname + " " + middleInitial  %>"><br>
                    <label for="HO_FN_B">Lot Address</label><input type="text" name="HO_FN_B" placeholder="First Name" class="form" disabled value="<%= address %>"><br>
                    <label for="HO_MI_B" id="label-margin">BALANCE</label><br>
                    <input type="text" name="HO_MI_B" placeholder="Middle Initial" class="form-small" id="form-margin" disabled value="<%= balance %>"><br>
                    <label for="RES_REL">Balance Paid</label><input type="number" min="0" name="PAYMENT" placeholder="Balance Paid In Numerical Form" class="form" required><br>
                    <div class="button-container">
                        <input class="button-design" type="submit" value="Update" id="button-small" style="margin-right: 10%;">
                        <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'records.jsp'">
                    </div>
                </form>  
            </div>
        </div>
    </body>
</html>