<%@page import="java.text.DecimalFormat"%>
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
    } else if (!session.getAttribute("level").equals("staff")) {
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
            <form class="sortSearch" action="${root}\SortHandler" style="display: inline-flex;">
                <input type="text" placeholder="Search For Name" name="search" id="searchWidth" onkeyup="searchFunc()">
                <button type="submit" id="searchMargin"><i class="fa fa-search"></i></button>
            </form>
            <button class="openSortB" onclick="openForm()">Sort</button>
            <!-- The sorting form -->
            <div class="sortPopup" id="sortForm" style="display: none;">
                <form action="${root}\SortHandler" class="form-container" method="POST">
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
                            <%-- <th class="tableTitle">Status</th> --%>
                        <th class="tableTitle">Balance</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            PreparedStatement ps3 = con.prepareStatement(LotQuery); // queries USERLOT table
                            ResultSet rs3 = ps3.executeQuery();
                            String balQuery;
                            PreparedStatement ps4; // queries MonthlyBalance table
                            ResultSet rs4;
                            while (rs3.next()) {
                                balQuery = "select m.balancedate, m.balance "
                                + "from userlot p "
                                + "inner join monthlybalance m USING (propertyid) "
                                + "where p.userid = ? and p.propertyid = ?";
                                ps4 = con.prepareStatement(balQuery);
                                ps4.setString(1,rs3.getString("userid"));
                                ps4.setString(2,rs3.getString("propertyid"));
                                System.out.println(ps4);
                                rs4 = ps4.executeQuery();
                                userLotID = rs3.getString("userid"); // Take homeownerid from USERLOT
                                ps2 = con.prepareStatement("select * from users where userid = ?"); // queries USERS with USERID from USERLOT
                                ps2.setString(1, userLotID);
                                rs = ps2.executeQuery();
                                ps = con.prepareStatement("SELECT * FROM homeowner WHERE userid = ?");
                                ps.setString(1, userLotID);
                                rs2 = ps.executeQuery();
                                while (rs.next() && rs2.next()) {
                                    resClass = rs.getString("RESIDENTCLASS");
                                    String nameDB = rs.getString("LASTNAME").trim() + ", "
                                            + rs.getString("FIRSTNAME").trim() + " "
                                            + rs.getString("MIDDLEINITIAL").trim(),
                                            addDB = rs3.getString("HOUSENO").trim() + " "
                                            + rs3.getString("STREETNAME") + " Barangay "
                                            + rs3.getString("BARANGAY").trim(),
                                            numDB = rs2.getString("MOBILENO").trim();
                                    balance = rs3.getFloat("BALANCE");
                                    // display db contents
                                    DecimalFormat numForm = new DecimalFormat("#,##0.00");
                                    out.print("<tr><td class=\"tableContentText\" style=\"padding-top: 0.8%\">" + nameDB + "</td>");
                                    // out.print("<td class=\"tableContentText\">" + addDB + "</td>");
                                    out.print("<td class=\"tableContentText\">"
                                    + "<button class=\"accordion\" id=\"tableContentText\" style=\"margin-left: -2%; cursor: pointer;\">"
                                    + addDB
                                    + "<i class=\"fa fa-angle-down\"></i> </button>"
                                    + "<div id=\"moreinfo\" style=\"display: none;\">"
                                    + "<div style=\"padding-left: 2%;\">"
                                    + "<table class=\"tableContentRecords\">"
                                    + "<thead>"
                                    + "<th> Balance Date:</th>"
                                    + "<th> Balance:</th>"
                                    + "</thead>"
                                    + "<tbody>");
                                    
                                    while(rs4.next()){
                                     System.out.println(rs4.getDate("balancedate") +" " + rs4.getDouble("balance"));
                                    out.print(
                                    "<tr>"
                                    + "<td>"
                                    + rs4.getDate("balancedate")
                                    + "</td>"
                                    + "<td>"
                                    + rs4.getDouble("balance")
                                    + "</td>"
                                    + "</tr>");
                                    }
                                    out.print(
                                     "</tbody>"
                                    + "</table> "
                                    + "<br>"
                                    + "</div></div></td>");
                                    out.print("<td class=\"tableContentText\" style=\"padding-top: 0.8%\">" + numDB + "</td>");
                                    // out.print("<td class=\"tableContentText\">" + resClass + "</td>");
                                    out.println("<td class=\"tableContentText\" style=\"padding-top: 0.8%\"><a style=\"text-decoration:none; color:inherit;\" href=\"payLot.jsp?propID=" + rs3.getString("PROPERTYID") + "\">" + "₱ " + numForm.format(balance) + "</a></td></tr>");
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
            if (session.getAttribute("level").equals("staff")) {
        %>
        <div class="button-container">
            <form>
                <button class="button-design" type="submit" style="margin-left: -10%">
                    Update Record
                </button>
            </form>
            <form action="${root}/UpdateBalance">
                <button class="button-design" type="submit" style="margin-left: 10%;">
                    Update Balance
                </button>
            </form>
            <form action="${root}/AddMonthlyDues" method="POST" onsubmit="return confirm('Are you sure you want to add the monthly dues to all records');">
                <button class="button-design" type="submit" style="margin-left: 30%;">
                    Add Monthly Dues
                </button>
            </form>
        </div>
        <%
            }
        %>
        <script src="${root}/scripts/sorttable.js"></script>
        <script>

                function openForm() {
                    document.getElementById("sortForm").style.display = "block";
                }

                function closeForm() {
                    document.getElementById("sortForm").style.display = "none";
                }

                function searchFunc() {
                    var input, filter, table, tr, td1, td2, i, txtValue1, txtValue2, txtValue3;
                    input = document.getElementById("searchWidth");
                    filter = input.value.toUpperCase();
                    table = document.getElementById("displayTable");
                    tr = table.getElementsByTagName("tr");
                    for (i = 0; i < tr.length; i++) {
                        console.log(tr[i].getElementsByTagName("td")[0]);
                        td1 = tr[i].getElementsByTagName("td")[0];
                        td2 = tr[i].getElementsByTagName("td")[1];

                        if (td1) {
                            txtValue1 = td1.textContent || td1.innerText;
                            txtValue2 = td2.textContent || td2.innerText;
                            txtValue3 = txtValue1 + txtValue2;
                            if (txtValue3.toUpperCase().indexOf(filter) > -1) {
                                tr[i].style.display = "";
                            } else {
                                tr[i].style.display = "none";
                            }
                        }
                    }
                }

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