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
import java.text.SimpleDateFormat;  
import java.util.Date;  


public class CreateAcc extends HttpServlet {
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
    
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String encrpytKey = getServletContext().getInitParameter("key");
        String cipher = getServletContext().getInitParameter("cipher");
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
                int row;
                String NewUserID = random(8,true,true);
		String NewHomeOwnerID = ""; // if resident = needs homeownerid reference, if homeowner = generate new homeowner, if staff = "staffaydee"
                String NewORNUM = (String) request.getParameter("ornum");;
		String NewFirstname = (String) request.getParameter("firstname"); //firstname
		String NewLastname = (String) request.getParameter("lastname"); //Lastname
                String NewDateoccupied = (String) request.getParameter("dateoccupied");
                String NewEmail = (String) request.getParameter("email");
                String NewPass = (String) request.getParameter("password");
                String NewRole = (String) request.getParameter("userrole"); // Roles are Homeowner, Resident, Staff
                String EncryptPass = model.Encryption.encrypt(NewPass, encrpytKey, cipher);
                HttpSession session = request.getSession();
                String dbQuery;
                boolean uniqueUserID = false;
                boolean uniqueHomeownerID = false;
            try {
                
                //Avoid duplicate userID
                dbQuery = "SELECT USERID FROM USERS WHERE USERID = ?";
                ps = con.prepareStatement(dbQuery);
                do{
                ps.setString(1, NewUserID);
                rs = ps.executeQuery();
                
                if(rs.next())
                    NewUserID = random(8,true,true);
                else
                    uniqueUserID = true;
                
                } while (!uniqueUserID);
                
                
		if (NewRole.equals("Homeowner"))
		{
		NewHomeOwnerID = random(8,true,true);
                
                //Avoiding Duplicate HomeownerID as homeOwner
                dbQuery = "SELECT HOMEOWNERID FROM HOMEOWNER WHERE HOMEOWNERID = ?";
                ps = con.prepareStatement(dbQuery);
                do{
                ps.setString(1, NewHomeOwnerID);
                rs = ps.executeQuery();
                
                if(rs.next())
                    NewHomeOwnerID = random(8,true,true);
                else
                    uniqueHomeownerID = true;
                
                } while (!uniqueHomeownerID);
                
                }
		else if (NewRole.equals("Staff"))
		{
		NewHomeOwnerID = "staffaydee";
		}
		else
		{
                dbQuery = "SELECT HOMEOWNERID FROM HOMEOWNER WHERE ORNUM = ?";
                ps = con.prepareStatement(dbQuery);
                ps.setString(1, NewORNUM);
                rs = ps.executeQuery();
                if(rs.next())
                {
		NewHomeOwnerID = rs.getString("HOMEOWNERID").trim() ;
                }
		}
                
                
                if (NewRole.equals("Homeowner")){
                String insHOQuery = "INSERT INTO HOMEOWNER (HOMEOWNERID, LASTNAME, FIRSTNAME, EMAIL, HOUSENO, STREETNAME, CITY, PROVINCE, PAID, BALANCE, ORNUM) VALUES( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(insHOQuery);
                ps.setString(1, NewHomeOwnerID);
		ps.setString(2, NewLastname);
		ps.setString(3, NewFirstname);
                ps.setString(4, NewEmail);
                ps.setString(5, "EMPTY");
                ps.setString(6, "EMPTY");
                ps.setString(7, "EMPTY");
                ps.setString(8, "EMPTY");
                ps.setBoolean(9, false); 
                ps.setDouble(10, 0.0); 
                ps.setString(11, NewORNUM); 
                row = ps.executeUpdate();
                if (row != 0) {                    
                        System.out.println("Homeowner Created");
                    }
                     else {
                         response.sendError(500);
                    }
                }
				
                
                System.out.println(String.format("UserID: %s || Date Occupied: %s || Role: %s", NewUserID, NewDateoccupied, NewRole));
                try{
                java.util.Date myDate = new SimpleDateFormat("yyyy-MM-dd").parse(NewDateoccupied);
                java.sql.Date sqlDate = new java.sql.Date(myDate.getTime());
                
		String insUserQuery = "INSERT INTO USERS (USERID, HOMEOWNERID, LASTNAME, FIRSTNAME, RESIDENTCLASS, HOUSENO, STREETNAME, DATEOCCUPIED) VALUES( ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(insUserQuery);
                ps.setString(1, NewUserID);
		ps.setString(2, NewHomeOwnerID);
                ps.setString(3, NewLastname);
                ps.setString(4, NewFirstname);
                ps.setString(5, NewRole); 
                ps.setString(6, "EMPTY"); 
                ps.setString(7, "EMPTY"); 
                ps.setDate(8, sqlDate);
                row = ps.executeUpdate(); //Create in USERS DB
                    if (row != 0) {                    
                        System.out.println("User Created");
                        
                    }
                     else {
                         response.sendError(500);
                    }
                }
                catch (Exception e){
                System.out.println("Failed to Parse");
                }
                
                System.out.println(String.format("UserID: %s || Password: %s || Role: %s", NewUserID, EncryptPass, NewRole));
                
                String insLogQuery = "INSERT INTO LOGIN (USERID, EMAIL, PASSWORD) VALUES( ?, ?, ?)";
                ps = con.prepareStatement(insLogQuery);
                ps.setString(1, NewUserID);
                ps.setString(2, NewEmail);
                ps.setString(3, EncryptPass);
                row = ps.executeUpdate(); //Create in Login DB
                
                     if (row != 0) {
                         System.out.println("Login Created");
                         
                         session.setAttribute("message","User Created!!");
                         request.getRequestDispatcher("createacc.jsp").forward(request,response);       
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
