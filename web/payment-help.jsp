<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<<<<<<< HEAD:web/user/payment-help.jsp
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Payment</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/profile-format.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br><br>
        <ul id="profileStrip" class="accordion">
            <br>
            <h1 class="h1-bold" id="profileAddress">How To Pay: Over the Counter</h1>
            <button class="accordion"></button>
            <div class="moreinfo" id="payment-help-margin">
                <p>Step 1. Go to the KHA Office in the subdivision clubhouse</p>
                <p>Step 2. Ask for your current balance through the counter</p>
                <p>Step 3. Pay the amount through cash</p>
                <p>Step 4. Wait for your receipt</p>
                <p>Step 5. DONE!</p>
            </div>
        </ul>
        <br><br>
        <ul id="profileStrip" class="accordion">
            <br>
            <h1 class="h1-bold" id="profileAddress">How To Pay: Bank Transfer</h1>
            <button class="accordion"></button>
            <div class="moreinfo" id="payment-help-margin">
                <p>Step 1. Log into your bank's website or connect via the bank's app.</p>
                <p>Step 2. Click on the transfer feature and choose transfer to another bank.</p>
                <p>Step 3. Enter the routing and account numbers for the account at the other bank.</p>
                <p>Step 4. Make the transfer.</p>
                <p>Step 5. Your bank may require verification that you are the owner of the other account. The transfer likely will take one to two days or maybe more if verification is needed.</p>
                <p>Step 6. DONE!</p>
            </div>
            <br>
        </ul>
    </body>
    <style>
        p {
            margin-left: 2%;
            margin-bottom: 1.5%;
        }
    </style>
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