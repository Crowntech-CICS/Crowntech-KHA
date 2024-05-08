<%@page import="model.Vehicle"%>
<%@page import="model.Resident"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.UserLot"%>
<%@page import="model.User"%>
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
        <link href="${root}/css/profile-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    </head>
    <body style="overflow-y: scroll">
        <%
            Resident user = (Resident) session.getAttribute("currUser");
        %>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <br><br><br><br><br>
        <div class="d-flex main justify-content-between" id="profileStrip">
            <div class="profileText">
                <p class="profileOwnerName"><%=user.fullName()%></p>
                <h1 class="h1-bold" id="profileHeader"><%=user.getResClass()%></h1>
                <p class="profileOwnerAddress"><%=user.getResLot().getAddress()%></p>
            </div>
            <div class="profileTextsmall">
                <h1 class="h1-bold" id="profileHeader">Homeowner</h1>
            </div>
        </div>
        <%
            ArrayList<Vehicle> cars = user.getCars();
            if (cars.size() > 0) {
                out.print("<div class=\"main-body\" id=\"vehicle-body\" style=\"height: 60%; top: 37%;\">"
                        + "<h1 class=\"h1-bold\">Vehicle List</h1>");
                for (int x = 0; x < cars.size(); x++) {
                    out.print(
                            "<div class=\"vehicle-box\">"
                            + "<p style=\"text-align: center;padding-top: 2%\">"
                            + cars.get(x).getPlateNo() + " - "
                            + cars.get(x).getBrand() + " " + cars.get(x).getModel() + " " + " - "
                            + cars.get(x).getRegisteredOwner()
                            + "</p>"
                            + "<h1 class=\"h1-bold\" style=\"margin: -2% 0% 2% 0%\">Vehicle Information</h1>"
                            + "<div class=\"line\"></div>"
                            + "<br>"
                            + "<div class=\"d-flex main justify-content-between\" style=\"margin: 0% 5% 0% 5%\">"
                            + "<div><p id=\"p-dark\">Plate Number: </p>"
                            + "<p id=\"p-dark\">Registered Owner: </p>"
                            + "<p id=\"p-dark\">Brand: </p>"
                            + "<p id=\"p-dark\">Year/Model: </p></div>"
                            + "<div><p id=\"p-dark\" class=\"p-right\">" + cars.get(x).getPlateNo() + " </p>"
                            + "<p id=\"p-dark\" class=\"p-right\">" + cars.get(x).getRegisteredOwner() + " </p>"
                            + "<p id=\"p-dark\" class=\"p-right\">" + cars.get(x).getBrand() + " </p>"
                            + "<p id=\"p-dark\" class=\"p-right\">" + cars.get(x).getType() + " " + cars.get(x).getModel() + "</p>"
                            + "</div>"
                            + "</div>"
                            + "<br>"
                            + "</div>"
                            + "<br>");
                }
            }
        %>
    </body>
</html>