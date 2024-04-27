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
import javax.servlet.http.HttpSession;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Login extends HttpServlet {
    private static final Log logger = LogFactory.getLog(Login.class);
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    protected int allowedTries = 3;
    protected int ctr;
       
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
        logger.info("Login Servlet processRequest.");
        String encrpytKey = getServletContext().getInitParameter("key");/*"RECORDKINGSVILLE";*/
        String cipher = getServletContext().getInitParameter("cipher");/*"AES/ECB/PKCS5Padding";*/
        HttpSession session = request.getSession();
        boolean logState = session.getAttribute("username") != null;
        if(logState) {
            response.sendRedirect("index.jsp");
        }  
               
        boolean found = false;
        ctr = (int) session.getAttribute("tries");
        String userEmail = request.getParameter("email").toLowerCase();
        String userPass = model.Encryption.encrypt(request.getParameter("password"), encrpytKey, cipher);
//        System.out.println("EMAIL: " + userEmail);
//        System.out.println("PASSW: " + userPass);
        try{
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("SELECT * FROM USERS WHERE LOWER(EMAIL) = ? AND PASSWORD = ?");
            ps.setString(1, userEmail);
            ps.setString(2, userPass);
            rs = ps.executeQuery();
            
            if(rs.next()){ //If user is in database
                System.out.println("FOUND IN DB");
                //Get data from ResultSet
                String emailDB = rs.getString("EMAIL").trim().toLowerCase();
                String passwordDB = rs.getString("PASSWORD").trim();
                String userID = rs.getString("USERID").trim();
                String levelDB = rs.getString("RESIDENTCLASS").trim().toLowerCase();
                String userName = rs.getString("FIRSTNAME").trim();
                
                logger.info(String.format("Email: %s - Level: %s", emailDB, levelDB));//print the contents resultset row
                
                if(userEmail.equalsIgnoreCase(emailDB) && userPass.equals(passwordDB)){
                    session.setAttribute("username", userName);
                    session.setAttribute("level", levelDB);
                    session.setAttribute("currID", userID);
                    System.out.println("Current userID: " + userID);
                    System.out.println("Found user in the database");
                    found = true;                    
                }
            } else { //Not in database
                logger.error("NO RECORD IN DB");
            }
            
            if(found){ //verifies if the user is in the database and redirect them to the homepage
                if(!con.isClosed())
                    con.close();
                ctr = 0;
                session.removeAttribute("tries");
                response.sendRedirect("index.jsp");
            }
            else if(ctr < allowedTries - 1){ //shows a message that the email or password is wrong (total of 3 tries)
                ctr++;
                session.setAttribute("tries", ctr);
                request.setAttribute("succ", "true"); //NOTE: FOR VERIFICATION FOR POPUP IN THE LOGIN PAGE
                response.sendRedirect("login.jsp");
            }
            else{ //throw an error message which will redirect the user to error 440 page
                ctr = 0;
                session.removeAttribute("tries");
                response.sendRedirect("./accounts/password/reset.jsp");
            }
        } catch(SQLException sqle){
            logger.error("SQLException error occured in try - " + sqle.getMessage());
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
                logger.error("SQLException error occured in finally - " + sqle.getMessage());
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
