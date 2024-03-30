<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login.jsp");
    } else if (!session.getAttribute("level").equals("admin")) {
        response.sendRedirect("index.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>KHA | Membership Approval</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br>
        <%            Connection con = null;
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
                ps = con.prepareStatement("SELECT * FROM HOMEOWNER");
                rs = ps.executeQuery();
        %>
        <h1 class="h1-bold">Membership Applications</h1>
        <div>
            <form class="sortSearch" action="SortHandler" style="margin:auto; margin-top: 5px; max-width: 1800px;">
                <input type="text" placeholder="Search for Application..." name="search" id="nameSearch" onkeyup="searchFunc()">
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>
        <br>
        <div class="tableContain">
            <table class="tableContent sortable" id="tableContent-fit" style="overflow-y: scroll;">
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
                                String nameDB = rs.getString("FIRSTNAME").trim() + " " + rs.getString("LASTNAME").trim();
                                out.print("<tr><td class=\"tableContentText\">" + nameDB + "</td>");
                                out.print("<td class=\"tableContentText info\"><a href=\"profile.jsp\" style=\"color: black\">Information</a></td>");
                                out.print("<td class=\"tableContentText\"><button class=\"button-design\" id=\"button-small\" style=\"margin-right: -20%\">Accept</button></td>");
                                out.println("<td class=\"tableContentText\"><button class=\"button-design-reject\" id=\"button-small\" style=\"margin-left: -20%\">Reject</button></td></tr>");
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
        <script src="scripts/sorttable.js"></script>
        <script>
                    function searchFunc() {
                        var input, filter, table, tr, td, i, txtValue;
                        input = document.getElementById("nameSearch");
                        filter = input.value.toUpperCase();
                        table = document.getElementById("displayTable");
                        tr = table.getElementsByTagName("tr");
                        for (i = 0; i < tr.length; i++) {
                            td = tr[i].getElementsByTagName("td")[0];
                            if (td) {
                                txtValue = td.textContent || td.innerText;
                                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                    tr[i].style.display = "";
                                } else {
                                    tr[i].style.display = "none";
                                }
                            }
                        }
                    }
        </script>
    </body>
</html>