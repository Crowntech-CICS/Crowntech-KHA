<%@page import="model.Vehicle"%>
<%@page import="model.MonthlyBalance"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.UserLot"%>
<%@page import="model.Homeowner"%>
<%@page import="model.User"%>
<%@page import="model.Resident"%>
<%@page import="model.connections.ConnectionPoolManager"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    String root = request.getContextPath();
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect(root + "/accounts/login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Profile</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/table-format.css" rel="stylesheet"/>
        <link href="${root}/css/profile-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body style="overflow-y: scroll">
        <%
            Homeowner user = (Homeowner) session.getAttribute("currUser");
            System.out.println(user.toString());
        %>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <br><br><br><br><br>
        <div class="d-flex main justify-content-between" id="profileStrip">
            <div class="profileText">
                <h1 class="h1-bold" id="profileHeader" style="margin-top: 2%"><%=user.fullName()%></h1>
                <p class="profileOwnerAddress"><b><%=user.getResClass()%></b> - <%=user.getAddress()%></p>
            </div>
            <div class="profileTextsmall">
                <h1 class="h1-bold" id="profileHeader"><%=user.fullName()%></h1>
            </div>
            <%--
            <div id="profileB" align="right">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button><br/><br/>
                <button class="buttonP" onclick="location.href = 'edit-homeowners.jsp'">Edit Information</button>
            </div>
            <div id="profileBsmall">
                <button class="buttonP" onclick="location.href = 'vehicles.jsp'">Vehicles Information</button>
                <button class="buttonP" onclick="location.href = 'edit-homeowners.jsp'">Edit Information</button>
            </div>
            --%>
        </div>
        <%
            if (((String) session.getAttribute("level")).equals("homeowner")) {
                ArrayList<UserLot> lots = user.getLots();
                DecimalFormat numForm = new DecimalFormat("#,##0.00");
                for (int x = 0; x < lots.size(); x++) {
                    out.print("<h1 class=\"h1-bold\" id=\"profileLotHeader\" style=\"margin-left: 6%; text-align: left;\">Area " + lots.get(x).getArea() + "</h1>"
                            + "<ul id=\"profileStripB\" style=\"margin-bottom: 2%;\">"
                            + "<button class=\"accordion\">"
                            + "<div class=\"d-flex main justify-content-between\">");
                    out.print("<h1 class=\"h1-bold\" id=\"profileAddress\">"
                            + lots.get(x).getHouseNo() + " " + lots.get(x).getStreet()
                            + "</h1>");
                    if ((int) lots.get(x).getBalance() <= 0.0) {
                        out.print("<div class=\"green\"><h1 class=\"panelText\"> PAID ");
                    } else if (lots.get(x).getBalance() > 0.0) {
                        out.print("<div class=\"red\"><h1 class=\"panelText\"> UNPAID");
                    } else {
                        System.out.println(lots.get(x).getBalance());
                    }
                    out.print("</h1>"
                            + "</div>"
                            + "</div>"
                            + "</button>"
                            + "<div class=\"moreinfo\">"
                            + "<li class=\"accordion-content-width\">"
                            + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Homeowner Info</h1>"
                            + "<div class=\"line\"></div><br>"
                            + "<ul>"
                            + "<li class=\"accordion-content\">Name: " + user.fullName() + "</li>");
                    out.print("<li class=\"accordion-content\">Email: " + user.getEmail() + "</li>"
                            + "<li class=\"accordion-content\">Phone: " + user.getMobNo() + "</li>"
                            + "<li class=\"accordion-content\">Address: "
                            + lots.get(x).getAddress()
                            + "</li>"
                            + "</ul>"
                            + "</li>");
                    out.print("<li class=\"accordion-content-width\">"
                            + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Lot Residents</h1>"
                            + "<div class=\"line\"></div><br>");

                    ArrayList<Resident> lotResidents = lots.get(x).getResidents();

                    for (int y = 0; y < lotResidents.size(); y++) {
                        out.print("<ul>"
                                + "<li class=\"accordion-content\">" + lotResidents.get(y).fullName() + "</li>"
                                + "<li class=\"accordion-content\">Relationship: " + lotResidents.get(y).getRelationship() + "</li>"
                                + "</ul>"
                                + "</br>");
                    }
                    out.print("<li class=\"accordion-content-width\">"
                            + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Vehicle Information</h1>"
                            + "<div class=\"line\"></div><br>");

                    ArrayList<Vehicle> lotCars = lots.get(x).getCars();
                    System.out.println(lotCars);
                    for (int y = 0; y < lotCars.size(); y++) {
                    System.out.println("Check car: " + lotCars.get(y).getSticker());
                    if(lotCars.get(y).getSticker()) {
                        out.print("<ul>"
                                + "<li class=\"accordion-content\">Plate No. :" + lotCars.get(y).getPlateNo() + "</li>"
                                + "<li class=\"accordion-content\">Relationship: " + lotCars.get(y).getCarDetails() + "</li>"
                                + "</ul>"
                                + "</br>");
                }
                    }
                    out.print("<br>"
                            + "</li>"
                            + "<li class=\"accordion-content-width\">"
                            + "<h1 class=\"h1-bold\" id=\"profileInfoHeader\">Balance Dues</h1>"
                            + "<div class\"line\"></div><br>"
                            + "<ul>");
                    out.print("<h1 class=\"h1-bold\" id=\"profileCashHeader\">PHP "
                            + numForm.format(lots.get(x).getBalance()) + "</h1><br>");

                    ArrayList<MonthlyBalance> lotBalances = lots.get(x).getMonthlyBalances();
                    if (!lotBalances.isEmpty()) {
                        out.print("<table class=\"tableContentProfile\">"
                                + "<thead>"
                                + "<th style=\"font-family: 'Inter'\"> Balance Date:</th>"
                                + "<th style=\"font-family: 'Inter'\"> Balance:</th>"
                                + "</thead>"
                                + "<tbody>");

                        for (MonthlyBalance lotBal : lotBalances) {
                            out.print(
                                    "<tr>"
                                    + "<td style=\"font-family: 'Inter'\">"
                                    + lotBal.getBalanceDate()
                                    + "</td>"
                                    + "<td style=\"font-family: 'Inter'\">"
                                    + lotBal.getBalance()
                                    + "</td>"
                                    + "</tr>");
                        }
                        out.print(
                                "</tbody>"
                                + "</table> "
                                + "<br>");
                    }
                    out.print("<div class=\"button-container\">"
                            + "<button type=\"button\" class=\"button-design\" id=\"button-small\" onclick=\"location.href = 'payment-help.jsp'\">Pay Steps</button>"
                            + "</div></ul></li></div></ul>");
                    out.print("</div>");
                }
            }
        %>
        <style>
            body {
                zoom: 80%;
            }
        </style>
        <script>
            var acc = document.getElementsByClassName("accordion");
            var i;

            for (i = 0; i < acc.length; i++) {
                acc[i].addEventListener("click", function () {

                    var panel = this.nextElementSibling;
                    if (panel.style.display === "block") {
                        panel.style.display = "none";
                    } else {
                        let active = document.querySelectorAll(".accordion");
                        for (let j = 0; j < active.length; j++) {
                            active[j].classList.remove("active");
                            active[j].nextElementSibling.style.display = "none";
                        }
                        this.classList.toggle("active");
                        panel.style.display = "block";
                    }
                });
            }
        </script>
    </body>
</html>