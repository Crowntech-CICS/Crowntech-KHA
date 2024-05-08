package controller.password;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.EmailService;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class RequestPasswordReset extends HttpServlet {
    private static final Log logger = LogFactory.getLog(RequestPasswordReset.class);
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        String root = request.getContextPath();
        logger.info("PasswordReset Servlet processRequest");
        //Get user email address
        String userEmail = request.getParameter("email").toLowerCase();
        int linkExpMinutes = 15;

        try {
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            //FIND EMAIL FROM DB
            ps = con.prepareStatement("SELECT * FROM USERS WHERE LOWER(EMAIL) = ?");
            ps.setString(1, userEmail);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                logger.info("Found in Users");
                boolean validUser = true;
                String userId = rs.getString("USERID").trim();
                String fullName = rs.getString("LASTNAME").trim() + ", " + rs.getString("FIRSTNAME").trim() + " " + rs.getString("MIDDLEINITIAL").trim();
                //Generate URL and set Expiration
                LocalDateTime now = LocalDateTime.now();
                Timestamp created = Timestamp.valueOf(now);
                Timestamp expiration = Timestamp.valueOf(now.plusMinutes(linkExpMinutes));
                String rt = UUID.randomUUID().toString().substring(0,8);
                logger.info("RT: " + rt);
                ps = con.prepareStatement("SELECT CHANGEID FROM CHANGEPASSWORD WHERE CHANGEID = ?");
                ps.setString(1, rt);
                rs = ps.executeQuery();
                //Check for duplicate id
                while(rs.next()) {
                    rt = UUID.randomUUID().toString().substring(0,8);
                    logger.error("DUPLICATE ID, NEW RT: " + rt);
                    ps.setString(1, rt);
                    rs = ps.executeQuery();
                }
                logger.info("FINAL RT: " + rt);
                String url = "http://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/PasswordUrlVerify?rt="+ rt;                          
                
                //If passed all checks and successfully generated data
                if(validUser){
                    ps = con.prepareStatement("INSERT INTO CHANGEPASSWORD(CHANGEID,USERID,CREATED,EXPIRATION) VALUES(?,?,?,?)");
                    ps.setString(1, rt);
                    ps.setString(2, userId);
                    ps.setTimestamp(3, created);
                    ps.setTimestamp(4, expiration);
                    ps.executeUpdate();
                    logger.info("Change Password URL: " + url); 
                    //Sender Email and Contents
                    String from = "crowntech.cics@gmail.com";
                    String password = "cyke ikhz lvhg kzkf";
                    ///String to = userEmail; //Send to user's email
                    String to = "kennethchristopher.fernando.cics@ust.edu.ph"; //CHANGE TO UR EMAIL WHILE TESTING
                    String subject = "Reset your KHA Account Password " + fullName;
                    String message = createEmail(url);
                    
                    logger.info("Sending email to " + to);
                    EmailService.sendHtml(from, password, to, subject, message);
                    logger.info("Email sent.");
                }
                else
                    logger.error("Email not sent, user not found in database.");
                

            } else { //Email not found
                logger.error("Email not Found in Login");
                if(!response.isCommitted())
                    response.sendRedirect(root + "/accounts/password/reset.jsp?err=1");               
            }
            
        } catch(SQLException sqle){
            logger.error("SQLException error occured in try - " + sqle.getMessage());
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
                logger.error("SQLException error occured in finally - " + sqle.getMessage());
                response.sendError(500);
            }
        }
        //Unknown error
        if(!response.isCommitted())
            response.sendRedirect(root + "/accounts/password/reset.jsp?err=0");
    }

    /**
     * 
     * @param url - URL of change password for current user
     * @return formatted HTML email message
     */
    protected String createEmail(String url ){
        logger.info("Creating email message.");
        String message = 
            "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n" +
            "<html xmlns=\"http://www.w3.org/1999/xhtml\" lang=\"en\">\n" +
            "<head>\n" +
            "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n" +
            "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n" +
            "    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\n" +
            "    <link rel=\"stylesheet\" href=\"https://use.fontawesome.com/releases/v5.0.7/css/all.css\">\n" +
            "    <title>Change Password Email</title>\n" +
            "<style>\n" +
            "    @import url(https://fonts.googleapis.com/css?family=Inter);\n" +
            "    :root {\n" +
            "        --bg-color: #b8fad4;\n" +
            "    }\n" +
            "    body {\n" +
            "        margin: 0;\n" +
            "        background-color: #b8fad4;\n" +
            "    }\n" +
            "    table {\n" +
            "        border-spacing: 0;\n" +
            "    }\n" +
            "    td {\n" +
            "        padding: 0;\n" +
            "    }\n" +
            "    img {\n" +
            "        border: 0;\n" +
            "    }\n" +
            "    .wrapper {\n" +
            "        width: 100%;\n" +
            "        table-layout: fixed;\n" +
            "        background-color: var(--bg-color);\n" +
            "        padding-bottom: 60px;\n" +
            "    }\n" +
            "    .main {\n" +
            "        background-color: var(--bg-color);\n" +
            "        margin: 0 auto;\n" +
            "        width: 100%;\n" +
            "        max-width: 600px;\n" +
            "        border-spacing: 0;\n" +
            "        font-family: Inter;\n" +
            "        color: #171a1b;\n" +
            "    }\n" +
            "    .button-design{\n" +
            "    height: 52px; \n" +
            "    width: 280px;\n" +
            "    background: #48a37d;\n" +
            "    border-radius: 50px;\n" +
            "    color: #FFFFFF;\n" +
            "    font-size: 20px;  \n" +
            "    font-family: 'Inter';\n" +
            "    text-align: center;\n" +
            "    display: inline-block;\n" +
            "    transition: background 0.2s ease-out;\n" +
            "    border: none;\n" +
            "    box-shadow: 0 6px 10px rgba(0,0,0,0.15);\n" +
            "    }\n" +
            "    .button-design:hover {\n" +
            "    background-color: #ffffff;\n" +
            "    color: #48a37d;\n" +
            "    border-color: #48a37d;\n" +
            "    border: solid 2px;\n" +
            "    }\n" +
            "</style>\n" +
            "</head>\n" +
            "<body>\n" +
            "    <center class=\"wrapper\" style=\"background-color: #b8fad4;\">\n" +
            "        \n" +
            "        <table class=\"main\" width=\"100%\">\n" +
            "        <!-- TOP MARGIN -->\n" +
            "        <tr>\n" +
            "            <td height=\"32\" style=\"background-color: var(--bg-color);\"></td>\n" +
            "        </tr>    \n" +
            "        <!-- MARGIN -->\n" +
            "        <tr>\n" +
            "            <td height=\"32\" style=\"background-color: var(--bg-color);\"></td>\n" +
            "        </tr>\n" +
            "        <!-- DIVIDER -->\n" +
            "        <tr>\n" +
            "            <td height=\"64px\"></td>\n" +
            "        </tr>\n" +
            "        <!-- LOGO SECTION -->\n" +
            "        <tr>\n" +
            "            <td style=\"text-align: center;background-color: var(--bg-color);\">\n" +
            "                <img src=\"https://github.com/Crowntech-CICS/Crowntech-KHA/blob/master/web/images/khalogo_new.png?raw=true\" alt=\"\" width=\"600px\">\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "        <!-- PASSWORD RESET -->\n" +
            "        <tr>\n" +
            "            <td style=\"text-align: center;background-color: var(--bg-color);\">\n" +
            "                <h1>Reset your password</h1>\n" +
            "                <p>\n" +
            "                    If you forgot or requested to change your password, <br>\n" +
            "                    use the link below to reset it.\n" +
            "                </p>\n" +
            "                <br><br>\n" +
            "                <a href=\"" + url + "\">\n" +
            "                    <input type=\"button\" class=\"button-design\" value=\"Change password\">\n" +
            "                </a>\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "        <!-- DIVIDER -->\n" +
            "        <tr>\n" +
            "            <td height=\"64px\"></td>\n" +
            "        </tr>\n" +
            "        <!-- NOTICE -->\n" +
            "        <tr>\n" +
            "            <td style=\"text-align: center;background-color: var(--bg-color);\">\n" +
            "                <p>If you did not request a password reset, you can safely ignore this email. </p>\n" +
            "            </td>\n" +
            "        </tr>\n" +
            "        <!-- DIVIDER -->\n" +
            "        <tr>\n" +
            "            <td height=\"32px\"></td>\n" +
            "        </tr>\n" +
            "        </table>\n" +
            "    </center>\n" +
            "</body>\n" +
            "</html> ";
        return message;
                
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
