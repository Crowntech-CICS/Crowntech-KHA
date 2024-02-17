package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.EmailService;

public class PasswordReset extends HttpServlet {
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        //Get user email address
        String userEmail = request.getParameter("email");
        String userId = "";
        String url = "";
        String fullName = "";
        //Establish Connection
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
        
        try {
            ps = con.prepareStatement("SELECT USERID FROM LOGIN WHERE EMAIL = ?");
            ps.setString(1, userEmail);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                userId = rs.getString("USERID").trim();
                String rt = userId + Timestamp.valueOf(LocalDateTime.now().plusHours(1)).getTime();
                System.out.println("RT: " + rt);
                url = "http://localhost:8080/Crowntech-KHA/accounts/password/changepassword.jsp?rt="+ rt;
            } else {
                response.sendRedirect("/Crowntech-KHA/");
            }
            
            ps = con.prepareStatement("SELECT LASTNAME, FIRSTNAME, MIDDLEINITIAL FROM USERS WHERE USERID = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                System.out.println("Found UserId in Users");
                fullName = rs.getString("LASTNAME").trim() + ", " + rs.getString("FIRSTNAME").trim() + " " + rs.getString("MIDDLEINITIAL").trim();;
            } else {
                //response.sendRedirect("/Crowntech-KHA/");
                System.out.println("UserID not Found in Users");
            }
            
        } catch(SQLException sqle){
            System.out.println("[PR] SQLException IN error occured - " + sqle.getMessage());
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
                System.out.println("[PR] SQLException OUT error occured - " + sqle.getMessage());
                response.sendError(500);
            }
        }
        
        //Sender Email and Contents
        String from = "kenetcraft1018@gmail.com";
        String password = "tkcx cgip sxsn zwvy";
        String to = "kennethchristopher.fernando.cics@ust.edu.ph"; //PAGTETESTING NYO LAGAY NYO EMAIL NYO DITO
        //String to = userEmail;
        String subject = "Reset your KHA Account Password";
        String message = "Hello " + fullName + ",\n" + "Click the link below to change your password, this link will expire within 1 hour.\n " + url;
             
        EmailService.send(from, password, to, subject, message);
        response.sendRedirect("/Crowntech-KHA/");
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
