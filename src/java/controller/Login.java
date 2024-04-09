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
import javax.servlet.http.HttpSession;

public class Login extends HttpServlet {

    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    protected int allowedTries = 3;
    protected int ctr;
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
        
        HttpSession session = request.getSession();
        boolean logState = session.getAttribute("username") != null;
        if(logState) {
            response.sendRedirect("admin/index.jsp");
        }
        
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
                
               
        boolean found = false;
        ctr = (int) session.getAttribute("tries");
        String userEmail = request.getParameter("email"),
               userPass = model.Encryption.encrypt(request.getParameter("password"), encrpytKey, cipher),
               userID = request.getParameter("USERID"),
               userName;

        try{
            ps = con.prepareStatement("SELECT EMAIL, PASSWORD, USERID FROM LOGIN WHERE EMAIL = ? AND PASSWORD = ?");
            ps.setString(1, userEmail);
            ps.setString(2, userPass);
            rs = ps.executeQuery();
            
            while(rs.next()){
                String emailDB = rs.getString("EMAIL").trim(),
                       passwordDB = rs.getString("PASSWORD").trim();
                //Get user access level in USERS table (RESIDENTCLASS)
                ps = con.prepareStatement("SELECT RESIDENTCLASS, FIRSTNAME FROM USERS WHERE USERID = ?");
                userID = rs.getString("USERID").trim();
                ps.setString(1, rs.getString("USERID").trim());
                rs = ps.executeQuery();
                rs.next();
                String levelDB = rs.getString("RESIDENTCLASS").trim();
                userName = rs.getString("FIRSTNAME").trim();
                
                System.out.println(String.format("Email: %s || Password: %s || Level: %s", emailDB, passwordDB, levelDB));//print the contents resultset row
                
                if(userEmail.equals(emailDB) && userPass.equals(passwordDB)){
                    session.setAttribute("username", userName);
                    session.setAttribute("level", levelDB.toLowerCase());
                    session.setAttribute("currID", userID);
                    System.out.println("Current userID: " + userID);
                    System.out.println("Found user in the database");
                    found = true;
                    break;
                }
            }
            
            if(found){ //verifies if the user is in the database and redirect them to the homepage
                if(!con.isClosed())
                    con.close();
                ctr = 0;
                session.removeAttribute("tries");
                response.sendRedirect("admin/index.jsp");
            }
            else if(ctr < allowedTries - 1){ //shows a message that the email or password is wrong (total of 3 tries)
                ctr++;
                session.setAttribute("tries", ctr);
                request.setAttribute("succ", "true"); //NOTE: FOR VERIFICATION FOR POPUP IN THE LOGIN PAGE
                response.sendRedirect("login/login.jsp");
                //request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            else{ //throw an error message which will redirect the user to error 440 page
                ctr = 0;
                session.removeAttribute("tries");
                response.sendError(440);
                //response.sendRedirect("login.jsp"); //for testing purposes to be removed later
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
