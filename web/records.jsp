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
            String QUERY = "SELECT * FROM HOMEOWNER";
            String addQuery = null;
            String[] hold = null;
            addQuery = request.getParameter("find");
            
            System.out.println("Parameter gotten: " + addQuery); // shows parameter gotten
            
            if(addQuery != null){ // checks if there are additional parameters
                hold = addQuery.split("\\s+"); // splits parameters based on whitespace
                
                if(hold != null && addQuery.substring(0,4).equals("AREA")) { // checks if AREA parameter is used
                
                    addQuery = " WHERE AREA = '" + hold[1] + "'"; // sets which specific area will be filtered in query
                    System.out.println("Area Check: " + hold[1]); // checks which area was taken from param
                    
                    if(hold.length == 3) { // if the parameters has 3 strings, third string is for paid/unpaid
                        addQuery += " AND PAID = " + hold[2]; // adds payment status to query
                    }
                    QUERY += addQuery;
                    System.out.println(QUERY);
                } else if(!addQuery.substring(0,4).equals("AREA")){ // AREA parameter not used
                    QUERY += " WHERE PAID =" + addQuery; // only adds payment status to query
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
            try {
                ps = con.prepareStatement(QUERY);
                System.out.println("Current Query: " + QUERY); // checks query about to be executed
                rs = ps.executeQuery();
        %>
        <%--search bar thingie lang dito--%> 
        <div>
            <form class="sortSearch" action="SortHandler" style="margin:auto; margin-top: 5px; max-width: 1800px;">
                <input type="text" placeholder="Search for name.." name="search" id="nameSearch" onkeyup="searchFunc()">
            </form>
            <br/>
            <!-- A button to open the popup form -->
            <button class="openSortB" onclick="openForm()">More Sort Options</button>

            <!-- The sorting form -->
            <div class="sortPopup" id="sortForm" style="display: none;">
                <form action="SortHandler" class="form-container" method="POST">
                    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
                    <h1>Sort By:</h1>

                    <b>Status:</b><br>
                    <input type="radio" id="paid" name="status" value="true">
                    <label for="paid">Paid</label><br>
                    <input type="radio" id="unpaid" name="status" value="false">
                    <label for="unpaid">Unpaid</label><br><br><br>

                    <label for="area">Area:</label>
                    <select name="area" id="area">
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

                    <button type="submit" class="btn">Filter Results</button>
                </form>
            </div>
        </div>

        <div class="tableContain" style="overflow-y: scroll; height: 620px;"> <%--dito yun table--%> 
            <table class="tableContent sortable" id="displayTable"> 
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
                                String nameDB = rs.getString("FIRSTNAME").trim() + " "
                                        + rs.getString("MIDDLEINITIAL").trim() + " "
                                        + rs.getString("LASTNAME"),
                                        addDB = rs.getString("HOUSENO").trim() + " "
                                        + rs.getString("STREETNAME") + " "
                                        + rs.getString("VILLAGE").trim() + " "
                                        + rs.getString("BARANGAY").trim() + " "
                                        + rs.getString("CITY").trim() + " "
                                        + rs.getString("PROVINCE").trim(),
                                        numDB = rs.getString("MOBILENO").trim(),
                                        statDB = "Homeowner",
                                        paidDB = rs.getString("PAID").trim();
                                        
                                        if(paidDB.equals("true")){
                                            paidDB = "Paid";
                                        } else if(paidDB.equals("false")) {
                                            paidDB = "Unpaid";
                                        }
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
