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
        String lastName = request.getParameter("HO_LN").toLowerCase(),
               firstName = request.getParameter("HO_FN").toLowerCase(),
               middleIni = request.getParameter("HO_MI").toLowerCase(),
               email = request.getParameter("HO_EMAIL").toLowerCase(),
               ornum = request.getParameter("HO_ORNUM");
        Part filepart = request.getPart("FILES_UPLOAD");
        String filetype = filepart.getContentType();
        boolean found = false;
        String userid = "";
        
        System.out.println("-[SIGNUP]-------------------------------------------------------------------------------------------------------");
        System.out.println("Name: " + lastName + firstName + middleIni);
        System.out.println("Email: " + email);
        System.out.println("OR Num: " + ornum);
                
        if(filepart != null)
        {
            String filename = filepart.getSubmittedFileName();
            System.out.println("File Upload: " + filename);
            System.out.println("Size: " + filepart.getSize());
            System.out.println("Type: " + filepart.getContentType());
            
            InputStream input = filepart.getInputStream();
            
            //Connect to DB
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
            //Find user from database
            try {
                ps = con.prepareStatement("SELECT EMAIL FROM LOGIN WHERE LOWER(EMAIL) = ?");
                ps.setString(1, email);
                System.out.println("CHECKING LOGIN...");
                rs = ps.executeQuery();
                if(rs.next())
                {
                    boolean login = rs.getString("EMAIL").equalsIgnoreCase(email);
                    System.out.println("-[LOGIN MATCH TEST]------------------------------------------------------------------------");
                    System.out.println("EM: " + (login? "MATCH":"DIFF"));
                    
                    if(login)
                    {
                        System.out.println("FOUND IN LOGIN");
                        response.sendRedirect("signup.jsp?suc=" + found + "&err=1");
                    } 
                } else {    
                    System.out.println("NOT IN LOGIN");

                    ps = con.prepareStatement("SELECT HOMEOWNERID,LASTNAME,FIRSTNAME,MIDDLEINITIAL,EMAIL,ORNUM FROM HOMEOWNER WHERE LOWER(LASTNAME) = ? AND LOWER(FIRSTNAME) = ? AND LOWER(MIDDLEINITIAL) = ? AND LOWER(EMAIL) = ? AND ORNUM = ?");
                    ps.setString(1, lastName);
                    ps.setString(2, firstName);
                    ps.setString(3, middleIni);
                    ps.setString(4, email);
                    ps.setString(5, ornum);
                    System.out.println("CHECKING HOMEOWNER...");
                    rs = ps.executeQuery();
                    if(rs.next())
                    {
                        System.out.println("FOUND EMAIL IN HOMEOWNER");
                        System.out.println("-[HOMEOWNER MATCH TEST]------------------------------------------------------------------------");
                        System.out.println("LN: " + (rs.getString("LASTNAME").equalsIgnoreCase(lastName)? "MATCH":"DIFF"));
                        System.out.println("FN: " + (rs.getString("FIRSTNAME").equalsIgnoreCase(firstName)? "MATCH":"DIFF"));
                        System.out.println("MI: " + (rs.getString("MIDDLEINITIAL").equalsIgnoreCase(middleIni)? "MATCH":"DIFF"));
                        System.out.println("EM: " + (rs.getString("EMAIL").equalsIgnoreCase(email)? "MATCH":"DIFF"));
                        System.out.println("EM: " + (rs.getString("ORNUM").equalsIgnoreCase(ornum)? "MATCH":"DIFF"));
                        String hid = rs.getString("HOMEOWNERID").trim();
                        found = true;
                        ps = con.prepareStatement("SELECT USERID FROM USERS WHERE HOMEOWNERID = ?");
                        ps.setString(1, hid);
                        System.out.println("GETTING USERID...");
                        rs = ps.executeQuery();
                        if(rs.next())
                        {
                            userid = rs.getString("USERID").trim();
                            System.out.println("UID: " + userid);
                        } else {
                            System.out.println("NO USERID FOUND.");
                            response.sendRedirect("signup.jsp?suc=" + found + "&err=3");
                        }

                    } else {
                        System.out.println("NO HOMEOWNER RECORD FOUND");
                        response.sendRedirect("signup.jsp?suc=" + found + "&err=2");
                    }
                }
                
            } catch (SQLException sqle) {
                System.out.println("SQLException error occured in Find - " + sqle.getMessage());
                response.sendError(500);
            }
           
            //System.out.println("File: " + filename + " uploaded succesfully.");
        }
        
        System.out.println("------------------------------------------------------------------------------------------------------------");
        if(!response.isCommitted()){
            request.setAttribute("email", email);
            request.setAttribute("userid", userid);
            request.getRequestDispatcher("/accounts/password/createpassword.jsp").forward(request, response);
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
