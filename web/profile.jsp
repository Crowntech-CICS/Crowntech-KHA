
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Profile</title>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/profile-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <%
            Connection con = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
            String fullName = null;
            String hoID = null;
            String resClass = null;
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
            try {
                ps = con.prepareStatement("SELECT * FROM USERS WHERE USERID = ?");
                ps.setString(1, (String) session.getAttribute("currID"));
                System.out.println("currID: " + (String) session.getAttribute("currID"));
                rs = ps.executeQuery();
                
                while(rs.next()){
                    fullName = rs.getString("FIRSTNAME") + " " + rs.getString("MIDDLEINITIAL") + " " + rs.getString("LASTNAME");
                    resClass = rs.getString("RESIDENTCLASS").trim();
                    hoID = rs.getString("HOMEOWNERID");
                }   
                
                
        %>
        <div class="profileStrip">
            <div class="profileText">
                <p><%= fullName%></p>
                <h1 class="h1-bold" style="margin-top: -8%; text-align: left; font-size: 60px"><%= resClass%></h1>
            </div>
            <div id="profileB" align="right" style="margin-top: auto; margin-bottom: auto;">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button><br/>
                <button class="buttonP" >Edit Information</button>
            </div>
        </div>
        <%
            ps = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?");
            ps.setString(1, hoID);
            rs = ps.executeQuery();
            
            while(rs.next()) {
            out.print("<h1 class=\"h1-bold\" style=\"margin-left: -68%\"> Area " + rs.getString("AREA") + "</h1>");
            out.print("<div class=\"d-flex main justify-content-between\" class=\"profileStrip\">"
            + "<div class=\"profileText\">" 
            + "<h1 class=\"h1-bold\" style=\"text-align: left; font-size: 60px\">"
            + rs.getString("HOUSENO") + " " + rs.getString("STREETNAME")
            + "</h1>"
            + "</div>"
            + "<div class=\"d-flex main justify-content-between\" id=\"profileB\" style=\"margin-top: auto; margin-bottom: auto;\">");
            if(rs.getBoolean("PAID")) {
                out.print("<div class=\"green\"><h1 class=\"panelText\"> PAID");
            } else if(!rs.getBoolean("PAID")) {
                out.print("<div class=\"red\"><h1 class=\"panelText\"> UNPAID");
            }
            out.print("</h1>"%>
            <%--+ "</div>"
            //+ "<button class=\"buttonA\" onclick=\"openForm()\"> V </button>"
            //+ "</div>"--%>
            <ul class="nav-links" style="vertical-align: top">
                    <li>
                        <a href="#" class="buttonA">V</a>
                        <div class="mega-box">
                            <div class="content">
                                <div class="row">
                                    <h1 class="h1-bold" style="font-size: 26px; margin-top: -1%; margin-left: -1%; margin-bottom: 2%">Homeowner Info</h1>
                                    <ul class="mega-links">
                                        <li><p><span class="h2-bold">Name:</span> Jeldric Rasa</p></li><br>
                                        <li><p><span class="h2-bold">Email:</span> jeldricrasa@gmail.com</p></li><br>
                                        <li><p><span class="h2-bold">Phone Number:</span> 5555-555-5555</p></li><br>
                                        <li><p><span class="h2-bold">Current Address:</span> Jupiter Jeldric StreetJupiter Jeldric StreetJupiter Jeldric StreetJupiter Jeldric StreetJupiter Jeldric StreetJupiter Jeldric Street</p></li><br><br>
                                        <h1 class="h1-bold" style="font-size: 26px; margin-top: -2%; margin-left: 5%; text-align: left; margin-bottom: 2%">Representative/Caretaker</h1>
                                        <li><p><span class="h2-bold">Name:</span> Alden Richards</p></li><br>
                                        <li><p><span class="h2-bold">Phone Number:</span> 9999-999-9999</p></li><br>
                                    </ul>
                                </div>
                                <div class="row">
                                    <h1 class="h1-bold" style="font-size: 26px; margin-top: -2%; margin-left: -1%; margin-bottom: 2%">Lot Residents</h1>
                                    <ul class="mega-links">
                                        <li><span class="h2-bold">Jeldric Rasa</span><p>Relationship: Cousin</p></li>
                                        <li><span class="h2-bold">Jeldric Rasa</span><p>Relationship: Cousin</p></li>
                                        <li><span class="h2-bold">Jeldric Rasa</span><p>Relationship: Cousin</p></li>
                                    </ul>
                                </div>
                                <div class="row">
                                    <h1 class="h1-bold" style="font-size: 26px; margin-top: -2%; margin-left: -1%; margin-bottom: 2%">Balance Dues</h1>
                                    <ul class="mega-links">
                                        <li>PHP 300.00</li>
                                        <li>Status: Unpaid</li>
                                        <li>Button</li>
                                        <li>Button</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
<%
            + "</div>"
            + "<div class=\"houseInfo\" id=\"infoForm\" style=\"display: none;\">");
            out.print(rs.getString("HOUSENO") + " " + rs.getString("STREETNAME") + " " + rs.getString("VILLAGE") + " " + rs.getString("BARANGAY")
            + " " + rs.getString("CITY") + " " + rs.getString("PROVINCE"));
            out.print("<button class=\"buttonA infoB\" onclick=\"closeForm()\"> X </button>"
            + "</div>");
        %>
<%--        I left the html code for the area strip for reference
            The code above is basically gonna print all the homeowner records 
            that are linked to the logged on user

            <div class="profileStrip">
            <div class="profileText">
                <h1 class="infoText">
                </h1>
            </div>
            <div class="profileB area">
                <div class="green">
                    <h1 class="panelText"> PAID </h1>
                </div>
                <button class="buttonA" onclick="openForm()"> V </button>
            </div>
        </div>
        <div class="houseInfo" id="infoForm" style="display: none;">
            INFOMRATION HERE LOL
            <button class="buttonA infoB" onclick="closeForm()"> X </button>
        </div> --%>
        
        <%
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
        <script>
            function openForm() {
                document.getElementById("infoForm").style.display = "block";
            }

            function closeForm() {
                document.getElementById("infoForm").style.display = "none";
            }
        </script>
    </body>
</html>
