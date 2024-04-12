<%@page import="java.sql.*"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Profile</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/profile-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body style="overflow-y: scroll">
        <%
            Connection con = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
            String fullName = null;
            String hoID = null;
            String resClass = null;
            String address = null;
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

                while (rs.next()) {
                    fullName = rs.getString("FIRSTNAME") + " " + rs.getString("MIDDLEINITIAL") + " " + rs.getString("LASTNAME");
                    resClass = rs.getString("RESIDENTCLASS").trim();
                    hoID = rs.getString("HOMEOWNERID");
                    address = rs.getString("HOUSENO") + " " + rs.getString("STREETNAME");
                }
        %>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br>
        <div class="d-flex main justify-content-between" id="profileStrip">
            <div class="profileText">
                <p class="profileOwnerName"><%=fullName%></p>
                <h1 class="h1-bold" id="profileHeader"><%=resClass%></h1>
                <p class="profileOwnerAddress"><%=address%></p>
            </div>
            <div class="profileTextsmall">
                <h1 class="h1-bold" id="profileHeader">Homeowner</h1>
            </div>
            <div id="profileB" align="right">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button><br/><br/>
                <button class="buttonP" onclick="location.href = 'edit-homeowners.jsp'">Edit Information</button>
            </div>
            <div id="profileBsmall">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button>
                <button class="buttonP" onclick="location.href = 'edit-homeowners.jsp'">Edit Information</button>
            </div>
        </div>
        <%
                ps = con.prepareStatement("SELECT * FROM USERLOT WHERE USERID = ?");
                ps.setString(1, (String) session.getAttribute("currID"));
                rs = ps.executeQuery();

                while (rs.next()) {
                    out.print("<h1 class=\"h1-bold\" id=\"profileLotHeader\">Area " + rs.getString("AREA") + "</h1>"
                            + "<div class=\"profileLotHolder\">"
                            + "<ul id=\"profileStripB\" style=\"margin-bottom: 2%;\">"
                            + "<button class=\"accordion\">"
                            + "<div class=\"d-flex main justify-content-between\">");
                    out.print("<h1 class=\"h1-bold\" id=\"profileAddress\">"
                            + rs.getString("HOUSENO") + " " + rs.getString("STREETNAME")
                            + "</h1>");
                    if (rs.getBoolean("PAID")) {
                        out.print("<div class=\"green\"><h1 class=\"panelText\"> PAID ");
                    } else if (!rs.getBoolean("PAID")) {
                        out.print("<div class=\"red\"><h1 class=\"panelText\"> UNPAID");
                    }
                    out.print("</h1>"
                            + "</div>"
                            + "</div>"
                            + "</button>"
                            + "<div class=\"moreinfo\">"
                            + "<li class=\"accordion-content-width\">"
                            + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Homeowner Info</h1>"
                            + "<div class=\"line\"></div><br>"
                            + "<ul>"
                            + "<li class=\"accordion-content\">Name:" + fullName + "</li>");
                    ResultSet rsTemp;
                    ps = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?");
                    ps.setString(1, hoID);
                    rsTemp = ps.executeQuery();
                    while (rsTemp.next()) {
                        out.print("<li class=\"accordion-content\">Email:" + rsTemp.getString("EMAIL") + "</li>"
                                + "<li class=\"accordion-content\">Phone: 0" + rsTemp.getString("MOBILENO") + "</li>"
                                + "<li class=\"accordion-content\">Address: "
                                + rs.getString("HOUSENO") + " " + rs.getString("STREETNAME") + " " + rs.getString("BARANGAY")
                                + "</li>"
                                + "</ul>"
                                + "</li>");
                        out.print("<li class=\"accordion-content-width\">"
                                + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Lot Residents</h1>"
                                + "<div class=\"line\"></div><br>");
                        ps = con.prepareStatement("SELECT * FROM USEROTHER WHERE USERID = ?");
                        ps.setString(1, (String) session.getAttribute("currID"));
                        rsTemp = ps.executeQuery();
                        while (rsTemp.next()) {
                            out.print("<ul>"
                                    + "<li class=\"accordion-content\">" + rsTemp.getString("FIRSTNAME") + " " + rsTemp.getString("MIDDLEINITIAL") + " "
                                    + rsTemp.getString("LASTNAME") + "</li>"
                                    + "<li class=\"accordion-content\">Relationship: " + rsTemp.getString("RELATIONSHIP") + "</li>"
                                    + "</ul>");
                        }
                        out.print("</li>"
                                + "<li class=\"accordion-content-width\">"
                                + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Balance Dues</h1>"
                                + "<div class\"line\"></div><br>"
                                + "<ul>");
                        ps = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?");
                        ps.setString(1, hoID);
                        rsTemp = ps.executeQuery();
                        while (rsTemp.next()) {
                            out.print("<h1 class=\"h1-bold\" id=\"profileCashHeader\">PHP "
                                    + rsTemp.getString("BALANCE") + "</h1><br>");
                        }
                        out.print("<div class=\"line\"></div><br>");
                        if (rs.getBoolean("PAID")) {
                            out.print("<li class=\"accordion-content\" style=\"text-align: center;\">Status: Paid</li><br>");
                        } else {
                            out.print("<li class=\"accordion-content\" style=\"text-align: center;\">Status: Unpaid</li><br>");
                        }
                        out.print("<div class=\"button-container\">"
                                + "<button type=\"button\" class=\"button-design\" id=\"button-small\">Pay Steps</button>"
                                + "</div></ul></li></div></ul>");
                    }
                    out.print("</div>");
                    rsTemp.close();
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
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {

                var panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    let active = document.querySelectorAll(".accordion");
                    for (let j = 0; j < active.length; j++) {
                        active[j].classList.remove("active");
                        active[j].nextElementSibling.style.display = "none";
                    }
                    this.classList.toggle("active");
                    panel.style.display = "block";
                }
            });
        }
        </script>
    </body>
</html>