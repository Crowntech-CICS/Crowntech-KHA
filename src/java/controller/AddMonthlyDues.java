package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class AddMonthlyDues extends HttpServlet {
    private static final Log logger = LogFactory.getLog(AddMonthlyDues.class);
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
        HttpSession session = request.getSession();
        String loggedInUser = (String) session.getAttribute("currID");
        double monthlyDue = 300.00;
        double balance = 0.0;
        boolean paid = false;
        logger.info("--[ADD DUES]------------------------------------------------------");
        
        try{
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("SELECT HOMEOWNERID,BALANCE FROM USERLOT");
            rs = ps.executeQuery();
            while(rs.next()){
                balance = rs.getDouble("BALANCE") + monthlyDue;
                logger.info("HID: " + rs.getString("HOMEOWNERID")+ " OLDBAL: " + rs.getDouble("BALANCE") + " NEWBAL: " + balance);
                ps = con.prepareStatement("UPDATE USERLOT SET BALANCE = ?, PAID = ? WHERE HOMEOWNERID = ?");
                ps.setDouble(1, balance);
                ps.setBoolean(2, paid);
                ps.setString(3, rs.getString("HOMEOWNERID"));
                ps.executeUpdate();
            }
            
            ps = con.prepareStatement("SELECT HOMEOWNERID,BALANCE FROM HOMEOWNER");
            rs = ps.executeQuery();
            while(rs.next()){
                balance = rs.getDouble("BALANCE") + monthlyDue;
                logger.info("HID: " + rs.getString("HOMEOWNERID")+ " OLDBAL: " + rs.getDouble("BALANCE") + " NEWBAL: " + balance);
                ps = con.prepareStatement("UPDATE HOMEOWNER SET BALANCE = ?, PAID = ? WHERE HOMEOWNERID = ?");
                ps.setDouble(1, balance);
                ps.setBoolean(2, paid);
                ps.setString(3, rs.getString("HOMEOWNERID"));
                ps.executeUpdate();
            }
            logger.info("SUCCESSFULLY ADDED MONTHLY DUES TO ALL HOMEOWNERS.");
            logger.info("Logged In user: " + loggedInUser);
            logger.info("------------------------------------------------------------------------");
            ps = con.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"ACTION\",\"TIME\",\"DATE\") VALUES (?,?,?,CURRENT TIME,CURRENT DATE)");
            ps.setString(1, UUID.randomUUID().toString().substring(0,8));
            ps.setString(2, loggedInUser);
            ps.setString(3, "Added monthly dues to all existing balances.");
            ps.executeUpdate();
            if(!response.isCommitted())
                response.sendRedirect("records.jsp");
        } catch(SQLException sqle){
            logger.error("SQLException IN error occured - " + sqle.getMessage());
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
                logger.error("SQLException OUT error occured - " + sqle.getMessage());
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
