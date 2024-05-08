package controller.signup;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CreateLogin extends HttpServlet {
    private static final Log logger = LogFactory.getLog(CreateLogin.class);
    protected Connection con;
    protected ResultSet rs;
    protected PreparedStatement ps;
    
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
            throws ServletException, IOException 
    {
        String email = request.getParameter("EMAIL");
        String userid = request.getParameter("USERID");
        String userPassword = model.Encryption.encrypt(request.getParameter("newPassword"), getServletContext().getInitParameter("key"), getServletContext().getInitParameter("cipher"));
        logger.info("CreateLogin processRequest");
        logger.info("EM: " + email);
        logger.info("UID: " + userid);
        logger.info("PWD: " + userPassword);
        //Insert into Database when Found
        try {
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("update users set password = ?, date_registered = now() where userid = ?;");
            ps.setString(1, userPassword);
            ps.setString(2, userid);
            
            String insertStatus = (ps.executeUpdate() > 0)? "Success" : "Failed";
            logger.info("Login insert status: " + insertStatus);
            if(insertStatus.equals("Success")){
                response.sendRedirect("./signup.jsp?suc=true");
            }
        } catch (SQLException sqle) {
            logger.info("SQLException error occurred in try - " + sqle.getMessage());
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
