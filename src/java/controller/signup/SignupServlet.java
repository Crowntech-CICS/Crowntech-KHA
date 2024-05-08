package controller.signup;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
        String lastName = request.getParameter("HO_LN").toLowerCase();
        String firstName = request.getParameter("HO_FN").toLowerCase();
        String middleIni = request.getParameter("HO_MI").toLowerCase();
        String email = request.getParameter("HO_EMAIL").toLowerCase();
        String ornum = request.getParameter("HO_ORNUM");
        Part filepart = request.getPart("FILES_UPLOAD");
        String filetype = filepart.getContentType();
        String userid = "";
        
        logger.info("SignUpServlet processRequest");
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
            //Validate if user is in database
            ps = con.prepareStatement("select u.*,h.ornum from users u join homeowner h on u.userid = h.userid where lower(lastname) = ? and lower(firstname) = ? and lower(middleinitial) = ? and lower(email) = ? and ornum = ?");
            ps.setString(1, lastName);
            ps.setString(2, firstName);
            ps.setString(3, middleIni);
            ps.setString(4, email);
            ps.setString(5, ornum);
            logger.info("VALIDATING USER...");
            rs = ps.executeQuery();           
            if(rs.next()) //User found
            {                
                if(rs.getDate("date_registered") == null) //Check if not yet registered
                {
                    userid = rs.getString("USERID").trim();
                    logger.info("UID: " + userid);
                } else {
                    logger.error("USER ALREADY REGISTERED");
                    response.sendRedirect("signup.jsp?suc=false&err=1");
                }
            } else {
                //User in not in the database
                logger.error("NO RECORD FOUND");
                response.sendRedirect("signup.jsp?suc=false&err=2");
            }
        } catch (SQLException sqle) {
            logger.error("SQLException error occured in Find - " + sqle.getMessage());
            response.sendError(500);
        } catch (NullPointerException npe) {
            logger.error("NullPointerException - " + npe.getMessage());
            response.sendError(500);
        }
        
        if(!response.isCommitted()){ //Proceed to create password
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
