<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Account Level/Type of Current User    
    String level = session.getAttribute("level") != null ? session.getAttribute("level").toString() : "nolog";
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA NAVBAR</title>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <header>
            <nav>
                <a href="${root}/index.jsp"><img src="${root}/images/khalogo_newwhite.png" alt="no image" class="logo"></a>
                <ul class="nav-links">
                    <%
                        String rootPath = request.getContextPath();
                        //Display Corresponding Navigation Options Per Access Level
                        //Staff/Admin/Board Access Level
                        if (level.equals("admin")) {
                            out.println("<li><a href=\"" + rootPath + "/admin/logs.jsp\">Logs</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/admin/accounts.jsp\">Manage Accounts</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/Logout\">Logout</a></li>");
                        } 
                        else if(level.equals("staff") || level.equals("board")){
                            out.println("<li><a href=\"" + rootPath + "/FinanceTrack\">Finances Tracker</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/staff/records.jsp\">Lot Records</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/staff/records-vehicles.jsp\">Vehicle Records</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/Logout\">Logout</a></li>");
                        }//Homeowner/Lessee/Resident Access Level
                        else if (level.equals("homeowner") || level.equals("lessee")) {
                            out.println("<li><a href=\"" + rootPath + "/Logout\">Logout</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/user/profile.jsp\">"
                                    + "<img src=\"" + rootPath + "/images/profile_white.png\" alt=\"star\" class=\"logo-profile\"></a></li>");
                        } else if(level.equals("resident")){
                            out.println("<li><a href=\"" + rootPath + "/Logout\">Logout</a></li>");
                            out.println("<li><a href=\"" + rootPath + "/user/resident/profile.jsp\">"
                                    + "<img src=\"" + rootPath + "/images/profile_white.png\" alt=\"star\" class=\"logo-profile\"></a></li>");
                        }
                    %>
                </ul>
            </nav>
        </header>
    </body>
</html>