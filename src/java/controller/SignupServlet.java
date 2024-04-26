package controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
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
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

@MultipartConfig(fileSizeThreshold=1024*1024*10,    // 10 MB 
                 maxFileSize=1024*1024*50,          // 50 MB
                 maxRequestSize=1024*1024*100,      // 100 MB
                 location="/uploaded"
                )

public class SignupServlet extends HttpServlet {
    private static final Log logger = LogFactory.getLog(SignupServlet.class);
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
        
        logger.info("-[SIGNUP]-------------------------------------------------------------------------------------------------------");
        logger.info("Name: " + lastName + firstName + middleIni);
        logger.info("Email: " + email);
        logger.info("OR Num: " + ornum);

        String filename = filepart.getSubmittedFileName();
        logger.info("File Upload: " + filename);
        logger.info("Size: " + filepart.getSize());
        logger.info("Type: " + filetype);

        InputStream input = filepart.getInputStream();

        try {
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            //Find user from database
            ps = con.prepareStatement("SELECT EMAIL FROM LOGIN WHERE LOWER(EMAIL) = ?");
            ps.setString(1, email);
            logger.info("CHECKING LOGIN...");
            rs = ps.executeQuery();
            if(rs.next())
            {
                boolean login = rs.getString("EMAIL").equalsIgnoreCase(email);
                logger.info("-[LOGIN MATCH TEST]------------------------------------------------------------------------");
                logger.info("EM: " + (login? "MATCH":"DIFF"));

                if(login)
                {
                    logger.info("FOUND IN LOGIN");
                    response.sendRedirect("signup.jsp?suc=" + found + "&err=1");
                } 
            } else {    
                logger.error("NOT IN LOGIN");

                ps = con.prepareStatement("SELECT HOMEOWNERID,LASTNAME,FIRSTNAME,MIDDLEINITIAL,EMAIL,ORNUM FROM HOMEOWNER WHERE LOWER(LASTNAME) = ? AND LOWER(FIRSTNAME) = ? AND LOWER(MIDDLEINITIAL) = ? AND LOWER(EMAIL) = ? AND ORNUM = ?");
                ps.setString(1, lastName);
                ps.setString(2, firstName);
                ps.setString(3, middleIni);
                ps.setString(4, email);
                ps.setString(5, ornum);
                logger.info("CHECKING HOMEOWNER...");
                rs = ps.executeQuery();
                if(rs.next())
                {
                    logger.info("FOUND EMAIL IN HOMEOWNER");
                    logger.info("-[HOMEOWNER MATCH TEST]------------------------------------------------------------------------");
                    logger.info("LN: " + (rs.getString("LASTNAME").equalsIgnoreCase(lastName)? "MATCH":"DIFF"));
                    logger.info("FN: " + (rs.getString("FIRSTNAME").equalsIgnoreCase(firstName)? "MATCH":"DIFF"));
                    logger.info("MI: " + (rs.getString("MIDDLEINITIAL").equalsIgnoreCase(middleIni)? "MATCH":"DIFF"));
                    logger.info("EM: " + (rs.getString("EMAIL").equalsIgnoreCase(email)? "MATCH":"DIFF"));
                    logger.info("EM: " + (rs.getString("ORNUM").equalsIgnoreCase(ornum)? "MATCH":"DIFF"));
                    String hid = rs.getString("HOMEOWNERID").trim();
                    found = true;
                    ps = con.prepareStatement("SELECT USERID FROM USERS WHERE HOMEOWNERID = ?");
                    ps.setString(1, hid);
                    logger.info("GETTING USERID...");
                    rs = ps.executeQuery();
                    if(rs.next())
                    {
                        userid = rs.getString("USERID").trim();
                        logger.info("UID: " + userid);
                    } else {
                        logger.error("NO USERID FOUND.");
                        response.sendRedirect("signup.jsp?suc=" + found + "&err=3");
                    }

                } else {
                    logger.error("NO HOMEOWNER RECORD FOUND");
                    response.sendRedirect("signup.jsp?suc=" + found + "&err=2");
                }
            }

        } catch (SQLException sqle) {
            logger.error("SQLException error occured in Find - " + sqle.getMessage());
            response.sendError(500);
        } catch (NullPointerException npe) {
            logger.error("NullPointerException - " + npe.getMessage());
            response.sendError(500);
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
