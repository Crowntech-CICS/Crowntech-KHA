
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires","0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if(!logState) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Profile</title>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/profile-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
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
        <br>
        <div class="d-flex main justify-content-between" id="profileStrip">
            <div class="profileText">
                <p><%=fullName%></p>
                <h1 class="h1-bold" style="margin-top: -8%; text-align: left; font-size: 60px">Homeowner</h1>
            </div>
            <div id="profileB" align="right" style="margin-top: auto; margin-bottom: auto;">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button><br/><br/>
                <button class="buttonP" >Edit Information</button>
            </div>
        </div>
        <br>
        <%
            ps = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?");
            ps.setString(1, hoID);
            rs = ps.executeQuery();
            
           while(rs.next()) {
            out.print("<h1 class=\"h1-bold\" style=\"margin-left: -68%\"> Area " + rs.getString("AREA") + "</h1>");
            out.print("<div class=\"d-flex main justify-content-between\" id=\"profileStrip\">"
            + "<div class=\"profileText\">" 
            + "<h1 class=\"h1-bold\" style=\"text-align: left; font-size: 60px\">"
            + rs.getString("HOUSENO") + " " + rs.getString("STREETNAME")
            + "</h1>"
            + "</div>"
            + "<div class=\"d-flex main justify-content-between\" id=\"profileB\" style=\"margin-top: auto; margin-bottom: auto;\">");
            if(rs.getBoolean("PAID")) {
                out.print("<div class=\"green\"><h1 class=\"panelText\"> PAID ");
            } else if(!rs.getBoolean("PAID")) {
                out.print("<div class=\"red\"><h1 class=\"panelText\"> UNPAID");
            }
            out.print("</h1></div><ul class=\"nav-links\" style=\"vertical-align: top\"> "
            + "<li>"
            + "<a href=\"#\" class = \"buttonA\">V</a>" 
            + "<div class = \"mega-box\">"
            + "<div class=\"content\">"
            + "<div class=\"row\">"
            + "<h1 class=\"h1-bold\" style=\"font-size: 26px; margin-top: -1%; margin-left: -1%; margin-bottom: 2%\">Homeowner Info</h1>"
            + "<ul class=\"mega-links\">"
            + "<li><p><span class=\"h2-bold\">Name: </span>" + fullName + "</p></li>"
            + "<li><p><span class=\"h2-bold\">Email: </span>" + rs.getString("EMAIL") + "</p></li>"
            + "<li><p><span class=\"h2-bold\">Phone Number: </span>" + rs.getString("MOBILENO") + "</p></li>"
            + "<li><p><span class=\"h2-bold\">Current Address: </span> "
            + rs.getString("HOUSENO") + " " + rs.getString("STREETNAME") + " " + rs.getString("VILLAGE") + " " + rs.getString("BARANGAY") + " "
            + rs.getString("CITY") + " " 
            + rs.getString("PROVINCE")
            + "</p></li>");
            if(rs.getString("REPRESENTATIVE") != null) {
                out.print(""
                + "<li><h1 class=\"h1-bold\" style=\"font-size: 26px; margin-top: -2%; margin-left: 5%; text-align: left; margin-bottom: 2%\">Representative/Caretaker</h1></li>"
                + "<li><p><span class=\"h2-bold\">Name: </span>" + rs.getString("REPRESENTATIVE") + "</p></li>"
                + "<li><p><span class=\"h2-bold\">Phone Number: </span>" + rs.getString("REPMOBILENO") + "</p></li>");
            }
            out.print("</ul>"
            + "</div>"
            + "<div class=\"row\">"
            + "<h1 class=\"h1-bold\" style=\"font-size: 26px; margin-top: -2%; margin-left: -1%; margin-bottom: 2%\">Lot Residents</h1>"
            + " <ul class=\"mega-links\">");
            ResultSet rsTemp;
             ps = con.prepareStatement("SELECT * FROM USEROTHER WHERE USERID = ?");
                ps.setString(1, (String) session.getAttribute("currID"));
                rsTemp = ps.executeQuery();
            while(rsTemp.next()) {
                out.print("<li><span class=\"h2-bold\">" + rsTemp.getString("FIRSTNAME") + " " + rsTemp.getString("MIDDLEINITIAL") + " " + 
                rsTemp.getString("LASTNAME") + "</span><p>Relationship: " + rsTemp.getString("RELATIONSHIP")
                + "</p></li>");
            }
            rsTemp.close();
            out.print("</ul> </div>"
            + "<div class=\"row\">"
            + "<h1 class=\"h1-bold\" style=\"font-size: 26px; margin-top: -2%; margin-left: -1%; margin-bottom: 2%\">Balance Dues</h1>"
            + "<ul class=\"mega-links\">"
            + "<li>PHP 300.00</li>");
            if(rs.getBoolean("PAID")) {
                out.print("<li>Status: PAID</li>");
            } else {
                out.print("<li>Status: UNPAID</li>");
            }
                out.print("<li>Button</li>"
                + "<li>Button</li>"
                + "</ul></div></div></div></li></ul></div></div>");
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
