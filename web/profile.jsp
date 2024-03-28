<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Profile</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/profile-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br><br>
        <div class="d-flex main justify-content-between" id="profileStrip">
            <div class="profileText">
                <p>Eldric B. Basa</p>
                <h1 class="h1-bold" id="profileHeader">Homeowner</h1>
                <p>Address</p>
            </div>
            <div id="profileB" align="right">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button><br/><br/>
                <button class="buttonP" >Edit Information</button>
            </div>
        </div>
        <br>
        <h1 class="h1-bold" id="profileLotHeader">Area 2</h1>
        <ul id="profileStrip" class="accordion">
            <br>
            <div class="d-flex main justify-content-between">
                <h1 class="h1-bold" id="profileAddress"> 123123, San Jose Street</h1>
                <div class="green">
                    <h1 class="panelText"> PAID </h1>
                </div>
            </div>
            <button class="accordion"></button>
            <div class="moreinfo">
                <li class="accordion-content-width">
                    <h1 class="h1-bold" id="profileInfoHeader">Homeowner Info</h1>
                    <div class="line"></div><br>
                    <ul>
                        <li class="accordion-content">Name: Eldric B. Basa</li><br>
                        <li class="accordion-content">Email: eldricbasa@gmail.com</li><br>
                        <li class="accordion-content">Phone: 0917 125 6277</li><br>
                        <li class="accordion-content">Address: Block 7 Lot 13 Q.C.VILLE Townhomes Culiat Quezon City</li>
                    </ul>
                </li>
                <li class="accordion-content-width">
                    <h1 class="h1-bold" id="profileInfoHeader">Lot Residents</h1>
                    <div class="line"></div><br>
                    <ul>
                        <li class="accordion-content">BASA, Eldric B.</li>
                        <li class="accordion-content">Relationship: Sibling</li><br>
                    </ul>
                </li>
                <li class="accordion-content-width">
                    <h1 class="h1-bold" id="profileInfoHeader">Balance Dues</h1>
                    <div class="line"></div><br>
                    <ul>
                        <h1 class="h1-bold" id="profileCashHeader">PHP 300</h1><br>
                        <li class="accordion-content" style="text-align: center;">Status: Paid</li><br>
                        <div class="d-flex main justify-content-between">
                            <button type="button" class="button-design" id="button-small">How To Pay</button>
                            <button type="button" class="button-design" id="button-small" style="margin-right: 0%">Pay Now</button>
                        </div>
                    </ul>
                </li>
            </div>
            <br>
        </ul>
        <br>
        <ul id="profileStrip" class="accordion">
            <br>
            <div class="d-flex main justify-content-between">
                <h1 class="h1-bold" id="profileAddress"> 123123, San Jose Street</h1>
                <div class="green">
                    <h1 class="panelText"> PAID </h1>
                </div>
            </div>
            <button class="accordion"></button>
            <div class="moreinfo">
                <li class="accordion-content-width-two">
                    <h1 class="h1-bold" id="profileInfoHeader">Homeowner Info</h1>
                    <div class="line"></div><br>
                    <ul>
                        <li class="accordion-content">Name: Eldric B. Basa</li><br>
                        <li class="accordion-content">Email: eldricbasa@gmail.com</li><br>
                        <li class="accordion-content">Phone: 0917 125 6277</li><br>
                        <li class="accordion-content">Address: Block 7 Lot 13 Q.C.VILLE Townhomes Culiat Quezon City</li>
                    </ul>
                </li>
                <li class="accordion-content-width-two">
                    <h1 class="h1-bold" id="profileInfoHeader">Balance Dues</h1>
                    <div class="line"></div><br>
                    <ul>
                        <h1 class="h1-bold" id="profileCashHeader">PHP 300</h1><br>
                        <li class="accordion-content" style="text-align: center;">Status: Paid</li><br>
                        <div class="d-flex main justify-content-between">
                            <button type="button" class="button-design" id="button-small">How To Pay</button>
                            <button type="button" class="button-design" id="button-small" style="margin-right: 0%">Pay Now</button>
                        </div>
                    </ul>
                </li>
            </div>
            <br>
        </ul>
    </body>
    <script>
        var acc = document.getElementsByClassName("accordion");
        var i;

        for (i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function () {
                this.classList.toggle("active");
                var panel = this.nextElementSibling;
                if (panel.style.maxHeight) {
                    panel.style.maxHeight = null;
                } else {
                    panel.style.maxHeight = panel.scrollHeight + "px";
                }
            });
        }
    </script>
</html>