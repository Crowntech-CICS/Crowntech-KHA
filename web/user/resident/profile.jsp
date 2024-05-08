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