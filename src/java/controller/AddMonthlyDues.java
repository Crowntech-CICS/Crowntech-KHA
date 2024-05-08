package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DBLogger;
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
        String root = request.getContextPath();
        String loggedInUser = (String) session.getAttribute("currID");
        double monthlyDue = 300.00;
        logger.info("Add Monthly dues...");
        
        try{
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("select propertyid from userlot");
            rs = ps.executeQuery();
            //Set current month
            Date month = Date.valueOf(LocalDate.now().withDayOfMonth(1));
            logger.info(month);
            while(rs.next()){
                logger.info(rs.getString("propertyid"));
                ps = con.prepareStatement("select addmonthlydues(?,?,?)");
                ps.setString(1, rs.getString("propertyid"));
                ps.setDate(2, month);
                ps.setDouble(3, monthlyDue);
                ps.executeQuery();
            }
            
            logger.info("SUCCESSFULLY ADDED MONTHLY DUES TO ALL HOMEOWNERS.");
            logger.info("Logged In user: " + loggedInUser);
            logger.info("------------------------------------------------------------------------");
            //LOG ACTION
            new DBLogger().log(loggedInUser, "Added monthly dues to all existing balances.");
            //Redirect
            if(!response.isCommitted())
                response.sendRedirect(root + "/UpdateBalance");
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
