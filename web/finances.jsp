<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KHA | Finances</title>
    <link href="css/main-format.css" rel="stylesheet"/>
    <link href="css/table-format.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Document</title>
</head>
<body>
    <%@include file="navbar.jsp" %>
    <br><br>
    <div>
        <form class="sortSearch" action="" style="margin:auto; margin-top: 5px; max-width: 1800px;">
            <input type="text" placeholder="Search.." name="search">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>
    <br>
    <div style="display: flex; justify-content: center; max-height: 80%">
        <table class="tableContent" style="width: 50%;height: 100%;">
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

        <table class="tableContent" style="margin-left: -10%; width: 10%;height: 120%;">
            <tr><td class="tableContentText3">Number of Paid Homeowners: <br><p style="text-align: center; color: white;">89/102</p></td></tr>
            <tr><td class="tableContentText3">Number of Paid Lessees: <br><p style="text-align: center; color: white;">20/23</p></td></tr>
            <tr><td class="tableContentText3">Number of Residents: <br><p style="text-align: center; color: white;">1502</p></td></tr>
        </table>
    </div>
    <br><br>
<div class="button-container">
    <button class="button-design">
        Export
    </button>
</div>
</body>
</html>