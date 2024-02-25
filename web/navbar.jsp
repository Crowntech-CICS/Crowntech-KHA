<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires","0");
    //Check Account Level/Type of Current User    
    String level = session.getAttribute("level") != null ? session.getAttribute("level").toString() : "nolog";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA NAVBAR</title>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav>
                <a href="."><img src="images/khalogo.png" alt="no image" class="logo"></a>
                <ul class="nav-links">
                    <%
                    //Display Corresponding Navigation Options Per Access Level
                    //Staff/Admin/Board Access Level
                    if(level.equals("admin") ||level.equals("staff") || level.equals("board")){
                        out.println("<li><a href=\"records.jsp\">Records Viewing</a></li>");
                        out.println("<li><a href=\"finances.jsp\">Monthly Dues Tracker</a></li>");
                        out.println("<li><a href=\"applications.jsp\">Applications</a></li>");
                        out.println("<li><a href=\"Logout\">Logout</a></li>");
                        out.println("<li><a href=\"createacc.jsp\">Create Account</a></li>");
                        out.println("<li><a href=\"profile.jsp\">"+
                                    "<img src=\"images/profile_white.png\" alt=\"star\" class=\"logo-profile\"></a></li>");

                    }
                    //Homeowner/Lessee/Resident Access Level
                    else if(level.equals("homeowner") || level.equals("lessee") || level.equals("resident")){
                        out.println("<li><a href=\"Logout\">Logout</a></li>");
                        out.println("<li><a href=\"profile.jsp\">"+
                                    "<img src=\"images/profile_white.png\" alt=\"star\" class=\"logo-profile\"></a></li>");
                    }
                    %>
                </ul>
            </nav>
        </header>
    </body>
</html>