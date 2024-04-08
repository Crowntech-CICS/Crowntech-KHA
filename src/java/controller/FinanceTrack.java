package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class AddRecordServlet extends HttpServlet {
    protected static Connection dbConnection;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
	
	protected static int hopaid;
	protected static int hototal;
	protected static int mapaid;
	protected static int matotal;
	
	protected static int membershipfee; // to be assigned and used to multiply with mapaid and matotal 
	
	
	
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
        
        
        
        if (dbConnection != null) {
            try {
                String dbQuery = "SELECT PAID FROM HOMEOWNER";
                ps = dbConnection.prepareStatement(dbQuery);
                rs = ps.executeUpdate();
				
				while (rs.next()) {
					
					hototal++;
					
					if ( rs.toString() == "TRUE")
						hopaid++;
					
				}
				
				dbQuery = "SELECT PAID FROM KHAMEMBERSHIP";
                ps = dbConnection.prepareStatement(dbQuery);
                rs = ps.executeUpdate();
                
				while (rs.next()) {
					
					matotal++;
					
					if ( rs.toString() == "TRUE")
						mapaid++;
					
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
        else {
            response.sendRedirect("finances.jsp");
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
