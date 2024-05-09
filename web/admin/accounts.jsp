<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    String root = request.getContextPath();
    //Check Logged In State
    boolean logState = session.getAttribute("level") != null ? true : false;
    if (!logState) {
        response.sendRedirect(root + "/accounts/login.jsp");
    } else if (!session.getAttribute("level").equals("admin")) {
        response.sendRedirect(root + "/index.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Manage Accounts</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png"/>
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="/generalpurpose/navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-small">
                <form id="form1">
                    <h1 id="h1small" class="h1-bold">Accounts Manager</h1>
                    <div class="line"></div>
                    <h1 id="h1small" class="h1-bold">Create Accounts</h1>
                    <div style="display:grid; gap:0.5rem;justify-content: center">
                        <a href="${root}/accounts/signup/signup-homeowners.jsp"><input class="button-design" type="button" value="Create Homeowner"></a>
                        <a href="${root}/accounts/signup/signup-resident.jsp"><input class="button-design" type="button" value="Create Resident"></a>
                        <a href="${root}/accounts/signup/signup-admin.jsp"><input class="button-design" type="button" value="Create Staff/Admin/Bod"></a>
                    </div>
                    <br>
                    <div class="line"></div>
                    <h1 id="h1small" class="h1-bold">Edit Accounts</h1>
                    <div style="display:grid; gap:0.5rem;justify-content: center">
                        <a href=""><input class="button-design" type="button" value="Edit Homeowner"></a>
                        <a href=""><input class="button-design" type="button" value="Edit Resident"></a>
                        <a href=""><input class="button-design" type="button" value="Edit Staff/Admin/Bod"></a>
                    </div>
                </form>
                
            </div>
        </div>
        <script>
            window.onload = function () {
                var params = new URLSearchParams(window.location.search);
                if (params.get('suc') === 'true') {
                    alert('Successfully added Resident to the records.');
                    window.location.href = '${root}/records.jsp';
                }
                if (params.get('err') == 1) {
                    alert('Record already exists or there is a conflicting record in the database.');
                }
            };

            var form1 = document.getElementById("form1");
            var finalForm = document.getElementById('finalForm');

            var Next1 = document.getElementById("Next1");
            var Back1 = document.getElementById("Back1");

            Next1.onclick = function () {
                const f1 = [
                    {name: "RES_LN", message: "Missing Last Name."},
                    {name: "RES_FN", message: "Missing First Name."},
                    {name: "RES_MI", message: "Missing Middle Initial."},
                    {name: "RES_AGE", message: "Missing Age."},
                    {name: "RES_EMAIL", message: "Missing Email."},
                    {name: "RES_LANDLINE", message: "Missing Landline."},
                    {name: "RES_PHONE", message: "Missing Phone Number."},
                    {name: "RES_REL", message: "Invalid Relationship."}
                ];
                for (let i = 0; i < f1.length; i++) {
                    const field = f1[i];
                    const inputField = form1[field.name];
                    console.log("Checking " + field.name);
                    if (inputField.value === "") {
                        alert(field.message);
                        return false;
                    }
                    finalForm[field.name].value = inputField.value;
                }
                finalform.submit();
            };
        </script>
    </body>
</html>