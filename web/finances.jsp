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
        <div class="financeHolder">
            <table class="tableContent" id="financesLeft">
                <thead>
                    <tr>
                        <th class="tableTitle">Month</th>
                        <th class="tableTitle">Application Fees</th>
                        <th class="tableTitle">Monthly Fees</th>
                        <th class="tableTitle">Balance Dues</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tableContentText">November</td>
                        <td class="tableContentText">6000.0</td>
                        <td class="tableContentText">3000.0</td>
                        <td class="tableContentText">0.0</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">December</td>
                        <td class="tableContentText2">1000.0</td>
                        <td class="tableContentText2">4200.0</td>
                        <td class="tableContentText2">1200.0</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">January</td>
                        <td class="tableContentText">2000.0</td>
                        <td class="tableContentText">3000.0</td>
                        <td class="tableContentText">3600.0</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">February</td>
                        <td class="tableContentText2">3300.0</td>
                        <td class="tableContentText2">1800.0</td>
                        <td class="tableContentText2">2100.0</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">March</td>
                        <td class="tableContentText">4500.0</td>
                        <td class="tableContentText">1800.0</td>
                        <td class="tableContentText">900.0</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">April</td>
                        <td class="tableContentText2">5000.0</td>
                        <td class="tableContentText2">2100.0</td>
                        <td class="tableContentText2">600.0</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Total Funds</td>
                        <td class="tableContentText">21800.0</td>
                        <td class="tableContentText">15900.0</td>
                        <td class="tableContentText">8400.0</td>
                    </tr>
                </tbody>
            </table>
           
            <table class="tableContentR" id="financesRight">
                <tr><td class="tableContentText3">Number of Paid Homeowners: <br><p class="financesP">${homeownerPaid}/${homeownerTotal}</p></td></tr>
                <tr><td class="tableContentText4">Number of Paid Memberships: <br><p class="financesP">${membershipPaid}/${membershipTotal}</p></td></tr>
                <tr><td class="tableContentText5">Number of Paid Lots: <br><p class="financesP">${lotPaid}/${lotTotal}</p></td></tr>
            </table>
        </div>
        <br><br>
        <div class="button-container">
            <form action="ExportPDF">
                <button class="button-design" type="submit" id="button-small">
                    Export
                </button>
            </form>
            <form action="FinanceTrack">
                <button class="button-design" type="submit" id="button-small" style="margin-left: 20%;">
                    Tally
                </button>
            </form>
        </div>
    </body>
</html>