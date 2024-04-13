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
    } else if (!session.getAttribute("level").equals("admin") && !session.getAttribute("level").equals("staff")) {
        response.sendRedirect("index.jsp");
    }
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Finances</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
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
                    <tr>
                        <td class="tableContentText">Month</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">Month</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Month</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">Month</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Month</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">Month</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Total Funds</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>