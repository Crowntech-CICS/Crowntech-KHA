<%@page contentType="text/html" pageEncoding="UTF-8"%>
<<<<<<< HEAD
<<<<<<< HEAD:web/admin/createacc.jsp
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("../login/login.jsp");
    } else if (!session.getAttribute("level").equals("admin") && !session.getAttribute("level").equals("staff")) {
        response.sendRedirect("../index.jsp");
    }
%>
=======
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page):web/createacc.jsp
=======
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page)
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>KHA | Create Account</title>
<<<<<<< HEAD
<<<<<<< HEAD:web/admin/createacc.jsp
        <link rel="icon" type="image/x-icon" href="../images/khaicon.png">
        <link href="../css/main-format.css" rel="stylesheet"/>
        <link href="../css/table-format.css" rel="stylesheet"/>
        <link href="../css/navbar.css" rel="stylesheet"/>
=======
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page):web/createacc.jsp
=======
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
>>>>>>> parent of 7469f85 (organized .jsp files, added script so that users cannot go back to page)
    </head>
    <body>
        <div class="greetingBanner">
            <%@include file="../navbar.jsp" %>
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
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><input type="text" class="tableContentText" placeholder="Insert name here..."></td>
                                        <td>
                                            <select class="select-box">
                                                <option value="null">-----</option>
                                                <option value="Admin">Admin</option>
                                                <option value="User">User</option>
                                            </select>
                                        </td>
                                        <td><input type="text" class="tableContentText" placeholder="Insert email here..."></td>
                                        <td><input type="text" class="tableContentText" placeholder="Insert password here..."></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <br>
                        <div class="button-container">
                            <button class="button-design">Create</button>
                            <button class="button-design-reject">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>