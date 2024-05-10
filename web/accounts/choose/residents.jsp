<%@page import="model.connections.ConnectionPoolManager"%>
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
    } else if (!session.getAttribute("level").equals("admin")) {
        response.sendRedirect(root + "/index.jsp");
    }
%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Edit Resident Account</title>
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
        %>
        <br><br><br><br><br><br>
        <div id="searchRecords">
            <form class="sortSearch">
                <input type="text" placeholder="Search For Name" name="search" id="searchWidth" onkeyup="searchFunc()">
                <button type="submit" id="searchMargin" disabled><i class="fa fa-search"></i></button>
            </form>
        </div>
        <br>
        <h1 class="h1-bold" id="h1small">Choose Resident to Edit</h1>
        <div class="recordsHolder" style="overflow-y: scroll; height: 55%;">

            <table class="tableContent sortable" id="displayTable">
                <thead>
                    <tr>
                        <th class="tableTitle">Name</th>
                        <th class="tableTitle">Address</th>
                        <th class="tableTitle">Email</th>
                        <th class="tableTitle">Relation</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            con = ConnectionPoolManager.getDataSource().getConnection();
                            ps = con.prepareStatement("select u.*,r.* from users u join residents r on u.userid = r.userid where residentclass = 'Resident';");
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                String fullname = rs.getString("lastname").trim() + ", " + rs.getString("firstname").trim() + " " + rs.getString("middleinitial").trim();
                                String email = rs.getString("email");
                                String relation = rs.getString("relationship");
                                ps = con.prepareStatement("select * from userlot where propertyid = ?;");
                                ps.setString(1, rs.getString("propertyid"));
                                rs2 = ps.executeQuery();
                                rs2.next();
                                String address = rs2.getString("houseno").trim() + " " + rs2.getString("streetname");
                                // display db contents
%>
                    <tr onclick="window.location.href = '${root}/accounts/edit/edit-resident.jsp?r=<%=rs.getString("userid")%>'">
                        <td class="tableContentText"><%=fullname%></td>
                        <td class="tableContentText"><%=address%></td>
                        <td class="tableContentText"><%=email%></td>
                        <td class="tableContentText"><%=relation%></td>
                    </tr>
                    <%      }
                        } catch (SQLException sqle) {
                            System.out.println("SQLException IN error occured - " + sqle.getMessage());
                            response.sendError(500);
                        } finally {
                            try {
                                if (rs != null) {
                                    rs.close();
                                }
                                if (rs2 != null) {
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
        <div class="button-container">
            <form action="${root}/admin/accounts.jsp">
                <button class="button-design" type="submit" style="margin-left: -10%">
                    Back
                </button>
            </form>
        </div>
        <style>
            body {
                zoom: 80%;
            }
        </style>
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
        </script>
    </body>
</html>