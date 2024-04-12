package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static org.apache.commons.lang3.RandomStringUtils.*;


public class CreateAcc extends HttpServlet {
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    
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
    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        
        try {
            Class.forName(getServletContext().getInitParameter("jdbcClassName")); //load driver
            String username = getServletContext().getInitParameter("dbUserName"), //get connection parameters from web.xml
                   password = getServletContext().getInitParameter("dbPassword"),
                   driverURL = getServletContext().getInitParameter("jdbcDriverURL");
            con = DriverManager.getConnection(driverURL, username, password); //create connection
        }
        catch (ClassNotFoundException | SQLException ex) {
            System.out.println("A connection to the database could not be established.");
            System.out.println("Error: " + ex.getMessage());

        }
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
		
        
        
        
        if (con != null) {
            try {
                String NewUserID = random(8,true,true);
		String NewHomeOwnerID; // if resident = needs homeownerid reference, if homeowner = generate new homeowner, if staff = "staffaydee"
		String NewUsername = (String) request.getParameter("username"); //firstname
                String NewEmail = (String) request.getParameter("email");
                String NewPass = (String) request.getParameter("password"); 
                String NewRole = (String) request.getParameter("userrole"); // Roles are Homeowner, Resident, Staff
                byte[] key = strkey.getBytes();
                String EncryptPass = model.Encryption.encrypt(NewPass, encrpytKey, cipher);
                HttpSession currentUser = request.getSession();
                String dbQuery;
                boolean uniqueID = false;
                
                do{
                dbQuery = "SELECT USERID FROM USERS WHERE USERID = ?";
                ps = con.prepareStatement(dbQuery);
                ps.setString(1, NewUserID);
                rs = ps.executeQuery();
                
                if(rs.next())
                    NewUserID = random(8,true,true);
                else
                    uniqueID = true;
                
                } while (!uniqueID);
                
                uniqueID = false;
                
		if (NewRole == "Homeowner")
		{
		NewHomeOwnerID = random(8,true,true);
                
                do{
                dbQuery = "SELECT HOMEOWNERID FROM HOMEOWNER WHERE HOMEOWNERID = ?";
                ps = con.prepareStatement(dbQuery);
                ps.setString(1, NewUserID);
                rs = ps.executeQuery();
                
                if(rs.next())
                    NewUserID = random(8,true,true);
                else
                    uniqueID = true;
                
                } while (!uniqueID);
                
		}
		else if (NewRole == "Staff")
		{
		NewHomeOwnerID = "staffaydee";
		}
		else
		{
		NewHomeOwnerID = (String) request.getParameter("homeownerid");
		}
                
                dbQuery = "INSERT INTO LOGIN (USERID, EMAIL, PASSWORD) VALUES( ?, ?, ?)";
                ps = con.prepareStatement(dbQuery);
                ps.setString(1, NewUserID);
                ps.setString(2, NewEmail);
                ps.setString(3, EncryptPass);
                int row = ps.executeUpdate(); //Create in Login DB
				
		dbQuery = "INSERT INTO USERS (USERID, HOMEOWNERID, FIRSTNAME, RESIDENTCLASS) VALUES( ?, ?, ?, ?)";
                ps = con.prepareStatement(dbQuery);
                ps.setString(1, NewUserID);
		ps.setString(2, NewHomeOwnerID);
                ps.setString(3, NewUsername);
                ps.setString(4, NewRole); 
                row = ps.executeUpdate(); //Create in USERS DB
                
                if (NewRole == "Homeowner" ){
                dbQuery = "INSERT INTO HOMEOWNER (HOMEOWNERID, FIRSTNAME, EMAIL, PAID, ORNUM) VALUES( ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(dbQuery);
                ps.setString(1, NewUserID);
		ps.setString(2, NewHomeOwnerID);
                ps.setString(3, NewUsername);
                ps.setString(4, "FALSE"); 
                ps.setString(5, NewRole); 
                row = ps.executeUpdate();
                }
                     if (row != 0) {                    
                    
                    
                         response.sendRedirect("createacc.jsp");
                    
                    }
                
                     else {
                         
                         response.sendError(500);
                    
                    }
                }
                
            
            catch (SQLException ex) {
                System.out.println("The specified query could not be performed.");
            }
			 finally {
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
