package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddMonthlyDues extends HttpServlet {

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
        double monthlyDue = 300.00;
        double balance = 0.0;
        boolean paid = false;
        //Connect to DB
        try {
                Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
                String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
                       password = getServletContext().getInitParameter("dbPassword"),
                       driverURL = getServletContext().getInitParameter("jdbcDriverURL");
                con = DriverManager.getConnection(driverURL, username, password); //create connection
            } catch (SQLException sqle) {
                System.out.println("SQLException error occured - " + sqle.getMessage());
            } catch (ClassNotFoundException nfe) {
                System.out.println("ClassNotFoundException error occured - " + nfe.getMessage());
        }
        
        try{
            ps = con.prepareStatement("SELECT HOMEOWNERID,BALANCE FROM HOMEOWNER");
            rs = ps.executeQuery();
            while(rs.next()){
                System.out.println("HID: " + rs.getString("HOMEOWNERID"));
                System.out.println("OLDBAL: " + rs.getDouble("BALANCE"));
                balance = rs.getDouble("BALANCE") + monthlyDue;
                System.out.println("NEWBAL: " + balance);
                ps = con.prepareStatement("UPDATE HOMEOWNER SET BALANCE = ?, PAID = ? WHERE HOMEOWNERID = ?");
                ps.setDouble(1, balance);
                ps.setBoolean(2, paid);
                ps.setString(3, rs.getString("HOMEOWNERID"));
                ps.executeUpdate();
            }
            System.out.println("SUCCESSFULLY ADDED MONTHLY DUES TO ALL HOMEOWNERS.");
            if(!response.isCommitted())
                response.sendRedirect("records.jsp");
        } catch(SQLException sqle){
            System.out.println("SQLException IN error occured - " + sqle.getMessage());
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
