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
    protected static ResultSet rs2;
    protected static PreparedStatement ps2;
    protected static ResultSet rs3;
    protected static PreparedStatement ps3;
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
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         int hoPaid=0;
	 int hoTotal=0;
	 int maPaid=0;
	 int maTotal=0;
	 int lotPaid=0;
	 int lotTotal=0;
        HttpSession session = request.getSession();
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
            try {
                String hoQuery = "SELECT PAID FROM HOMEOWNER";
                ps = con.prepareStatement(hoQuery);
                rs = ps.executeQuery();
				while(rs.next()) {
                                        boolean paid = rs.getBoolean("PAID");
                                        hoTotal++;
					if (paid)
						hoPaid++;
				}
		
		String maQuery = "SELECT PAID FROM KHAMEMBERSHIP";
                ps2 = con.prepareStatement(maQuery);
                rs2 = ps2.executeQuery();
				while(rs2.next()) {
					boolean paid = rs2.getBoolean("PAID");
					maTotal++;
					if (paid)
						maPaid++;
				}
		String lotQuery = "SELECT PAID FROM USERLOT";
                ps3 = con.prepareStatement(lotQuery);
                rs3 = ps3.executeQuery();
                                while (rs3.next()) {
                                      boolean paid = rs3.getBoolean("PAID");
					lotTotal++;
					if (paid)
						lotPaid++;
				}
                  
                session.setAttribute("homeownerPaid",hoPaid);
                session.setAttribute("homeownerTotal",hoTotal);
                session.setAttribute("membershipPaid",maPaid);
                session.setAttribute("membershipTotal",maTotal);
                session.setAttribute("lotPaid",lotPaid);
                session.setAttribute("lotTotal",lotTotal);
                response.sendRedirect("finances.jsp");
                //request.getRequestDispatcher("finances.jsp").forward(request,response);              
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
                if(rs2 != null)
                    rs2.close();
                if(ps2 != null)
                    ps2.close();
                if(rs3 != null)
                    rs3.close();
                if(ps3 != null)
                    ps3.close();
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
