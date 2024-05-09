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
        %>
        <br><br><br><br><br><br>
        <div id="searchRecords">
            <form class="sortSearch" action="${root}\SortHandler" style="display: inline-flex;">
                <input type="text" placeholder="Search For Name" name="search" id="searchWidth" onkeyup="searchFunc()">
                <button type="submit" id="searchMargin"><i class="fa fa-search"></i></button>
            </form>
            <button class="openSortB" onclick="openForm()">Sort</button>
        </div>
        <br>
        <div class="recordsHolder" style="overflow-y: scroll; height: 55%;">
            <table class="tableContent sortable" id="displayTable">
                <thead>
                    <tr>
                        <th class="tableTitle">Plate Number</th>
                        <th class="tableTitle">Name</th>
                        <th class="tableTitle">Vehicle Type</th>
                        <th class="tableTitle">Vehicle Model</th>
                        <th class="tableTitle">Vehicle Brand</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            ps = con.prepareStatement("select * from vehicle"); // queries vehicles table
                            rs = ps.executeQuery();
                            while (rs.next()) {     
                                String vehID = rs.getString("vehicleid").trim(),
                                       userID = rs.getString("userid").trim(),
                                       type = rs.getString("type").trim(),
                                       plateNo = rs.getString("plateno").trim(),
                                       brand = rs.getString("brand").trim(),
                                       model = rs.getString("model").trim(),
                                       name = rs.getString("registeredname").trim();
                                       
                                    out.print("<tr><td class=\"tableContentText\" style=\"padding-top: 0.8%\"><a style=\"text-decoration:none; color:inherit;\" href=" + root + "/user/edit-vehicle.jsp?VHID=" + vehID + ">" + plateNo + "</a></td>");
                                    out.print("<td class=\"tableContentText\">" + name + "</td>");
                                    out.print("<td class=\"tableContentText\" style=\"padding-top: 0.8%\">" + type + "</td>");
                                    out.print("<td class=\"tableContentText\">" + model + "</td>");
                                    out.println("<td class=\"tableContentText\" style=\"padding-top: 0.8%\">" + brand + "</td></tr>");
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
        <!--<div class="button-container">
            <form action="${root}/UpdateBalance">
                <button class="button-design" type="submit" style="margin-left: 10%;">
                    Add Vehicles
                </button>
            </form>
            <form action="${root}/AddMonthlyDues" method="POST" onsubmit="return confirm('Are you sure you want to add the monthly dues to all records');">
                <button class="button-design" type="submit" style="margin-left: 30%;">
                    Edit Vehicles
                </button>
            </form>
        </div>-->
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