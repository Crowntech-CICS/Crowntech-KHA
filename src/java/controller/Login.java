package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login extends HttpServlet {

    public static Connection con;
    public static ResultSet rs;
    protected int ctr = 1;
    protected String encrpytKey = "SECRETKEY";//getServletContext().getInitParameter("key");
    protected String cipher = "AES/ECB/PKCS5Padding"; //getServletContext().getInitParameter("cipher");
    
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
            String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
                   password = getServletContext().getInitParameter("dbPassword"),
                   driverURL = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(driverURL, username, password); //create connection object
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - " + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - " + nfe.getMessage());
        }
    }
    
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
        boolean temp = false;
        String userEmail = request.getParameter("email"),
               userPass = model.Encryption.encrypt(request.getParameter("password"), encrpytKey, cipher);

        try{
//            Statement stmt = con.createStatement();
//            rs = stmt.executeQuery("SELECT USERNAME, EMAIL, PASSWORD FROM USERS");
            PreparedStatement ps = con.prepareStatement("SELECT EMAIL, PASSWORD FROM USERS WHERE EMAIL = ? AND PASSWORD = ?");
            ps.setString(1, userEmail);
            ps.setString(2, userPass);
            rs = ps.executeQuery();
            
            while(rs.next()){
                String emailDB = rs.getString("EMAIL").trim(),
                       passwordDB = rs.getString("PASSWORD").trim();
                
                System.out.println(String.format("Email: %s || Password: %s", emailDB, passwordDB)); //print the contents resultset row
                
                if(userEmail.equals(emailDB) && userPass.equals(passwordDB)){
                    session.setAttribute("username", rs.getString("USERNAME"));
                    System.out.println("Found user in the database");
                    temp = true;
                    break;
                }
            }
            
            if(temp){ //verifies if the user is in the database and redirect them to the homepage
                ctr = 0;
                response.sendRedirect("index.jsp");
            }
            else if(ctr < 3){ //shows a message that the email or password is wrong (total of 3 tries)
                ctr++;
                request.setAttribute("succ", "true"); //NOTE: FOR VERIFICATION FOR POPUP IN THE LOGIN PAGE
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            else{ //throw an error message which will redirect the user to error 440 page
                ctr = 0;
                response.sendError(440);
            }
        } catch(SQLException e){
            e.printStackTrace();
            response.sendError(500);
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
