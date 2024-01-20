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
        <link rel="icon" type="image/x-icon" href="images/KHA_Logo.png"/>
        <link href="CSS/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <% 
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            response.setHeader("Expires","0");
            
        %>
        <header>
            <nav>
                <img src="images/navbar/KHA_Logo.png" class="logo">
                <ul class="nav-links">
                    <%
                    if((2+2) > 5) {
                    
                        out.println("<li><a href=\"login.jsp\">Login</a></li>");
                    }
                    else {
                        out.println("<li><a href=\"index.jsp\">Records Viewing</a></li>");
                        out.println("<li><a href=\"about-us.jsp\">HOA Finances</a></li>");
                        out.println("<li><a href=\"LogoutServlet\">Logout</a></li>");
                    //    out.println("<li><a href=\"ShoppingCart\">"+ session.getAttribute("newUsername") + 
                    //    " <img src=\"https://www.pngkey.com/png/full/231-2317482_white-shopping-cart-png-download-buy-icon-white.png\" alt=\"star\" class=\"logo-cart\"></a></li>");
                        }
                    %>
                </ul>
            </nav>
        </header>
    </body>
</html>