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
    } else if (!session.getAttribute("level").equals("admin")) {
        response.sendRedirect(root + "/index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Create Account</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/table-format.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="greetingBanner">
            <%@include file="/generalpurpose/navbar.jsp" %>
            <div class="main-body">
                <div class="createacc-box">
                    <h1 class="h1-bold">Create Account</h1><%                        if (session.getAttribute("message") != null) {
                    %>
                    <h1 class="h1-bold">${message}</h1>
                    <%
                        }
                    %>
                    <form action="CreateAcc"> <%--Create a CreateAcc servlet --%>
                        <div class="tableContain"> <%--dito yun table--%> 
                            <table class="tableContent" id="createAccWidth"> 
                                <thead>
                                    <tr>
                                        <th class="tableTitle">Last Name</th>
                                        <th class="tableTitle">First Name</th>
                                        <th class="tableTitle">Role</th>
                                        <th class="tableTitle">Email</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><input type="text" name="lastname" class="tableContentText" placeholder="Insert name here..." required></td>
                                        <td><input type="text" name="firstname" class="tableContentText" placeholder="Insert name here..." required></td>
                                        <td>
                                            <select name="userrole" class="select-box">
                                                <option value="Homeowner">Homeowner</option>
                                                <option value="Resident">Resident</option>
                                                <!--<option value="Staff" default>Staff</option>-->
                                            </select>
                                        </td>
                                        <td><input type="text" name="email" class="tableContentText" placeholder="Insert email here..." required></td>
                                    </tr>
                                </tbody>
                            </table>
                            <br><br>
                            <table class="tableContent">
                                <thead>
                                    <tr>
                                        <th class="tableTitle">Password</th>
                                        <th class="tableTitle">OR Number</th>
                                        <th class="tableTitle">Date Registered</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><input type="text" name="password" class="tableContentText" placeholder="Insert password here..." required></td>
                                        <td><input type="text" name="ornum" class="tableContentText" placeholder="Insert OR number here..." minlength="16" maxlength="16" required></td>
                                        <td><input type="date" name="dateoccupied" class="tableContentText" required></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <div class="button-container">
                            <button type="button" onclick="window.history.back();" class="button-design-reject">Cancel</button>
                            <button type="submit" class="button-design">Create</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <style>
        body {
            zoom: 80%;
        }
    </style>
</html>