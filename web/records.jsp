<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Current Members</title>
        <link href="css/records.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <%
            Connection con = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
            try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
            String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
                   password = getServletContext().getInitParameter("dbPassword"),
                   driverURL = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(driverURL, username, password); //create connection
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - " + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - " + nfe.getMessage());
        }
        try{
            ps = con.prepareStatement("SELECT * FROM LOGIN");
            rs = ps.executeQuery();       
        %>
        <div> <%--search bar thingie lang dito--%> 
            <form>
                <img src="images/SearchIcon.png" class="searchIcon">
                <input type="text" placeholder="Search" class="searchBar">
                <input type="button" hidden />
            </form>
        </div>
        <div class="tableContain" style="overflow-y: scroll; height: 620px;"> <%--dito yun table--%> 
	<table class="tableContent"> 
        <thead>
		<tr>
                    <th class="tableTitle">Name</th>
                    <th class="tableTitle">Address</th>
                    <th class="tableTitle">Contact Number</th>
                    <th class="tableTitle">Status</th>
                    <th class="tableTitle">Paid</th>
		</tr>
         </thead>
         <tbody>
             <%
                  while(rs.next()){
                String emailDB = rs.getString("EMAIL").trim(),
                       passwordDB = rs.getString("PASSWORD").trim(),
                       levelDB = rs.getString("LEVEL").trim();
                       // tbh i just copy pasted everything, aadjust nalang syntax here for real db
                       out.print("<tr><td class=\"tableContentText\">" + emailDB + "</td>");
                       out.print("<td class=\"tableContentText\">" + passwordDB + "</td>");
                       out.print("<td class=\"tableContentText\">" + levelDB + "</td>");
                       out.print("<td class=\"tableContentText\">" + emailDB + "</td>");
                       out.println("<td class=\"tableContentText\">" + emailDB + "</td></tr>");
                }
            }catch(SQLException sqle){
            System.out.println("SQLException IN error occured - " + sqle.getMessage());
            response.sendError(500);
        } finally {
            try {
                if(rs != null)
                    rs.close();
                if(ps != null)
                    ps.close();
                if(con != null)
                    con.close();
            } catch (SQLException sqle) {
                System.out.println("SQLException OUT error occured - " + sqle.getMessage());
                response.sendError(500);
            }
        }
                    %>
         </tbody>
	</table>
        </div>
         <div> <%--div for buttons--%>
             
         </div>
    </body>
</html>
