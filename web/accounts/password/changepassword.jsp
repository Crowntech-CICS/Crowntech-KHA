<%@page import="java.sql.Timestamp"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="model.Encryption"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<% request.setAttribute("root", request.getContextPath());%>
<%
    String root = request.getContextPath();
    System.out.println("-[CHG-PW]-------------------------------------------------------------------------");
    String resetToken = request.getParameter("rt");
    String userId = "";
    Timestamp expiration = null;
    String userEmail = "Email";
    String fullName = "Full Name";
    System.out.println("RT: " + resetToken);

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
    
    try {
        //Get ChangePassword Data using rt
        ps = con.prepareStatement("SELECT * FROM CHANGEPASSWORD WHERE CHANGEID = ?");
        ps.setString(1, resetToken);
        rs = ps.executeQuery();
        if(rs.next()){
            userId = rs.getString("USERID");
            expiration = rs.getTimestamp("EXPIRATION");
            if(expiration.before(Timestamp.valueOf(LocalDateTime.now()))){
                System.out.println("URL is expired.");
                //Delete expired token
                ps = con.prepareStatement("DELETE FROM CHANGEPASSWORD WHERE CHANGEID = ?");
                ps.setString(1, resetToken);
                ps.executeUpdate();
                System.out.println("Deleted token from database.");
                response.sendRedirect(root + "/login.jsp?err=4");
            }
            //Find user in login table
            ps = con.prepareStatement("SELECT EMAIL FROM LOGIN WHERE USERID = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("Found UserId in Login");
                userEmail = rs.getString("EMAIL").trim();
            } else {
                System.out.println("UserID not Found in Login");
                response.sendRedirect(root);
            }
            ps = con.prepareStatement("SELECT LASTNAME, FIRSTNAME, MIDDLEINITIAL FROM USERS WHERE USERID = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("Found UserId in Users");
                fullName = rs.getString("LASTNAME").trim() + ", " + rs.getString("FIRSTNAME").trim() + " " + rs.getString("MIDDLEINITIAL").trim();;
                System.out.println("Name: " + fullName);
            } else {
                System.out.println("UserID not Found in Users");
                response.sendRedirect(root);
            }
        } else {
            System.out.println("Invalid reset token.");
            response.sendRedirect(root + "/login.jsp?err=3");
        }
        
    } catch (SQLException sqle) {
        System.out.println("[PR] SQLException IN error occured - " + sqle.getMessage());
        response.sendError(500);
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException sqle) {
            System.out.println("[PR] SQLException OUT error occured - " + sqle.getMessage());
            response.sendError(500);
        }
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Change Password</title>
        <link rel="icon" type="image/x-icon" href="${root}/images/khaicon.png">
        <link href="${root}/css/main-format.css" rel="stylesheet"/>
        <link href="${root}/css/form-format.css" rel="stylesheet"/>
        <link href="${root}/css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%
            //Change password in database
            if (request.getParameter("newPassword") != null && request.getParameter("newPasswordConfirm") != null) {
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
                    String encrpytKey = getServletContext().getInitParameter("key");
                    String cipher = getServletContext().getInitParameter("cipher");
                    ps = con.prepareStatement("SELECT EMAIL FROM LOGIN WHERE USERID = ?");
                    ps.setString(1, userId);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        System.out.println("Found UserId in Login");
                        userEmail = rs.getString("EMAIL").trim();
                    } else {
                        System.out.println("UserID not in Login");
                        response.sendRedirect(root + "/login.jsp?err=5");
                    }
                    ps = con.prepareStatement("UPDATE LOGIN SET PASSWORD = ? WHERE USERID = ?");
                    ps.setString(1, Encryption.encrypt(request.getParameter("newPassword"), encrpytKey, cipher));
                    ps.setString(2, userId);
                    ps.executeUpdate();
                    System.out.println("Changed password successfully.");
                    //Delete token from database after use
                    ps = con.prepareStatement("DELETE FROM CHANGEPASSWORD WHERE CHANGEID = ?");
                    ps.setString(1, resetToken);
                    ps.executeUpdate();
                    System.out.println("Deleted token from database.");
                    
                    response.sendRedirect(root);
                } catch (SQLException sqle) {
                    System.out.println("[PR] SQLException IN error occured - " + sqle.getMessage());
                    response.sendError(500);
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                        if (ps != null) {
                            ps.close();
                        }
                        if (con != null) {
                            con.close();
                        }
                    } catch (SQLException sqle) {
                        System.out.println("[PR] SQLException OUT error occured - " + sqle.getMessage());
                        response.sendError(500);
                    }
                }
            }
        %>
        <nav> 
            <a href="${root}"><img src="${root}/images/khalogo_newwhite.png" class="logo"></a>
        </nav>
        <div class="main-body">
            <div class="changepass-box">
                <form action="" method="POST" id="passForm" onsubmit="return validate()">
                    <h1 class="h1-bold">Change Password</h1>
                    <h2 class="changepass-text"><span class="h2-bold">Username:</span> <%= fullName %></h2>
                    <h2 class="changepass-text"><span class="h2-bold">Email:</span> <%= userEmail %></h2>
                    <div class="changepass-label-container">
                        <label for="newPassword">Create New Password:</label><br><input type="text" name="newPassword" id="newPassword" class="form" required><br>
                        <label for="newPasswordConfirm">Confirm New Password:</label><br><input type="text" name="newPasswordConfirm" id="newPasswordConfirm" class="form" required>
                        <p>Upon successful password change, you will be redirected back to the login page.</p>
                    </div>
                    <div class="button-container" style="margin-top: 1rem;">
                        <button class="button-design">Change Password</button>
                    </div>
                </form>
            </div>
        </div>
    </body>
    <script>
        function validate(){
            if(document.getElementById('newPassword').value === document.getElementById('newPasswordConfirm').value){               
                alert("Your password is changed successfully you may now login.");
                return true;
            } else {
                alert("The two passwords inputted are not identical. Please recheck your inputs.");
                return false;
            }
        }
    </script>
</html>
