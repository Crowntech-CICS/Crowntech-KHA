<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<<<<<<< HEAD
<<<<<<< HEAD:web/admin/finances.jsp
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login/login.jsp");
    } else if (!session.getAttribute("level").equals("admin") && !session.getAttribute("level").equals("staff")) {
        response.sendRedirect("../index.jsp");
    }
%>
=======
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page):web/finances.jsp
=======
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page)
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Finances</title>
<<<<<<< HEAD
<<<<<<< HEAD:web/admin/finances.jsp
        <link rel="icon" type="image/x-icon" href="../images/khaicon.png">
        <link href="../css/main-format.css" rel="stylesheet"/>
        <link href="../css/table-format.css" rel="stylesheet"/>
        <link href="../css/navbar.css" rel="stylesheet"/>
=======
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page):web/finances.jsp
=======
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page)
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="../navbar.jsp" %>
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
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="tableContentText">Month</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">Month</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Month</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">Month</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Month</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText2">Month</td>
                        <td class="tableContentText2">$$</td>
                        <td class="tableContentText2">$$</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Total Funds</td>
                        <td class="tableContentText">$$</td>
                        <td class="tableContentText">$$</td>
                    </tr>
                </tbody>
            </table>

            <table class="tableContentR" id="financesRight">
                <tr><td class="tableContentText3">Number of Paid Homeowners: <br><p class="financesP">89/102</p></td></tr>
                <tr><td class="tableContentText4">Number of Paid Lessees: <br><p class="financesP">20/23</p></td></tr>
                <tr><td class="tableContentText5">Number of Residents: <br><p class="financesP">1502</p></td></tr>
            </table>
        </div>
        <br><br>
        <div class="button-container">
            <form action="ExportPDF">
                <button class="button-design" type="submit">
                    Export
                </button>
            </form>
        </div>
    </body>
</html>
