<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KHA | Vehicle Information</title>
    <link rel="icon" type="image/x-icon" href="images/khaicon.png">
    <link href="css/main-format.css" rel="stylesheet"/>
    <link href="css/profile-format.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>
    <div class="greetingBanner">
        <%@include file="navbar.jsp" %>
        <br>
        <div class="main-body">
            <div class="vehicle-container">
                <div class="vehicle-box">
                    <p style="text-align: center;padding-top: 2%">PLATE NUMBER - BRAND MODEL/YEAR - OWNER</p>
                    <h1 class="h1-bold" style="margin: -2% 0% 2% 0%">Vehicle Information</h1>
                    <div class="line"></div>
                    <br>
                    <div class="d-flex main justify-content-between" style="margin: 0% 5% 0% 5%">
                        <div><p>Plate Number: </p>
                            <p>Registered Owner: </p>
                            <p>Brand: </p>
                            <p>Year/Model: </p></div>
                        <div><p class="p-right">AAA 111</p>
                            <p>LASTNAME, Firstname</p>
                            <p class="p-right">Ferrari</p>
                            <p class="p-right">2025</p>
                        </div>
                    </div>
                    <div class="button-container">
                        <button class="buttonP" >Edit Information</button>
                    </div>
                </div>
                <br>
                <div class="vehicle-box">
                    <p style="text-align: center;padding-top: 2%">PLATE NUMBER - BRAND MODEL/YEAR - OWNER</p>
                    <h1 class="h1-bold" style="margin: -2% 0% 2% 0%">Vehicle Information</h1>
                    <div class="line"></div>
                    <br>
                    <div class="d-flex main justify-content-between" style="margin: 0% 5% 0% 5%">
                        <div><p>Plate Number: </p>
                            <p>Registered Owner: </p>
                            <p>Brand: </p>
                            <p>Year/Model: </p></div>
                        <div><p class="p-right">AAA 111</p>
                            <p>LASTNAME, Firstname</p>
                            <p class="p-right">Ferrari</p>
                            <p class="p-right">2025</p>
                        </div>
                    </div>
                    <div class="button-container">
                        <button class="buttonP" >Edit Information</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>