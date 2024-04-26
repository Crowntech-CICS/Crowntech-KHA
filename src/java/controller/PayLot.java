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
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class PayLot extends HttpServlet {
    private static final Log logger = LogFactory.getLog(PayLot.class);
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
        logger.info("--[PAY LOT]-------------------------------------------------------------");
        String propId = request.getParameter("PROP_ID");
        String userId = "";
        String lastname = "";
        String firstname = "";
        String middleinitial = "";
        String fullName = lastname + "," + firstname + " " + middleinitial;
        double currentBalance = 0.0;
        double payment = Double.parseDouble(request.getParameter("PAYMENT"));
        double newBalance = 0.0;
        boolean paid = false;
        
        try{
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("SELECT H.HOMEOWNERID,L.PROPERTYID,H.LASTNAME,H.FIRSTNAME,H.MIDDLEINITIAL,L.BALANCE, (L.HOUSENO||' '||L.STREETNAME) AS ADDRESS FROM USERLOT L LEFT JOIN HOMEOWNER H ON H.HOMEOWNERID = L.HOMEOWNERID WHERE L.PROPERTYID = ?");
            ps.setString(1, propId);
            rs = ps.executeQuery();
            if(rs.next()){
                userId = rs.getString("HOMEOWNERID").trim();
                currentBalance = rs.getDouble("BALANCE");
                logger.info("BALANCE: " + currentBalance);
                fullName = rs.getString("LASTNAME").trim() + "," + rs.getString("FIRSTNAME").trim() + " " + rs.getString("MIDDLEINITIAL").trim();
                newBalance = currentBalance - payment;
                paid = newBalance < 1;
                ps = con.prepareStatement("UPDATE USERLOT SET BALANCE = ?, PAID = ?  WHERE PROPERTYID = ?");
                ps.setDouble(1, newBalance);
                ps.setBoolean(2, paid);
                ps.setString(3, propId);
                ps.executeUpdate();
                ps = con.prepareStatement("UPDATE HOMEOWNER SET PAID = ?  WHERE HOMEOWNERID = ?");
                ps.setBoolean(1, paid);
                ps.setString(2, userId);
                ps.executeUpdate();
                logger.info("PAYMENT SUCCESS. NEW BALANCE: " + newBalance);
                ps = con.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"ACTION\",\"TIME\",\"DATE\") VALUES (?,?,?,CURRENT TIME,CURRENT DATE)");
                ps.setString(1, UUID.randomUUID().toString().substring(0,8));
                ps.setString(2, (String) request.getSession().getAttribute("currID"));
                ps.setString(3, "Updated payment of " + payment + " by " + fullName);
                ps.executeUpdate();
                if(!response.isCommitted())
                    response.sendRedirect("records.jsp");
            } else {
                logger.error("NO BALANCE FOUND.");
                ps = con.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"ACTION\",\"TIME\",\"DATE\") VALUES (?,?,?,CURRENT TIME,CURRENT DATE)");
                ps.setString(1, UUID.randomUUID().toString().substring(0,8));
                ps.setString(2, (String) request.getSession().getAttribute("currID"));
                ps.setString(3, "Failed to update payment of " + payment + " by " + fullName);
                ps.executeUpdate();
                if(!response.isCommitted())
                    response.sendRedirect("records.jsp");
            }

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
