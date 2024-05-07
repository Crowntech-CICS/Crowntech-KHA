<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
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
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Vehicle Information</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/profile-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <%
            Connection con = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
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
            try{
                ps = con.prepareStatement("SELECT * FROM VEHICLE WHERE USERID = ?");
                ps.setString(1, (String) session.getAttribute("currID"));
                rs = ps.executeQuery();
        %>
            <%
                out.print("<div class=\"main-body\" id=\"vehicle-body\" style=\"height: 60%; top: 30%;\">");
                while(rs.next()) {
                out.print(
                          "<div class=\"vehicle-box\">"
                        + "<p style=\"text-align: center;padding-top: 2%\">" 
                        + rs.getString("PLATENO") + " - "
                        + rs.getString("BRAND") + " " + rs.getString("MODEL") + " " + " - "
                        + rs.getString("REGISTEREDOWNER")        
                        + "</p>"
                        + "<h1 class=\"h1-bold\" style=\"margin: -2% 0% 2% 0%\">Vehicle Information</h1>"
                        + "<div class=\"line\"></div>"
                        + "<br>"
                        + "<div class=\"d-flex main justify-content-between\" style=\"margin: 0% 5% 0% 5%\">"
                        + "<div><p id=\"p-dark\">Plate Number: </p>"
                        + "<p id=\"p-dark\">Registered Owner: </p>"
                        + "<p id=\"p-dark\">Brand: </p>"
                        + "<p id=\"p-dark\">Year/Model: </p></div>"
                        + "<div><p id=\"p-dark\" class=\"p-right\">" + rs.getString("PLATENO") +" </p>"
                        + "<p id=\"p-dark\" class=\"p-right\">" + rs.getString("REGISTEREDOWNER") +" </p>"
                        + "<p id=\"p-dark\" class=\"p-right\">" + rs.getString("BRAND") +" </p>"
                        + "<p id=\"p-dark\" class=\"p-right\">" + rs.getString("TYPE") + " " + rs.getString("MODEL") + "</p>"
                        + "</div>"
                        + "</div>"
                        + " <div class=\"button-container\">"
                        + "<button class=\"button-design\" onclick=\"location.href = 'edit-vehicle.jsp?VHID=" + rs.getString("VEHICLEID") +"'\">Edit Information</button>"
                        + "</div>"
                        + "<br>"
                        + "</div>"
                        + "<br>");
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
        </div>
                <div class="main-body" style="top: 10%;">
                <h1 class="h1-bold">Vehicle List</h1>
                <div class="button-container">
                <button class="button-design" onclick="location.href = 'profile.jsp'">Return to Profile</button>
            </div>
        </div>
    </body>
</html>