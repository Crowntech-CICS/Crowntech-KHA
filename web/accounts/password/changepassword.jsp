<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="model.Encryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%
    System.out.println("--------------------------------------------------------------------------");
    String resetToken = request.getParameter("rt");
    String rt_userId = resetToken.substring(0, 10).trim();
    String rt_date = resetToken.substring(10).trim();
    String userId = rt_userId; 
    String userEmail = "Email";
    String fullName = "Full Name";
    System.out.println("RT: " + resetToken);
    System.out.println("RT_UID: " + rt_userId);
    System.out.println("RT_DATE: " + rt_date);
    System.out.println("UID: " + userId);
    
    LocalDateTime exp_date = new Timestamp(Long.parseLong(rt_date)).toLocalDateTime();
    System.out.println("Exp Date: " + exp_date.toString());
    
    if(LocalDateTime.now().isAfter(exp_date)){
        //response.sendRedirect("/Crowntech-KHA/");
        System.out.println("Token Expired.");
    } else {System.out.println("Token Still Valid.");}
    
    Connection con = null;
    ResultSet rs = null;
    PreparedStatement ps = null;
    //Establish Connection
    try {
        Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
        String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
               password = getServletContext().getInitParameter("dbPassword"),
               driverURL = getServletContext().getInitParameter("jdbcDriverURL");
        con = DriverManager.getConnection(driverURL, username, password); //create connection
        System.out.println("Connected to DB.");
    } catch (SQLException sqle) {
        System.out.println("SQLException error occurred - " + sqle.getMessage());
    } catch (ClassNotFoundException nfe) {
        System.out.println("ClassNotFoundException error occurred - " + nfe.getMessage());
    }
    //Find user in login table
    try {
            ps = con.prepareStatement("SELECT EMAIL FROM LOGIN WHERE USERID = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                System.out.println("Found UserId in Login");
                userEmail = rs.getString("EMAIL").trim();
            } else {
                //response.sendRedirect("/Crowntech-KHA/");
                System.out.println("UserID not Found in Login");
            }
            ps = con.prepareStatement("SELECT LASTNAME, FIRSTNAME, MIDDLEINITIAL FROM USERS WHERE USERID = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                System.out.println("Found UserId in Users");
                fullName = rs.getString("LASTNAME").trim() + ", " + rs.getString("FIRSTNAME").trim() + " " + rs.getString("MIDDLEINITIAL").trim();;
            } else {
                //response.sendRedirect("/Crowntech-KHA/");
                System.out.println("UserID not Found in Users");
            }
        } catch(SQLException sqle){
            System.out.println("[PR] SQLException IN error occured - " + sqle.getMessage());
            //response.sendError(500);
        } finally {
            try {
                if(rs != null)
                    rs.close();
                if(ps != null)
                    ps.close();
                if(con != null)
                    con.close();
            } catch (SQLException sqle) {
                System.out.println("[PR] SQLException OUT error occured - " + sqle.getMessage());
                //response.sendError(500);
            }
        }    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Password</title>
    <link href="../../css/login.css" rel="stylesheet"/>
    <link href="../../css/navbar.css" rel="stylesheet"/>
</head>
<body>
    <%
        //Change password in database
        if(request.getParameter("newPassword") != null && request.getParameter("newPasswordConfirm") != null){
            //Establish Connection
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
            try {
                String encrpytKey = "RECORDKINGSVILLE";//getServletContext().getInitParameter("key");
                String cipher = "AES/ECB/PKCS5Padding";
                ps = con.prepareStatement("SELECT EMAIL FROM LOGIN WHERE USERID = ?");
                ps.setString(1, userId);
                rs = ps.executeQuery();

                if(rs.next()) {
                    System.out.println("Found UserId in Login");
                    userEmail = rs.getString("EMAIL").trim();
                } else {
                    response.sendRedirect("/Crowntech-KHA/");
                }
                ps = con.prepareStatement("UPDATE LOGIN SET PASSWORD = ? WHERE USERID = ?");
                ps.setString(1, Encryption.encrypt(request.getParameter("newPassword"), encrpytKey, cipher));
                ps.setString(2, userId);
                ps.executeUpdate();
                System.out.println("Changed password successfully.");
                
                response.sendRedirect("/Crowntech-KHA/");
            } catch(SQLException sqle){
                System.out.println("[PR] SQLException IN error occured - " + sqle.getMessage());
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
                    System.out.println("[PR] SQLException OUT error occured - " + sqle.getMessage());
                    //response.sendError(500);
                }
            }
        }
    %>
    <nav> 
        <a href="/Crowntech-KHA/"><img src="../../images/khalogo.png" class="logo"></a>
    </nav>
    <div class="container">
        <form action="?rt=<%=resetToken%>" method="POST">
            <h1>Change Password</h1>
            <h2>Name of User: <%=fullName%></h2>
            <h2>Email of User: <%=userEmail%></h2>
            <label for="newPassword">New Password:</label><input type="text" name="newPassword" required>
            <label for="newPasswordConfirm">Confirm Password:</label><input type="text" name="newPasswordConfirm" required>
            <p>On successful password change, you will be redirected to the login page.</p>
            <div class="button-container" style="margin-top: 1rem;">
                <button>Change Password</button>
            </div>
        </form>
    </div>
</header>
</body>
<style>
    * {
        font-family: sans-serif;
    }
    h1 {
        color: black;
    }
    nav{
        min-width: 100vw;
        background: #4a5c46;
    }
    .container{
        padding: 2rem;
        display: grid;
        width: 100%;
        justify-items: center;
        align-items: center;
    }
    form{
        border-radius: 0.5rem;
        padding: 1rem;
        width: 40%;
        min-width: 600px;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        background-color: white;
    }
</style>
</html>
