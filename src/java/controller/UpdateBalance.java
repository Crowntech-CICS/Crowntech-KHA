package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DBLogger;
import model.connections.ConnectionPoolManager;

public class UpdateBalance extends HttpServlet {
    
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
        System.out.println("--[UPD BAL]-------------------------------------------------------------");
        String userId = "";
        String lastname = request.getParameter("HO_LN_B").toLowerCase().trim();
        String firstname = request.getParameter("HO_FN_B").toLowerCase().trim();
        String middleinitial = request.getParameter("HO_MI_B").toLowerCase().trim();
        double currentBalance = 0.0;
        double payment = Double.parseDouble(request.getParameter("PAYMENT"));
        double newBalance = currentBalance;
        boolean paid = false;
        
        try{
            //Get Connection
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("SELECT USERID,BALANCE FROM HOMEOWNER WHERE LOWER(LASTNAME) = ? AND LOWER(FIRSTNAME) = ? AND LOWER(MIDDLEINITIAL) = ?");
            ps.setString(1, lastname);
            ps.setString(2, firstname);
            ps.setString(3, middleinitial);
            rs = ps.executeQuery();
            if(rs.next()){
                userId = rs.getString("USERID").trim();
                ps = con.prepareStatement("SELECT BALANCE FROM USERLOT WHERE USERID = ?");
                ps.setString(1, userId);
                rs = ps.executeQuery();
                rs.next();
                currentBalance = rs.getDouble("BALANCE");
                System.out.println("BALANCE: " + currentBalance);
                newBalance = currentBalance - payment;
                if(newBalance < 1){ paid = true; } else { paid = false;}
                ps = con.prepareStatement("UPDATE USERLOT SET BALANCE = ?, PAID = ?  WHERE USERID = ?");
                ps.setDouble(1, newBalance);
                ps.setBoolean(2, paid);
                ps.setString(3, userId);
                ps.executeUpdate();
                ps = con.prepareStatement("UPDATE HOMEOWNER SET PAID = ?  WHERE USERID = ?");
                ps.setBoolean(1, paid);
                ps.setString(2, userId);
                ps.executeUpdate();
                System.out.println("PAYMENT SUCCESS. NEW BALANCE: " + newBalance);
                //LOG ACTION
                new DBLogger().log((String) request.getSession().getAttribute("currId"), "Updated payment of " + payment + " by " + lastname + "," + firstname);
                //Redirect
                if(!response.isCommitted())
                    response.sendRedirect("records.jsp");
            } else {
                System.out.println("NO BALANCE FOUND.");
                //LOG ACTION
                new DBLogger().log((String) request.getSession().getAttribute("currId"), "Failed to update payment of " + payment + " by " + lastname + "," + firstname);
                //Redirect
                if(!response.isCommitted())
                    response.sendRedirect("records.jsp");
            }

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
