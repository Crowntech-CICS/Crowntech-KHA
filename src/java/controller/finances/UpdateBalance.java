package controller.finances;

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

public class UpdateBalance extends HttpServlet {
    private static final Log logger = LogFactory.getLog(UpdateBalance.class);
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
        logger.info("Updating all lot balances...");        
        try{
            //Get Connection
            con = ConnectionPoolManager.getDataSource().getConnection();
            //Get properties
            ps = con.prepareStatement("select propertyid from userlot");
            rs = ps.executeQuery();
            while(rs.next()){
                //update balance of each property
                ps = con.prepareStatement("update userlot set balance = (select coalesce(sum(balance),0) from monthlybalance where propertyid = ?) where propertyid = ?");
                ps.setString(1, rs.getString("propertyid"));
                ps.setString(2, rs.getString("propertyid"));
                ps.executeUpdate();
            }
            response.sendRedirect(request.getContextPath() + "/staff/records.jsp");
            
        } catch(SQLException sqle){
            logger.info("SQLException error occurred in update - " + sqle.getMessage());
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
                logger.info("SQLException error occurred in closing - " + sqle.getMessage());
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
