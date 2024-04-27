package controller.password;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class UrlVerify extends HttpServlet {
    private static final Log logger = LogFactory.getLog(UrlVerify.class);
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        logger.info("UrlVerify processRequest");
        String root = request.getContextPath();
        HttpSession session = request.getSession();
        String resetToken = request.getParameter("rt");
        logger.info("RT: " + resetToken);


        try {
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            //Get ChangePassword Data using rt
            ps = con.prepareStatement("SELECT * FROM CHANGEPASSWORD WHERE CHANGEID = ?");
            ps.setString(1, resetToken);
            rs = ps.executeQuery();
            if(rs.next()){
                String userId = rs.getString("USERID");
                Timestamp expiration = rs.getTimestamp("EXPIRATION");
                //Check if link expired
                if(expiration.before(Timestamp.valueOf(LocalDateTime.now()))){
                    logger.info("URL is expired.");
                    //Delete expired token
                    ps = con.prepareStatement("DELETE FROM CHANGEPASSWORD WHERE CHANGEID = ?");
                    ps.setString(1, resetToken);
                    ps.executeUpdate();
                    logger.info("Deleted token from database.");
                    response.sendRedirect(root + "/login.jsp?err=4");
                }
                //Find user in login table
                ps = con.prepareStatement("SELECT * FROM USERS WHERE USERID = ?");
                ps.setString(1, userId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    logger.info("Found User");
                    String userEmail = rs.getString("EMAIL").trim();
                    String fullName = rs.getString("LASTNAME").trim() + ", " + rs.getString("FIRSTNAME").trim() + " " + rs.getString("MIDDLEINITIAL").trim();
                    logger.info("Name: " + fullName);
                    session.setAttribute("pw_em", userEmail);
                    session.setAttribute("pw_fn", fullName);
                    session.setAttribute("pw_rt", resetToken);
                    session.setAttribute("pw_uid", userId);
                    response.sendRedirect(root + "/accounts/password/changepassword.jsp");
                } else {
                    logger.info("User not found");
                    response.sendRedirect(root);
                }

            } else {
                logger.info("Invalid reset token.");
                if(!response.isCommitted())
                    response.sendRedirect(root + "/login.jsp?err=3");
            }

        } catch (SQLException sqle) {
            logger.info("SQLException error occurred in try - " + sqle.getMessage());
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
                logger.info("SQLException error occurred in finally - " + sqle.getMessage());
                response.sendError(500);
            }
        }
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
