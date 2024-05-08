<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    String root = request.getContextPath();
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect(root + "/accounts/login.jsp");
    } else if (!session.getAttribute("level").equals("admin") && !session.getAttribute("level").equals("staff")) {
        response.sendRedirect(root + "/index.jsp");
    }
%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Records</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/table-format.css" rel="stylesheet"/>
        <link href="${root}/css/records.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <%            Connection con = null;
            ResultSet rs = null;
            ResultSet rs2 = null;
            PreparedStatement ps = null;
            PreparedStatement ps2 = null;
            String LotQuery = "SELECT * FROM USERLOT";
            String HomeQuery = "SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?";
            String userLotID = null;
            String addQuery = null;
            String[] hold = null;
            String resClass = null;
            double balance = 0;
            addQuery = request.getParameter("find");

            System.out.println("Parameter gotten: " + addQuery); // shows parameter gotten

            if (addQuery != null) { // checks if there are additional parameters
                hold = addQuery.split("\\s+"); // splits parameters based on whitespace

                if (hold != null && addQuery.substring(0, 4).equals("AREA")) { // checks if AREA parameter is used

                    addQuery = " WHERE AREA = '" + hold[1] + "'"; // sets which specific area will be filtered in query
                    System.out.println("Area Check: " + hold[1]); // checks which area was taken from param

                    if (hold.length == 3) { // if the parameters has 3 strings, third string is for paid/unpaid
                        LotQuery += " AND PAID = " + hold[2]; // adds payment status to query
                    }
                    LotQuery += addQuery;
                    System.out.println(LotQuery);
                } else if (!addQuery.substring(0, 4).equals("AREA")) { // AREA parameter not used
                    LotQuery += " WHERE PAID =" + addQuery; // only adds payment status to query
                }
            }
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
        %>
        <br><br><br><br><br><br>
        <div id="searchRecords">
            <form class="sortSearch" action="SortHandler" style="display: inline-flex;">
                <input type="text" placeholder="Search For Name" name="search" id="searchWidth" onkeyup="searchFunc()">
                <button type="submit" id="searchMargin"><i class="fa fa-search"></i></button>
            </form>
            <button class="openSortB" onclick="openForm()">Sort</button>
            <!-- The sorting form -->
            <div class="sortPopup" id="sortForm" style="display: none;">
                <form action="SortHandler" class="form-container" method="POST">
                    <button type="button" class="button-design-reject" id="sortClose" onclick="closeForm()">Close</button>
                    <br><br>
                    <label class="sortCenter">Sort By Status:</label><br>
                    <input type="radio" id="paid" name="status" value="true" class="sortCenterOption">
                    <label for="paid">Paid</label>
                    <input type="radio" id="unpaid" name="status" value="false">
                    <label for="unpaid">Unpaid</label><br><br>
                    <label for="area" class="sortCenter2">Sort By Area:</label>
                    <select name="area" id="select" class="sortCenterSelect">
                        <option value ="null">-----</option>
                        <option value="1">Area 1</option>
                        <option value="1A">Area 1A</option>
                        <option value="2">Area 2</option>
                        <option value="3">Area 3</option>
                        <option value="4">Area 4</option>
                        <option value="5">Area 5</option>
                        <option value="5A">Area 5A</option>
                        <option value="6">Area 6</option>
                        <option value="7">Area 7</option>
                        <option value="8">Area 8</option>
                        <option value="9">Area 9</option>
                        <option value="10">Area 10</option>
                        <option value="11E">Area 11 East</option>
                        <option value="11W">Area 11 West</option>
                    </select>
                    <br><br>
                    <button type="submit" class="button-design" id="sortFilter">Filter Results</button>
                </form>
            </div>
        </div>
        <br>
        <div class="recordsHolder" style="overflow-y: scroll; height: 55%;">
            <table class="tableContent sortable" id="displayTable">
                <thead>
                    <tr>
                        <th class="tableTitle">Name</th>
                        <th class="tableTitle">Address</th>
                        <th class="tableTitle">Contact Number</th>
                        <th class="tableTitle">Status</th>
                        <th class="tableTitle">Paid</th>
                        <th class="tableTitle">Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            PreparedStatement ps3 = con.prepareStatement(LotQuery); // queries USERLOT table
                            ResultSet rs3 = ps3.executeQuery();
                            while (rs3.next()) {
                                userLotID = rs3.getString("HOMEOWNERID"); // Take homeownerid from USERLOT
                            //    System.out.println("userLotID: " + userLotID);
                                ps2 = con.prepareStatement(HomeQuery); // queries USERS with USERID from USERLOT
                                ps2.setString(1, userLotID);
                                rs = ps2.executeQuery();
                                while (rs.next()) {
                                    ps = con.prepareStatement("SELECT RESIDENTCLASS FROM USERS WHERE HOMEOWNERID = ?");
                                    ps.setString(1, userLotID);
                                    rs2 = ps.executeQuery();
                                    while (rs2.next()) {
                                        resClass = rs2.getString("RESIDENTCLASS");
                                    }
                                    String nameDB = rs.getString("FIRSTNAME").trim() + " "
                                            + rs.getString("MIDDLEINITIAL").trim() + " "
                                            + rs.getString("LASTNAME"),
                                            addDB = rs3.getString("HOUSENO").trim() + " "
                                            + rs3.getString("STREETNAME") + " Barangay "
                                            + rs3.getString("BARANGAY").trim(),
                                            numDB = rs.getString("MOBILENO").trim(),
                                            paidDB = rs.getString("PAID").trim();
                                    balance = rs3.getDouble("BALANCE");
                                    if (paidDB.equals("true")) {
                                        paidDB = "Paid";
                                    } else if (paidDB.equals("false")) {
                                        paidDB = "Unpaid";
                                    }
                                    // tbh i just copy pasted everything, aadjust nalang syntax here for real db
                                    out.print("<tr><td class=\"tableContentText\">" + nameDB + "</td>");
                                    out.print("<td class=\"tableContentText\">" + addDB + "</td>");
                                    out.print("<td class=\"tableContentText\">" + numDB + "</td>");
                                    out.print("<td class=\"tableContentText\">" + resClass + "</td>");
                                    out.print("<td class=\"tableContentText\">" + paidDB + "</td>");
                                    out.println("<td class=\"tableContentText\"><a style=\"text-decoration:none; color:inherit;\" href=\"payLot.jsp?propID=" + rs3.getString("PROPERTYID") +"\">" + balance + "</a></td></tr>");
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
                </tbody>
            </table>
        </div>
        <br><br>
        <%
            if(session.getAttribute("level").equals("staff")) {
        %>
        <div class="button-container">
            <form>
                <button class="button-design" type="submit" style="margin-left: -10%">
                    Update Record
                </button>
            </form>
            <form action="update-balance.jsp">
                <button class="button-design" type="submit" style="margin-left: 10%;">
                    Update Balance
                </button>
            </form>
            <form action="AddMonthlyDues" method="POST" onsubmit="return confirm('Are you sure you want to add the monthly dues to all records');">
                <button class="button-design" type="submit" style="margin-left: 30%;">
                    Add Monthly Dues
                </button>
            </form>
        </div>
        <%
            }
        %>
        <script src="scripts/sorttable.js"></script>
        <script>

                function openForm() {
                    document.getElementById("sortForm").style.display = "block";
                }

                function closeForm() {
                    document.getElementById("sortForm").style.display = "none";
                }

                function searchFunc() {
                    var input, filter, table, tr, td, i, txtValue;
                    input = document.getElementById("searchWidth");
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