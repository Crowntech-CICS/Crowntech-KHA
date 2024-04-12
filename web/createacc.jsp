<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login.jsp");
    } else if (!session.getAttribute("level").equals("admin") && !session.getAttribute("level").equals("staff")) {
        response.sendRedirect("index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Create Account</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
    </head>
    <body>
        <div class="greetingBanner">
            <%@include file="navbar.jsp" %>
            <div class="main-body">
                <div class="createacc-box">
                    <h1 class="h1-bold">Create Account</h1>
                    <form action="CreateAcc"> <%--Create a CreateAcc servlet --%>
                        <div class="tableContain"> <%--dito yun table--%> 
                            <table class="tableContent"> 
                                <thead>
                                    <tr>
                                        <th class="tableTitle">Name</th>
                                        <th class="tableTitle">Role</th>
                                        <th class="tableTitle">Email</th>
                                        <th class="tableTitle">Password</th>
                                        <th class="tableTitle">OR Number</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><input type="text" name="username" class="tableContentText" placeholder="Insert name here..."></td>
                                        <td>
                                            <select name="userrole" class="select-box">
                                                <option value="null">-----</option>
                                                <option value="Homeowner">Homeowner</option>
                                                <option value="Resident">Resident</option>
                                                <option value="Staff">Staff</option>
                                            </select>
                                        </td>
                                        <td><input type="text" name="email" class="tableContentText" placeholder="Insert email here..."></td>
                                        <td><input type="text" name="password" class="tableContentText" placeholder="Insert password here..."></td>
                                        <td><input type="text" name="ornum" class="tableContentText" placeholder="Insert OR number of Homeowner here..."></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <div class="button-container">
                            <button type="submit" class="button-design">Create</button>
                            <button class="button-design-reject">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
