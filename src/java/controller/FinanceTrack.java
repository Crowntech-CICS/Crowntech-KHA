package controller;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class FinanceTrack extends HttpServlet {
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
	
	protected static int hoPaid;
	protected static int hoTotal;
	protected static int maPaid;
	protected static int maTotal;
	protected static int lotPaid;
	protected static int lotTotal;
	
	protected static int membershipFee; // to be assigned and used to multiply with mapaid and matotal 
	protected static int lotFee; 
	
	
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
                String dbQuery = "SELECT PAID FROM HOMEOWNER";
                ps = con.prepareStatement(dbQuery);
                rs = ps.executeQuery();
				
				while (rs.next()) {
					
					hoTotal++;
					
					if ( rs.toString() == "TRUE")
						hoPaid++;
					
				}
				
				dbQuery = "SELECT PAID FROM KHAMEMBERSHIP";
                ps = con.prepareStatement(dbQuery);
                rs = ps.executeQuery();
                
				while (rs.next()) {
					
					maTotal++;
					
					if ( rs.toString() == "TRUE")
						maPaid++;
					
				}
				dbQuery = "SELECT PAID FROM USERLOT";
                ps = con.prepareStatement(dbQuery);
                rs = ps.executeQuery();
				while (rs.next()) {
					
					lotTotal++;
					
					if ( rs.toString() == "TRUE")
						lotPaid++;
				}
                
                                
                                request.setAttribute("homeownerPaid",hoPaid);
                                request.setAttribute("homeownerTotal",hoTotal);
                                request.setAttribute("membershipPaid",maPaid);
                                request.setAttribute("membershipPaid",maTotal);
                                request.setAttribute("lotPaid",lotPaid);
                                request.setAttribute("lotTotal",lotTotal);
                                request.getRequestDispatcher("finances.jsp").forward(request,response);
                                
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
