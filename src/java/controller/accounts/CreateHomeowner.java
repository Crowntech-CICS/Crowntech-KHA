package controller.accounts;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.IdGenerator;
import model.connections.ConnectionPoolManager;
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
        
        try {
            //Connect to DB
            con = ConnectionPoolManager.getDataSource().getConnection();
            //USERID
            String userId = "HO-" + new IdGenerator().createFormatted("????-??");
            ps = con.prepareStatement("select userid from users where userid = ?");
            ps.setString(1, userId);
            rs = ps.executeQuery();
            while(rs.next()){
                userId = "HO-" + new IdGenerator().createFormatted("????-??");
                logger.info("TEST UID: " + userId);
                rs = ps.executeQuery();
            }
            //PROPERTYID
            String propId = "PR-" + new IdGenerator().createFormatted("????-??");
            ps = con.prepareStatement("select propertyid from userlot where propertyid = ?");
            ps.setString(1, propId);
            rs = ps.executeQuery();
            while(rs.next()){
                propId = "PR-" + new IdGenerator().createFormatted("????-??");
                logger.info("PID: " + propId);
                rs = ps.executeQuery();
            }
            //Split Registered name on title
            String[] p_name = request.getParameter("TIT_NAME").split(" ");
            if(p_name.length > 3) {
                p_name[0] = p_name[0] + " " + p_name[1];
                p_name[1] = p_name[2];
                p_name[2] = p_name[3];
                p_name[4] = null;
            }
            //Call create homeowner function
            ps = con.prepareStatement("SELECT create_homeowner(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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
            ps.setString(21, p_name[0]);
            ps.setString(22, p_name[1]);
            ps.setString(23, p_name[2]);
            ps.setString(24, request.getParameter("USER_HOUSENUM"));
            ps.setString(25, request.getParameter("USER_STREET"));
            ps.setString(26, request.getParameter("USER_BARANGAY"));
            ps.setString(27, request.getParameter("TIT_AREA"));
            ps.setString(28, request.getParameter("TIT_SURNUM"));
            ps.setString(29, request.getParameter("TIT_LOTNUM"));
            ps.setDate(30, Date.valueOf(LocalDate.parse(request.getParameter("TIT_DATE"))));
            ps.setFloat(31, (float) 0.0);
            ps.setString(32, request.getParameter("PRP_USE"));
            ps.setString(33, request.getParameter("BUS_NAME"));
            ps.setString(34, request.getParameter("BUS_TYPE"));
            ps.setDate(35, new Date(System.currentTimeMillis()));
            ps.setString(36, request.getParameter("TAX_NUM"));
            ps.setString(37, request.getParameter("PRP_INDEX"));
            //Attempt Insert
            rs = ps.executeQuery();
            if(rs.next());
                String result = rs.getString(1);
            if(result.equalsIgnoreCase("Duplicate")){
                logger.error("Error during insert " + result);
                if(!response.isCommitted()){
                    response.sendRedirect("./signup-homeowners.jsp?err=1");
                }
            }
            //LOG ACTION
            ps = con.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"action\") VALUES (?,?,?)");
            ps.setString(1, UUID.randomUUID().toString().substring(0,8));
            ps.setString(2, (String) request.getSession().getAttribute("currID"));
            ps.setString(3, "Created user " + request.getParameter("HO_LN") + "," + request.getParameter("HO_FN"));
            ps.executeUpdate();
            if(!response.isCommitted()){
                response.sendRedirect("./signup-homeowners.jsp?suc=true");
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
