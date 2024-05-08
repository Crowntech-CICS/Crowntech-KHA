package controller.accounts;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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

public class CreateHomeowner extends HttpServlet {
    private static final Log logger = LogFactory.getLog(CreateHomeowner.class);
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
            //Connect to DB
            con = ConnectionPoolManager.getDataSource().getConnection();
            //Generate IDs
            UniqueIdGenerator uid = new UniqueIdGenerator();
            String userId = uid.userId("HO-");
            String propId = uid.propertyId();
            //Call create homeowner function
            ps = con.prepareStatement("SELECT create_homeowner(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, userId);
            ps.setString(2, request.getParameter("HO_EMAIL"));
            ps.setString(3, request.getParameter("HO_LN"));
            ps.setString(4, request.getParameter("HO_FN"));
            ps.setString(5, request.getParameter("HO_MI"));
            ps.setInt(6, Integer.parseInt(request.getParameter("HO_AGE")));
            ps.setString(7, request.getParameter("HO_PHONE"));
            ps.setString(8, request.getParameter("HO_LANDLINE"));
            ps.setString(9, ""); //Representative
            ps.setString(10, ""); //Rep Phone Number
            ps.setString(11, request.getParameter("HO_HOUSENUM"));
            ps.setString(12, request.getParameter("HO_STREET"));
            ps.setString(13, request.getParameter("HO_VILLAGE"));
            ps.setString(14, request.getParameter("HO_BARANGAY"));
            ps.setString(15, request.getParameter("HO_CITY"));
            ps.setString(16, request.getParameter("HO_PROVINCE"));
            ps.setString(17, request.getParameter("OR_NUM"));
            ps.setString(18, propId);
            ps.setString(19, userId);
            ps.setString(20, request.getParameter("TIT_NUM"));
            ps.setString(21, request.getParameter("TIT_NAME"));
            ps.setString(22, request.getParameter("USER_HOUSENUM"));
            ps.setString(23, request.getParameter("USER_STREET"));
            ps.setString(24, request.getParameter("USER_BARANGAY"));
            ps.setString(25, request.getParameter("TIT_AREA"));
            ps.setString(26, request.getParameter("TIT_SURNUM"));
            ps.setString(27, request.getParameter("TIT_LOTNUM"));
            ps.setDate(28, Date.valueOf(LocalDate.parse(request.getParameter("TIT_DATE"))));
            ps.setFloat(29, (float) 0.0);
            ps.setString(30, request.getParameter("PRP_USE"));
            ps.setString(31, request.getParameter("BUS_NAME"));
            ps.setString(32, request.getParameter("BUS_TYPE"));
            ps.setDate(33, new Date(System.currentTimeMillis()));
            ps.setString(34, request.getParameter("TAX_NUM"));
            ps.setString(35, request.getParameter("PRP_INDEX"));
            //Attempt Insert
            rs = ps.executeQuery();
            if(rs.next());
                String result = rs.getString(1);
            if(result.equalsIgnoreCase("Duplicate")){
                logger.error("Error during insert " + result);
                //LOG ACTION
                new DBLogger().log((String) session.getAttribute("currID"), "Duplicate error creating " + request.getParameter("HO_LN") + "," + request.getParameter("HO_FN"));
                //Redirect
                if(!response.isCommitted()){
                    response.sendRedirect(root + "/accounts/signup/signup-homeowners.jsp?err=1");
                }
            } else if(result.equalsIgnoreCase("Other Error")){
                logger.error("Error during insert " + result);
                //LOG ACTION
                new DBLogger().log((String) session.getAttribute("currID"), "Unknown error creating " + request.getParameter("HO_LN") + "," + request.getParameter("HO_FN"));
                //Redirect
                if(!response.isCommitted()){
                    response.sendRedirect(root + "/accounts/signup/signup-homeowners.jsp?err=2");
                }
            }
            //LOG ACTION
            new DBLogger().log((String) session.getAttribute("currID"), "Created user " + request.getParameter("HO_LN") + "," + request.getParameter("HO_FN"));
            //Redirect
            if(!response.isCommitted()){
                response.sendRedirect(root + "/accounts/signup/signup-homeowners.jsp?suc=true");
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
