<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.*"%>
<% request.setAttribute("root", request.getContextPath());%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
<%
    Connection con = ConnectionPoolManager.getDataSource().getConnection();
    PreparedStatement ps = null;
    ResultSet rs = null;
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Finances</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/table-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <br><br><br><br><br><br>
        <div>
            <form class="sortSearch" action="" style="margin:auto; margin-top: 5px; max-width: 1800px;">
                <input type="text" placeholder="Search.." name="search">
                <button type="submit"><i class="fa fa-search"></i></button>
            </form>
        </div>
        <br>
        <div class="recordsHolder" style="overflow-y: scroll; height: 55%;">
            <table class="tableContent" id="financesLeft">
                <thead>
                    <tr>
                        <th class="tableTitle">User</th>
                        <th class="tableTitle">Action</th>
                        <th class="tableTitle">Time</th>
                        <th class="tableTitle">Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%                    int oddEven = 0;
                        ps = con.prepareStatement("SELECT u.FIRSTNAME||' '||u.LASTNAME AS \"NAME\",l.action,l.time,l.date FROM LOGS l LEFT JOIN USERS u ON u.USERID = l.USERID order by l.date desc");
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            if ((oddEven % 2) == 0) {
                    %>
                    <tr>
                        <td class="tableContentText"><%= rs.getString("NAME")%></td>
                        <td class="tableContentText"><%= rs.getString("ACTION")%></td>
                        <td class="tableContentText"><%= rs.getTime("TIME").toString()%></td>
                        <td class="tableContentText"><%= rs.getDate("DATE").toString()%></td>
                    </tr>
                    <%
                        oddEven++;
                    } else {
                    %>
                    <tr>
                        <td class="tableContentText2"><%= rs.getString("NAME")%></td>
                        <td class="tableContentText2"><%= rs.getString("ACTION")%></td>
                        <td class="tableContentText2"><%= rs.getTime("TIME").toString()%></td>
                        <td class="tableContentText2"><%= rs.getDate("DATE").toString()%></td>
                    </tr>
                    <%
                                oddEven++;
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
    <style>
        body {
            zoom: 80%;
        }
    </style>
</html>