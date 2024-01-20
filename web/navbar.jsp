<%-- 
    Document   : navbar
    Created on : 01 20, 24, 1:53:29 PM
    Author     : ejlu1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA NAVBAR</title>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <% 
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Expires","0");
            
        %>
        <header>
            <nav>
                <img src="images/khalogo.png" alt="no image" class="logo">
                <ul class="nav-links">
                    <%
                    if((2+2) > 5) {
                    
                        out.println("<li><a href=\"login.jsp\">Login</a></li>");
                    }
                    else {
                        out.println("<li><a href=\"records.jsp\">Records Viewing</a></li>");
                        out.println("<li><a href=\"finances.jsp\">HOA Finances</a></li>");
                        out.println("<li><a href=\"LogoutServlet\">Logout</a></li>");
                        out.println("<li><a href=\"profile.jsp\">"+
                        " <img src=\"images/profile.png\" alt=\"star\" class=\"logo-profile\"></a></li>");
                        }
                    %>
                </ul>
            </nav>
        </header>
    </body>
</html>