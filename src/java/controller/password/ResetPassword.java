package controller.password;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Encryption;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ResetPassword extends HttpServlet {
    private static final Log logger = LogFactory.getLog(ResetPassword.class);
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
        String root = request.getContextPath();
        HttpSession session = request.getSession();
        //Change password in database
        if (request.getParameter("newPassword") != null && request.getParameter("newPasswordConfirm") != null) {
            String userId = (String) session.getAttribute("pw_uid");
            String resetToken = (String) session.getAttribute("pw_rt");
            
            try {
                //Get connection from connection pool
                con = ConnectionPoolManager.getDataSource().getConnection();
                String encrpytKey = getServletContext().getInitParameter("key");
                String cipher = getServletContext().getInitParameter("cipher");
                //Check reset token
                ps = con.prepareStatement("SELECT * FROM CHANGEPASSWORD WHERE CHANGEID = ?");
                ps.setString(1, resetToken);
                rs = ps.executeQuery();

                if (rs.next()) {
                    logger.info("Found reset token");
                    //Update password
                    ps = con.prepareStatement("UPDATE USERS SET PASSWORD = ? WHERE USERID = ?");
                    ps.setString(1, Encryption.encrypt(request.getParameter("newPassword"), encrpytKey, cipher));
                    ps.setString(2, userId);
                    ps.executeUpdate();
                    logger.info("Changed password successfully.");
                    //Delete token from database after use
                    ps = con.prepareStatement("DELETE FROM CHANGEPASSWORD WHERE CHANGEID = ?");
                    ps.setString(1, resetToken);
                    ps.executeUpdate();
                    logger.info("Deleted token from database.");
                    session.invalidate();
                    if(!response.isCommitted())
                        response.sendRedirect(root + "/login.jsp?err=0");
                } else {
                    logger.info("Invalid link");
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
                    logger.info("SQLException OUT error occurred in finally - " + sqle.getMessage());
                    response.sendError(500);
                }
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
