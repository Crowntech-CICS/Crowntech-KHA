<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Current Members</title>
        <link href="css/records.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        <%--search bar thingie lang dito--%> 
        <div>
            <form class="sortSearch" action="SortHandler" style="margin:auto; margin-top: 5px; max-width: 1800px;">
                <input type="text" placeholder="Search.." name="search">
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
            <br/>
            <!-- A button to open the popup form -->
            <button class="openSortB" onclick="openForm()">More Sort Options</button>

            <!-- The form -->
            <div class="sortPopup" id="sortForm" style="display: none;">
                <form action="SortHandler" class="form-container">
                    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
                    <h1>Sort By:</h1>

                    <label for="before"><b>Before:</b></label>
                    <input type="date"  name="before" ><br>
                    <label for="after"><b>After:</b></label>
                    <input type="date"  name="after" ><br>
                    <label for="during"><b>During:</b></label>
                    <input type="date"  name="during" ><br>
                    
                    <br/>
                    <b>Status:</b><br>
                    <input type="radio" id="paid" name="status" value="true">
                    <label for="paid">Paid</label><br>
                    <input type="radio" id="unpaid" name="status" value="false">
                    <label for="unpaid">Unpaid</label><br><br><br>
                    
                    <label for="area">Area:</label>
                    <select name="area" id="area">
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

                    <button type="submit" class="btn">Filter Results</button>
                </form>
            </div>
        </div>

        <div class="tableContain" style="overflow-y: scroll; height: 620px;"> <%--dito yun table--%> 
            <table class="tableContent"> 
                <thead>
                    <tr>
                        <th class="tableTitle">Name</th>
                        <th class="tableTitle">Address</th>
                        <th class="tableTitle">Contact Number</th>
                        <th class="tableTitle">Status</th>
                        <th class="tableTitle">Paid</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                            while (rs.next()) {
                                String nameDB = rs.getString("NAME").trim(),
                                        addDB = rs.getString("ADDRESS").trim(),
                                        numDB = rs.getString("CONTACT").trim(),
                                        statDB = rs.getString("ROLE").trim(),
                                        paidDB = rs.getString("PAID").trim();
                                // tbh i just copy pasted everything, aadjust nalang syntax here for real db
                                out.print("<tr><td class=\"tableContentText\">" + nameDB + "</td>");
                                out.print("<td class=\"tableContentText\">" + addDB + "</td>");
                                out.print("<td class=\"tableContentText\">" + numDB + "</td>");
                                out.print("<td class=\"tableContentText\">" + statDB + "</td>");
                                out.println("<td class=\"tableContentText\">" + paidDB + "</td></tr>");
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
        <div> <%--div for buttons--%>

        </div>
        <script>
            function openForm() {
                document.getElementById("sortForm").style.display = "block";
            }

            function closeForm() {
                document.getElementById("sortForm").style.display = "none";
            }
        </script>
    </body>
</html>
