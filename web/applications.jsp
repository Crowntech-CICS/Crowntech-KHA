<%-- 
    Document   : applications
    Created on : 01 30, 24, 10:43:51 PM
    Author     : ejlu1
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/records.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Applications</title>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
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
            try {
                ps = con.prepareStatement("SELECT * FROM RESIDENTS");
                rs = ps.executeQuery();
        %>
        <h1>Membership Applications</h1>
        <div>
             <form class="sortSearch" action="SortHandler" style="margin:auto; margin-top: 5px; max-width: 1800px;">
                <input type="text" placeholder="Search for Member..." name="search">
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>
        <div class="tableContain" style="overflow-y: scroll; height: 620px;">
            <table class="tableContent">
                <thead>
                <tr>
                    <th class="tableTitle">Name</th>
                    <th class="tableTitle">Information</th>
                    <th colspan="2" class="tableTitle">Accept/Reject</th>
                </tr>
                </thead>
                <tbody>
                    <%
                            while (rs.next()) {
                                String nameDB = rs.getString("NAME").trim();
                                // tbh i just copy pasted everything, aadjust nalang syntax here for real db
                                out.print("<tr><td class=\"tableContentText\">" + nameDB + "</td>");
                                out.print("<td class=\"tableContentText info\"><a href=\"profile.jsp\">Information</a></td>");
                                out.print("<td class=\"tableContentText\"><button class=\"tableB accept\">Accept</button></td>");
                                out.println("<td class=\"tableContentText\"><button class=\"tableB reject\">Reject</button></td></tr>");
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
                </tbody>
            </table>
        </div>
    </body>
</html>