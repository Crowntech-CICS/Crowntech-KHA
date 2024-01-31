<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/records.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Transactions</title>
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
                    <th class="tableTitle">Name</th>
                    <th class="tableTitle">Address</th>
                    <th class="tableTitle">Date</th>
                    <th class="tableTitle">Receipt</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="tableContentText">Member1</td>
                    <td class="tableContentText">1 A St.</td>
                    <td class="tableContentText">1/31/2024</td>
                    <td class="tableContentText"><button>View Receipt</button></td>
                </tr>
                <tr>
                    <td class="tableContentText">Member2</td>
                    <td class="tableContentText">2 A St.</td>
                    <td class="tableContentText">1/31/2024</td>
                    <td class="tableContentText"><button>View Receipt</button></td>
                </tr>
                <tr>
                    <td class="tableContentText">Member3</td>
                    <td class="tableContentText">3 A St.</td>
                    <td class="tableContentText">1/31/2024</td>
                    <td class="tableContentText"><button>View Receipt</button></td>
                </tr>
                <tr>
                    <td class="tableContentText">Member4</td>
                    <td class="tableContentText">4 A St.</td>
                    <td class="tableContentText">1/31/2024</td>
                    <td class="tableContentText"><button>View Receipt</button></td>
                </tr>
                <tr>
                    <td class="tableContentText">Member5</td>
                    <td class="tableContentText">5 A St.</td>
                    <td class="tableContentText">1/31/2024</td>
                    <td class="tableContentText"><button>View Receipt</button></td>
                </tr>
            </tbody>
        </table>       
    </div>
</body>
<style>
    button{
        padding: 1rem;
        border-radius: 0.5rem;
    }
</style>
</html>
