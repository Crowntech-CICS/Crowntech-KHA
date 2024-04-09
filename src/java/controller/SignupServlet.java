package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold=1024*1024*10,    // 10 MB 
                 maxFileSize=1024*1024*50,          // 50 MB
                 maxRequestSize=1024*1024*100,      // 100 MB
                 location="/uploaded"
                )

public class SignupServlet extends HttpServlet {

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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String lastName = request.getParameter("HO_LN"),
               firstName = request.getParameter("HO_FN"),
               middleIni = request.getParameter("HO_MI"),
               email = request.getParameter("HO_EMAIL");
        Part filepart = request.getPart("FILES_UPLOAD");
        
        System.out.println("-[SIGNUP]-------------------------------------------------------------------------------------------------------");
        System.out.println("Page 1\nName: " + lastName + firstName + middleIni);
        System.out.println("Page 2:\nEmail: " + email);
                
        if(filepart != null)
        {
            String filename = filepart.getSubmittedFileName();
            System.out.println("File Upload: " + filename);
            System.out.println("Size: " + filepart.getSize());
            System.out.println("Type: " + filepart.getContentType());
            
            InputStream input = filepart.getInputStream();
            
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
                ps = con.prepareStatement("INSERT INTO APPLICATION(APPID,LASTNAME,FIRSTNAME,MIDDLEINITIAL,EMAIL,RECEIPT) VALUES (?,?,?,?,?,?)");
                ps.setString(1, UUID.randomUUID().toString().substring(0,6));
                ps.setString(2, lastName);
                ps.setString(3, firstName);
                ps.setString(4, middleIni);
                ps.setString(5, email);
                ps.setBlob(6, input);
                
                String insertStatus = (ps.executeUpdate() > 0)? "Success" : "Failed";
                System.out.println("Application insert status: " + insertStatus);
            } catch (SQLException sqle) {
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
            
            System.out.println("File: " + filename + " uploaded succesfully.");
        }
        
        //request.getRequestDispatcher("signup-homeowners.jsp").forward(request, response);
        System.out.println("------------------------------------------------------------------------------------------------------------");
        response.sendRedirect("index.jsp");
        }
        
    }
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
