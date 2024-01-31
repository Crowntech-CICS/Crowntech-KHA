
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
        <link href="css/profile.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="profileStrip">
            <div class="profileText">
                <p class="infoText">LASTNAME, Firstname M.I.</p>
                <h1 class="infoText">HOMEOWNER</h1>
            </div>
            <div class="profileB">
                <button class="buttonP">Vehicles Information</button><br/>
                <button class="buttonP">Edit Information</button>
            </div>
        </div>
        <h2>Area </h2>
        <div class="profileStrip">
            <div class="profileText">
                <h1 class="infoText">
                    House No. & Street 
                </h1>
            </div>
            <div class="profileB area">
                <div class="green">
                    <h1 class="panelText"> PAID </h1>
                </div>
                <button class="buttonA" onclick="openForm()"> V </button>
            </div>
        </div>
        <div class="houseInfo" id="infoForm" style="display: none;">
            INFOMRATION HERE LOL
            <button class="buttonA infoB" onclick="closeForm()"> X </button>
        </div>
        <script>
            function openForm() {
                document.getElementById("infoForm").style.display = "block";
            }

            function closeForm() {
                document.getElementById("infoForm").style.display = "none";
            }
        </script>
    </body>
</html>
