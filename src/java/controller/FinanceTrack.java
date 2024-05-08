package controller;

import java.io.IOException;
import java.sql.*;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.Month;

public class FinanceTrack extends HttpServlet {

    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    protected static ResultSet rs2;
    protected static PreparedStatement ps2;
    protected static ResultSet rs3;
    protected static PreparedStatement ps3;
    protected static int membershipFee; // to be assigned and used to multiply with mapaid and matotal 
    protected static int lotFee;

    protected String strkey;
    protected String encrpytKey = "RECORDKINGSVILLE";//getServletContext().getInitParameter("key");
    protected String cipher = "AES/ECB/PKCS5Padding"; //getServletContext().getInitParameter("cipher");

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
        int hoPaid = 0;
        int hoTotal = 0;
        int maPaid = 0;
        int maTotal = 0;
        int lotPaid = 0;
        int lotTotal = 0;
        HttpSession session = request.getSession();
        try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
            String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
                    password = getServletContext().getInitParameter("dbPassword"),
                    driverURL = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(driverURL, username, password); //create connection
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("A connection to the database could not be established.");
            System.out.println("Error: " + ex.getMessage());

        }
        try {
            //static variables
            long millis = System.currentTimeMillis();
            Date curDate = new Date(millis);
            Date payDate;
            Calendar cal = Calendar.getInstance();
            cal.setTime(curDate);
            double[] totalMA = new double[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            double[] totalMF = new double[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            double[] totalBD = new double[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
            int curMonth = cal.get(Calendar.MONTH);
            int curYear = cal.get(Calendar.YEAR);

            //year selector
            String strSelYear = request.getParameter("year");
            int selYear = cal.get(Calendar.YEAR);
            System.out.println(strSelYear);
            if(strSelYear == null) cal.get(Calendar.YEAR);
            else selYear = Integer.parseInt(strSelYear);
            

            //KHA Membership
            String aFQuery = "select date_part('month', paymentdate), sum(case when paid = true then 5000 else 0 end) "
                             + "from userlot " 
                             + "where date_part('year', paymentdate) = ? "
                             + "group by date_part('month', paymentdate) "
                             + "order by date_part('month', paymentdate)";
            ps = con.prepareStatement(aFQuery);
            ps.setDouble(1, selYear);
            rs = ps.executeQuery();

            while(rs.next()){
                    totalMA[rs.getInt("date_part")-1] += rs.getDouble("sum");
                }

            //Homeowner Fees
            String mFQuery = "select date_part('month', datepaid), sum(balancepaid) "
                             + "from payments "
                             + "where date_part('year', datepaid) = ? "
                             + "group by date_part('month', datepaid) "
                             + "order by date_part('month', datepaid)";
            ps = con.prepareStatement(mFQuery);
            ps.setDouble(1, selYear);
            rs = ps.executeQuery();
            while(rs.next()){
                    totalMF[rs.getInt("date_part")-1] += rs.getDouble("sum");
                }

            //Balance Dues
            String bDQuery;
            System.out.println("test1;");
                bDQuery = "SELECT date_part('month', balancedate), SUM(BALANCE) "
                        + "FROM MONTHLYBALANCE "
                        + "WHERE date_part('year',BALANCEDATE) = ? "
                        + "GROUP BY date_part('month', balancedate)  "
                        + "ORDER BY date_part('month', BALANCEDATE) ";
                ps = con.prepareStatement(bDQuery);
                ps.setDouble(1, selYear);
                System.out.println(ps.toString());
                rs = ps.executeQuery();
                System.out.println("test3;");
                while(rs.next()){
                    totalBD[rs.getInt("date_part")-1] += rs.getDouble("sum");
                }

            
            //SUMMARY
            
            //paid homeowners
            String hoQuery = "select  count(distinct userid) "
                             + "from userlot "
                             + "where paid = true";
            ps = con.prepareStatement(hoQuery);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                hoPaid = rs.getInt("count");
            }
            hoQuery = "select  count(distinct userid) "
                             + "from userlot ";
            ps = con.prepareStatement(hoQuery);
            rs = ps.executeQuery();
            while (rs.next()) {
                hoTotal = rs.getInt("count");
            }
            //membership
            String maQuery = "select  count(propertyid) as total, count(paymentdate) as paid "
                             +"from userlot";
            ps2 = con.prepareStatement(maQuery);
            rs2 = ps2.executeQuery();
            while (rs2.next()) {
                maTotal = rs2.getInt("total");
                maPaid = rs2.getInt("paid");
            }
            //paid lots
            String lotQuery = "select  count(propertyid) as total, count(case when paid = true then 1 end) as paid from userlot";
            ps3 = con.prepareStatement(lotQuery);
            rs3 = ps3.executeQuery();
            while (rs3.next()) {
                lotTotal = rs3.getInt("total");
                lotPaid = rs3.getInt("paid");
            }

            session.setAttribute("homeownerPaid", hoPaid);
            session.setAttribute("homeownerTotal", hoTotal);
            session.setAttribute("membershipPaid", maPaid);
            session.setAttribute("membershipTotal", maTotal);
            session.setAttribute("lotPaid", lotPaid);
            session.setAttribute("lotTotal", lotTotal);
            session.setAttribute("memPaid", totalMA);
            session.setAttribute("monPaid", totalMF);
            session.setAttribute("balPaid", totalBD);
            response.sendRedirect(request.getContextPath() + "/bod/finances.jsp?year=" + selYear);
            //request.getRequestDispatcher("finances.jsp").forward(request,response);              
        } catch (SQLException ex) {
            System.out.println(ex);
            System.out.println("The specified query could not be performed.");
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (rs2 != null) {
                    rs2.close();
                }
                if (ps2 != null) {
                    ps2.close();
                }
                if (rs3 != null) {
                    rs3.close();
                }
                if (ps3 != null) {
                    ps3.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException sqle) {
                System.out.println("SQLException OUT error occured - " + sqle.getMessage());
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
