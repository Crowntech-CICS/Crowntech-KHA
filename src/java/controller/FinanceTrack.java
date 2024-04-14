package controller;

import java.io.IOException;
import java.sql.*;
import java.util.Calendar;
import javax.servlet.ServletConfig;
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
            String hoQuery = "SELECT PAID FROM HOMEOWNER";
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
            int selYear;
            System.out.println(strSelYear);
            if(strSelYear == null) selYear = cal.get(Calendar.YEAR);
            else selYear = Integer.parseInt(strSelYear);
            

            //KHA Membership
            String aFQuery = "SELECT\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 1 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"JAN\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 2 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"FEB\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 3 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"MAR\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 4 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"APR\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 5 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"MAY\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 6 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"JUN\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 7 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"JUL\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 8 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"AUG\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 9 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"SEP\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 10 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"OCT\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 11 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"NOV\",\n"
                    + "    SUM(CASE WHEN PAID = TRUE AND MONTH(PAYMENTDATE) = 12 AND YEAR(PAYMENTDATE) = ? THEN 5000 ELSE 0 END) AS \"DEC\"\n"
                    + "FROM KHAMEMBERSHIP";
            ps = con.prepareStatement(aFQuery);
            for (int i = 1; i < 13; i++) {
                ps.setString(i, String.valueOf(selYear));
            }
            rs = ps.executeQuery();

            while (rs.next()) {
                for (int i = 0; i < 12; i++) {
                    totalMA[i] = rs.getDouble(i + 1);
                }

            }

            //Homeowner Fees
            String mFQuery = "SELECT\n"
                    + "    SUM(CASE WHEN PAID = TRUE THEN 300 ELSE 0 END) AS \"MON\"\n"
                    + "FROM USERLOT";
            ps = con.prepareStatement(mFQuery);
            rs = ps.executeQuery();
            try{
                while (rs.next()) {
                    if (curYear != selYear) {
                    continue;
                }
                totalMF[curMonth] = rs.getDouble(1);
                
                System.out.println("works");
                
                //Adds to FINANCE TABLE if recent month, or updates existing month
                mFQuery = "INSERT INTO FINANCE(FINANCEDATE, MONTHLYFEES, BALANCEDUES) VALUES(?,?,?)";
                
                ps = con.prepareStatement(mFQuery);
                System.out.println("works2");
                ps.setString(1,String.valueOf(Month.of(curMonth + 1)) + String.valueOf(curYear));
                ps.setString(2,String.valueOf(totalMF[curMonth]));
                ps.setString(3,String.valueOf(totalBD[curMonth]));
                ps.executeUpdate();

            }
            }catch(Exception ex){
                System.out.println(ex);
                mFQuery = "UPDATE FINANCE SET MONTHLYFEES=? WHERE FINANCEDATE=?";
                ps = con.prepareStatement(mFQuery);
                ps.setString(1,String.valueOf(totalMF[curMonth]));
                ps.setString(2,String.valueOf(Month.of(curMonth + 1)) + String.valueOf(curYear));
                ps.executeUpdate();
            }

            
            //Pulls old date from previous months of the selected year
            for (int i = 0; i < 12; i++) {
                if (i == curMonth && curYear == selYear) {
                    continue;
                }
                mFQuery = "SELECT\n"
                        + "    * FROM FINANCE WHERE FINANCEDATE = ?";
                ps = con.prepareStatement(mFQuery);
                String test = String.valueOf(Month.of(i + 1)) + selYear;
                ps.setString(1, test);
                rs = ps.executeQuery();
                while (rs.next()) {
                    totalMF[i] = rs.getDouble(2);
                }

                System.out.println(totalMF[i]);
            }

            //Balance Dues
            String bDQuery = "SELECT\n"
                    + "    SUM(CASE WHEN PAID = FALSE THEN 300 ELSE 0 END) AS \"MON\"\n"
                    + "FROM USERLOT";
            ps = con.prepareStatement(bDQuery);
            rs = ps.executeQuery();

           try{
                while (rs.next()) {
                    if (curYear != selYear) {
                    continue;
                }
                totalBD[curMonth] = rs.getDouble(1);
                System.out.println("works");
                
                mFQuery = "INSERT INTO FINANCE(FINANCEDATE, MONTHLYFEES, BALANCEDUES) VALUES(?,?,?)";
                
                ps = con.prepareStatement(mFQuery);
                System.out.println("works2");
                ps.setString(1,String.valueOf(Month.of(curMonth + 1)) + String.valueOf(curYear));
                ps.setString(2,String.valueOf(totalMF[curMonth]));
                ps.setString(3,String.valueOf(totalBD[curMonth]));
                ps.executeUpdate();

            }
            }catch(Exception ex){
                System.out.println(ex);
                mFQuery = "UPDATE FINANCE SET BALANCEDUES=? WHERE FINANCEDATE=?";
                ps = con.prepareStatement(mFQuery);
                ps.setString(1,String.valueOf(totalBD[curMonth]));
                ps.setString(2,String.valueOf(Month.of(curMonth + 1)) + String.valueOf(curYear));
                ps.executeUpdate();
            }

            

            for (int i = 0; i < 12; i++) {
                if (i == curMonth && curYear == selYear) {
                    continue;
                }
                mFQuery = "SELECT\n"
                        + "    * FROM FINANCE WHERE FINANCEDATE = ?";
                ps = con.prepareStatement(mFQuery);
                String test = String.valueOf(Month.of(i + 1)) + selYear;
                ps.setString(1, test);
                rs = ps.executeQuery();
                while (rs.next()) {
                    totalBD[i] = rs.getDouble(3);
                }

                System.out.println(totalMF[i]);
            }

            
            //SUMMARY
            ps = con.prepareStatement(hoQuery);
            rs = ps.executeQuery();
            while (rs.next()) {
                boolean paid = rs.getBoolean("PAID");
                hoTotal++;
                if (paid) {
                    hoPaid++;
                }
            }

            String maQuery = "SELECT PAID FROM KHAMEMBERSHIP";
            ps2 = con.prepareStatement(maQuery);
            rs2 = ps2.executeQuery();
            while (rs2.next()) {
                boolean paid = rs2.getBoolean("PAID");
                maTotal++;
                if (paid) {
                    maPaid++;
                }
            }
            String lotQuery = "SELECT PAID FROM USERLOT";
            ps3 = con.prepareStatement(lotQuery);
            rs3 = ps3.executeQuery();
            while (rs3.next()) {
                boolean paid = rs3.getBoolean("PAID");
                lotTotal++;
                if (paid) {
                    lotPaid++;
                }
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
            response.sendRedirect("finances.jsp?year=" + selYear);
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
