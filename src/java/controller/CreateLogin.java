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

public class CreateLogin extends HttpServlet {

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
        String email = request.getParameter("EMAIL"),
               userid = request.getParameter("USERID"),
               userPassword = model.Encryption.encrypt(request.getParameter("newPassword"), getServletContext().getInitParameter("key"), getServletContext().getInitParameter("cipher"));
        System.out.println("--[CREATE LOGIN]-------------------------");
        System.out.println("EM: " + email);
        System.out.println("UID: " + userid);
        System.out.println("PWD: " + userPassword);
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
        //Insert into Database when Found
        try {
            ps = con.prepareStatement("INSERT INTO LOGIN(USERID,EMAIL,PASSWORD) VALUES (?,?,?)");
            ps.setString(1, userid);
            ps.setString(2, email);
            ps.setString(3, userPassword);

            String insertStatus = (ps.executeUpdate() > 0)? "Success" : "Failed";
            System.out.println("Login insert status: " + insertStatus);
            if(insertStatus.equals("Success")){
                response.sendRedirect("./signup.jsp?suc=true");
            }
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured in INSERT - " + sqle.getMessage());
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
            System.out.println("SQLException error occured in Closing - " + sqle.getMessage());
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
