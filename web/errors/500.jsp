<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kingsville Homeowners Association</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
    <body class="body-error">
        <div style="width: 100%; height: 65%; position: absolute; top:0; bottom: 0; margin: auto;">
            <h1 class="h1-bold-error-bigger">🚨 Oh No! 🚨</h1>
            <h1 class="h1-bold-error">Error 500 - Server Error</h1>
            <p class="p-error">Oops! Something went wrong.</p>
            <p class="p-error">Try refreshing the page or go back to the main menu.</p>
            <br><br>
            <div class="button-container">
                <a href="${root}/generalpurpose/index.jsp"><button class="button-design-reject" style="margin-left: 0%;">
                        Back To Main Menu
                    </button></a>
            </div>
        </div>
    </body>
</html>