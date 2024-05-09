package controller.finances;

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
import model.DBLogger;
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
        logger.info("Paying balance of property...");
        double monthly_dues = 300.0;
        String propId = request.getParameter("PROP_ID");
        double payment = Double.parseDouble(request.getParameter("PAYMENT"));
        
        try{
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("select count(*) as count from monthlybalance where propertyid = ? and balance > 0");
            ps.setString(1, propId);
            rs = ps.executeQuery();
            if(rs.next()){
                //Check how many months
                logger.info("Counting months...");
                int count = rs.getInt("count");
                int months = (int) Math.ceil((payment / monthly_dues));
                months += Math.floor(months / 12);
                payment += (monthly_dues * Math.floor(months / 12));
                Date monthPaid = Date.valueOf(LocalDate.now()); 
                ps = con.prepareStatement("select * from monthlybalance where propertyid = ? and balance > 0  order by balancedate asc");
                ps.setString(1, propId);
                rs = ps.executeQuery();
                logger.info("Months to be paid:" + months);
                //Update monthly balance
                while(count > 0) {
                    rs.next();
                    monthPaid = rs.getDate("balancedate");
                    double currentBalance = rs.getDouble("balance");
                    double deduction = (payment >= currentBalance) ? currentBalance : payment;
                    double newBalance = currentBalance - deduction;
                    ps = con.prepareStatement("update monthlybalance set balance = ?  where propertyid = ? and balancedate = ?");
                    ps.setDouble(1, newBalance);
                    ps.setString(2, propId);
                    ps.setDate(3, monthPaid);
                    ps.executeUpdate();
                    months--;
                    count--;
                    payment -= deduction;
                    logger.info("PAYMENT SUCCESS. " + monthPaid.toString() + " NEW BALANCE: " + newBalance);
                    logger.info("Months left:" + months);                    
                }
                if(months > 0) {
                    logger.info("Excess payment: " + payment);
                    logger.info("Excess months: " + months);
                    for (int i = months; i > 0; ) {
                        double deduction = (payment >= monthly_dues) ? monthly_dues : payment;
                        double newBalance = monthly_dues - deduction;
                        monthPaid = Date.valueOf(monthPaid.toLocalDate().plusMonths(1));
                        logger.info("Checking " + monthPaid);
                        ps = con.prepareStatement("select * from monthlybalance where balancedate = ? and propertyid = ?");
                        ps.setDate(1, monthPaid);
                        ps.setString(2, propId);
                        rs = ps.executeQuery();
                        if(rs.next()){
                            logger.info("Found payment.");
                            double monthBal = rs.getDouble("balance");
                            if(monthBal == 0)
                                continue;
                            deduction = (payment >= monthBal) ? monthBal : payment;
                            ps = con.prepareStatement("update monthlybalance set balance = ?  where propertyid = ? and balancedate = ?");
                            ps.setDouble(1, newBalance);
                            ps.setString(2, propId);
                            ps.setDate(3, monthPaid);
                            logger.info("Paying " + monthPaid + " Amt: " + deduction);
                            logger.info("Remaining payment: " + payment);
                            ps.executeUpdate();
                            months--;
                            count--;
                            payment -= deduction;
                            i--;
                            continue;
                        }                        
                        logger.info("New Month, Paying " + monthPaid + " Amt: " + deduction);
                        logger.info("Remaining payment: " + payment);
                        ps = con.prepareStatement("insert into monthlybalance (propertyid,balancedate,balance) values (?,?,?)");
                        ps.setString(1, propId);
                        ps.setDate(2, monthPaid);
                        ps.setDouble(3, newBalance);
                        ps.executeUpdate();
                        payment -= deduction;
                        months--;
                        i--;
                    }
                }               
                //update balance property
                ps = con.prepareStatement("update userlot set balance = (select coalesce(sum(balance),0) from monthlybalance where propertyid = ?) where propertyid = ?");
                ps.setString(1, propId);
                ps.setString(2, propId);
                ps.executeUpdate();
                
                //LOG ACTION
                new DBLogger().log((String) request.getSession().getAttribute("currID"), "Updated payment of " + request.getParameter("PAYMENT") + " propertyId " + propId);
                //Redirect
                if(!response.isCommitted())
                    response.sendRedirect(request.getContextPath() + "/staff/payLot.jsp?propID=" + propId);
            } else {
                logger.error("NO BALANCE FOUND.");
                //LOG ACTION
                new DBLogger().log((String) request.getSession().getAttribute("currID"), "Failed to update payment of " + request.getParameter("PAYMENT") + " propertyId  " + propId);
                //Redirect
                if(!response.isCommitted())
                    response.sendRedirect(request.getContextPath() + "/staff/payLot.jsp?propID=" + propId);
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
