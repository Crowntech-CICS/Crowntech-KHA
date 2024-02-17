
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="css/profile.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <%
            Connection con = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
            String fullName = null;
            String hoID = null;
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
                    hoID = rs.getString("HOMEOWNERID");
                }   
                
                
        %>
        <div class="profileStrip">
            <div class="profileText">
                <p class="infoText"><%= fullName%></p>
                <h1 class="infoText">${level}</h1>
            </div>
            <div class="profileB">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button><br/>
                <button class="buttonP" >Edit Information</button>
            </div>
        </div>
        <%
            ps = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?");
            ps.setString(1, hoID);
            rs = ps.executeQuery();
            
            while(rs.next()) {
            out.print("<h2> Area" + rs.getString("AREA") + "</h2>");
            out.print("<div class=\"profileStrip\">"
            + "<div class=\"profileText\">" 
            + "<h1 class=\"infoText\">"
            + rs.getString("HOUSENO") + " " + rs.getString("STREETNAME")
            + "</h1>"
            + "</div>"
            + "<div class=\"profileB area\">"
            + "<div class=\"green\">"
            + "<h1 class=\"panelText\">");
            out.print("</h1>"
            + "</div>"
            + "<button class=\"buttonA\" onclick=\"openForm()\"> V </button>"
            + "</div>"
            + "</div>"
            + "<div class=\"houseInfo\" id=\"infoForm\" style=\"display: none;\">");
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
