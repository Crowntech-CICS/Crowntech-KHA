package controller.accounts;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.DBLogger;
import model.connections.ConnectionPoolManager;
import model.uniqueId.UniqueIdGenerator;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CreateAdmin extends HttpServlet {
    private static final Log logger = LogFactory.getLog(CreateAdmin.class);
    protected Connection con;
    protected ResultSet rs;
    protected PreparedStatement ps;
    
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
        String root = request.getContextPath();
        HttpSession session = request.getSession();
        try {
            //Get Connection
            con = ConnectionPoolManager.getDataSource().getConnection();
            //Set appropriate level prefix
            String level = request.getParameter("ADMIN_ROLE").toUpperCase();
            String prefix = "ST-";
            if (level.equals("ADMIN")){
                prefix = "AD-";
            }else if (level.equals("BOARD OF DIRECTOR")){
                prefix = "BD-";
            }
            //USERID
            UniqueIdGenerator uid = new UniqueIdGenerator();
            String userId = uid.userId(prefix);
            
            //Create Account
            ps = con.prepareStatement("select create_staff(?,?,?,?,?,?,?)");
            ps.setString(1, userId);
            ps.setString(2, rs.getString("ADMIN_EMAIL"));
            ps.setString(3, rs.getString("ADMIN_LN"));
            ps.setString(4, rs.getString("ADMIN_FN"));
            ps.setString(5, rs.getString("ADMIN_MI"));
            ps.setInt(6, Integer.parseInt(rs.getString("ADMIN_AGE")));
            ps.setString(7, rs.getString("ADMIN_ROLE"));
            rs = ps.executeQuery();
            //Check if error
            if(rs.next());
                String result = rs.getString(1);
            if(result.equalsIgnoreCase("Duplicate")){
                logger.error("Error during insert " + result);
                //LOG ACTION
                new DBLogger().log((String) session.getAttribute("currID"), "Duplicate error creating " + request.getParameter("ADMIN_LN") + "," + request.getParameter("ADMIN_FN"));
                //Redirect
                if(!response.isCommitted()){
                    response.sendRedirect(root + "/accounts/signup/signup-admin.jsp?err=1");
                }
            } else if(result.equalsIgnoreCase("Other Error")){
                logger.error("Error during insert " + result);
                //LOG ACTION
                new DBLogger().log((String) session.getAttribute("currID"), "Unknown error creating " + request.getParameter("ADMIN_LN") + "," + request.getParameter("ADMIN_FN"));
                //Redirect
                if(!response.isCommitted()){
                    response.sendRedirect(root + "/accounts/signup/signup-admin.jsp?err=2");
                }
            }
            //LOG ACTION
            new DBLogger().log((String) session.getAttribute("currID"), "Created high-level account " + request.getParameter("ADMIN_LN") + "," + request.getParameter("ADMIN_FN"));
            //Redirect
            if(!response.isCommitted()){
                response.sendRedirect(root + "/accounts/signup/signup-admin.jsp?suc=true");
            }
        } catch (SQLException sqle) {
            logger.error("SQLException error occured in INSERT - " + sqle.getMessage());
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
                logger.error("SQLException error occured in Closing - " + sqle.getMessage());
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
