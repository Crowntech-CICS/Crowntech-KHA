<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
        <link href="css/createacc.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <h1>Create Account</h1>
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
                            <td><input type="text" class="tableContentText" placeholder="Insert text here..."></td>
                            <td><input type="text" class="tableContentText" placeholder="Insert text here..."></td>
                            <td><input type="text" class="tableContentText" placeholder="Insert text here..."></td>
                            <td><input type="text" class="tableContentText" placeholder="Insert text here..."></td>
                        </tr>
                    </tbody>
                </table>
            </div>
                <div class="buttons">
                    <button class="tableB accept">Create</button>
                    <button class="tableB reject">Cancel</button>
                </div>
        </form>
    </body>
</html>
