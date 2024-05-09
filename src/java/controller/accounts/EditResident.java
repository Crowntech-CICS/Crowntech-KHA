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
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class EditResident extends HttpServlet {
    private static final Log logger = LogFactory.getLog(EditResident.class);
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
        HttpSession session = request.getSession();
        String root = request.getContextPath();
        try {
            //Connect to DB
            con = ConnectionPoolManager.getDataSource().getConnection();
            //Update record in database
            ps = con.prepareStatement("update users set lastname = ?,firstname = ?,middleinitial = ?,email = ?,age = ? where userid = ?");
            ps.setString(1, request.getParameter("RES_LN"));
            ps.setString(2, request.getParameter("RES_FN"));
            ps.setString(3, request.getParameter("RES_MI"));
            ps.setString(4, request.getParameter("RES_EMAIL"));
            ps.setInt(5, Integer.parseInt(request.getParameter("RES_AGE")));
            ps.setString(6,request.getParameter("USERID"));
            ps.executeUpdate();
            ps = con.prepareStatement("update residents set propertyid = ?, relationship = ? where userid = ?");
            ps.setString(1, request.getParameter("RES_PROP"));
            ps.setString(2, request.getParameter("RES_REL"));
            ps.setString(3,request.getParameter("USERID"));
            ps.executeUpdate();
            
            //LOG ACTION
            new DBLogger().log((String) session.getAttribute("currID"), "Edited resident " + request.getParameter("RES_LN") + "," + request.getParameter("RES_FN"));
            //Redirect
            if(!response.isCommitted()){
                response.sendRedirect(root + "/accounts/choose/residents.jsp");
            }
        } catch (SQLException sqle) {
            //LOG ACTION
            new DBLogger().log((String) session.getAttribute("currID"), "Error editing resident " + request.getParameter("RES_LN") + "," + request.getParameter("RES_FN"));
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
                //LOG ACTION
                new DBLogger().log((String) session.getAttribute("currID"), "Error editing user " + request.getParameter("RES_LN") + "," + request.getParameter("RES_FN"));
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
