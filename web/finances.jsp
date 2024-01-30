<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/records.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Document</title>
</head>
<body style="overflow: hidden;">
    <%@include file="navbar.jsp" %>
    <div>
        <form class="sortSearch" action="" style="margin:auto; margin-top: 5px; max-width: 1800px;">
            <input type="text" placeholder="Search.." name="search">
            <button type="submit"><i class="fa fa-search"></i></button>
        </form>
    </div>
    <div style="display: flex; justify-content: center; max-height: 80%">
        <table class="tableContent" style="width: 60%;height: 100%;">
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
                    <td class="tableContentText">Month</td>
                    <td class="tableContentText">$$</td>
                    <td class="tableContentText">$$</td>
                </tr>
                <tr>
                    <td class="tableContentText">Month</td>
                    <td class="tableContentText">$$</td>
                    <td class="tableContentText">$$</td>
                </tr>
                <tr>
                    <td class="tableContentText">Month</td>
                    <td class="tableContentText">$$</td>
                    <td class="tableContentText">$$</td>
                </tr>
                <tr>
                    <td class="tableContentText">Month</td>
                    <td class="tableContentText">$$</td>
                    <td class="tableContentText">$$</td>
                </tr>
                <tr>
                    <td class="tableContentText">Month</td>
                    <td class="tableContentText">$$</td>
                    <td class="tableContentText">$$</td>
                </tr>
                <tr>
                    <td class="tableContentText">Total Funds</td>
                    <td class="tableContentText">$$</td>
                    <td class="tableContentText">$$</td>
                </tr>
            </tbody>
        </table>

        <table class="tableContent" style="width: 30%;height: 120%;">
            <tr><td class="tableContentText" style="font-weight: bold; font-size: 2rem;">Number of Paid Homeowners: <br><p style="font-weight: normal;">89/102</p></td></tr>
            <tr><td class="tableContentText" style="font-weight: bold; font-size: 2rem;">Number of Paid Lessees: <br><p style="font-weight: normal;">20/23</p></td></tr>
            <tr><td class="tableContentText" style="font-weight: bold; font-size: 2rem;">Number of Residents: <br><p style="font-weight: normal;">1502</p></td></tr>
        </table>
        
    </div>
    <button style="padding: 1rem 2rem; margin: 0 50%; font-size: 2rem;">
        Export
    </button>
    
</body>
</html>