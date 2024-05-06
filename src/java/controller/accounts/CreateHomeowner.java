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
import model.connections.ConnectionPoolManager;

public class CreateHomeowner extends HttpServlet {

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
            String uniqueId = "";
            //HOMEOWNER
            String homeownerId = uniqueId;
            ps = con.prepareStatement("SELECT COUNT(*) FROM HOMEOWNER");
            rs = ps.executeQuery();
            if(rs.next()){
                uniqueId = "HO" + String.format("%08d", rs.getInt(1));
                homeownerId = uniqueId;
                System.out.println("HOID: " + homeownerId);
            }
            //Insert into Database when Found
            ps = con.prepareStatement("insert into users (userid, email, password, lastname, firstname, middleinitial, age, residentclass, date_registered) values (?, ?, '', ?, ?, ?, 30, 'Resident', null);");
            ps.setString(1, homeownerId);
            ps.setString(2, request.getParameter("HO_LN"));
            ps.setString(3, request.getParameter("HO_FN"));
            ps.setString(4, request.getParameter("HO_MI"));
            ps.setString(5, request.getParameter("HO_EMAIL"));
            ps.setString(6, request.getParameter("HO_PHONE"));
            ps.setString(7, request.getParameter("HO_LANDLINE"));
            ps.setString(8, "");
            ps.setString(9, "");
            ps.setString(10, request.getParameter("HO_HOUSENUM"));
            ps.setString(11, request.getParameter("HO_STREET"));
            ps.setString(12, request.getParameter("HO_VILLAGE"));
            ps.setString(13, request.getParameter("HO_BARANGAY"));
            ps.setString(14, request.getParameter("HO_CITY"));
            ps.setString(15, request.getParameter("HO_PROVINCE"));
            ps.setBoolean(16, true);
            ps.setDouble(17, 0.0);
            ps.setString(18, request.getParameter("OR_NUM"));
            System.out.println("HOME Insert: " + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            //USERS
            String userId = uniqueId;
            ps = con.prepareStatement("SELECT COUNT(*) FROM USERS");
            rs = ps.executeQuery();
            if(rs.next()){
                uniqueId = "HO" + String.format("%08d", rs.getInt(1));
                userId = uniqueId;
                System.out.println("UID: " + userId);
            }
            ps = con.prepareStatement("INSERT INTO USERS(USERID,HOMEOWNERID,LASTNAME,FIRSTNAME,MIDDLEINITIAL,AGE,RESIDENTCLASS,HOUSENO,STREETNAME,DATEOCCUPIED) VALUES(?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, userId);
            ps.setString(2, homeownerId);
            ps.setString(3, request.getParameter("HO_LN"));
            ps.setString(4, request.getParameter("HO_FN"));
            ps.setString(5, request.getParameter("HO_MI"));
            ps.setInt(6, Integer.parseInt(request.getParameter("HO_AGE")));
            ps.setString(7, "Homeowner");
            ps.setString(8, request.getParameter("HO_HOUSENUM"));
            ps.setString(9, request.getParameter("HO_STREET"));
            ps.setDate(10, Date.valueOf(LocalDate.parse(request.getParameter("HO_DATE"))));
            System.out.println("USER Insert: " + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            //USERLOT
            String propId = uniqueId;
            ps = con.prepareStatement("SELECT COUNT(*) FROM USERLOT");
            rs = ps.executeQuery();
            if(rs.next()){
                uniqueId = "PR" + String.format("%08d", rs.getInt(1));
                propId = uniqueId;
                System.out.println("PID: " + propId);
            }
            ps = con.prepareStatement("INSERT INTO USERLOT(PROPERTYID,TITLENO,REGISTEREDNAME,PAID,HOUSENO,STREETNAME,BARANGAY,AREA,SURVEYNO,LOTNO,DATEREGISTERED,BALANCE,HOMEOWNERID) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, propId);
            ps.setString(2, request.getParameter("TIT_NUM"));
            ps.setString(3, request.getParameter("TIT_NAME"));
            ps.setBoolean(4, true);
            ps.setString(5, request.getParameter("USER_HOUSENUM"));
            ps.setString(6, request.getParameter("USER_STREET"));
            ps.setString(7, request.getParameter("USER_BARANGAY"));
            ps.setString(8, request.getParameter("TIT_AREA"));
            ps.setString(9, request.getParameter("TIT_SURNUM"));
            ps.setString(10, request.getParameter("TIT_LOTNUM"));
            ps.setDate(11, Date.valueOf(LocalDate.parse(request.getParameter("TIT_DATE"))));
            ps.setDouble(12, 0.0);
            ps.setString(13, homeownerId);
            System.out.println("LOT Insert: " + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            //PROPERTYUSE
            ps = con.prepareStatement("INSERT INTO PROPERTYUSE (PROPERTYID, USE, BUSINESSNAME, BUSINESSTYPE) VALUES (?,?,?,?)");
            ps.setString(1, propId);
            ps.setString(2, request.getParameter("PRP_USE"));
            ps.setString(3, request.getParameter("BUS_NAME"));
            ps.setString(4, request.getParameter("BUS_TYPE"));
            System.out.println("USE Insert: " + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            //KHAMEMBERSHIP
            ps = con.prepareStatement("INSERT INTO KHAMEMBERSHIP (PROPERTYID, LASTNAME, FIRSTNAME, MIDDLEINITIAL, PAID, PAYMENTDATE) VALUES (?,?,?,?,?,?)");
            ps.setString(1, propId);
            ps.setString(2, request.getParameter("HO_LN"));
            ps.setString(3, request.getParameter("HO_FN"));
            ps.setString(4, request.getParameter("HO_MI"));
            ps.setBoolean(5, true);
            ps.setDate(6, Date.valueOf(LocalDate.parse(request.getParameter("PAID_DATE"))));
            System.out.println("MEM Insert: " + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            //TAXDECINFO
            ps = con.prepareStatement("INSERT INTO TAXDECINFO (PROPERTYID, IDNO, PROPINDEXNO) VALUES (?,?,?)");
            ps.setString(1, propId);
            ps.setString(2, request.getParameter("TAX_NUM"));
            ps.setString(3, request.getParameter("PRP_INDEX"));
            System.out.println("TAX Insert: " + ((ps.executeUpdate() > 0)? "Success" : "Failed"));
            
            ps = con.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"ACTION\",\"TIME\",\"DATE\") VALUES (?,?,?,CURRENT TIME,CURRENT DATE)");
            ps.setString(1, UUID.randomUUID().toString().substring(0,8));
            ps.setString(2, (String) request.getSession().getAttribute("currID"));
            ps.setString(3, "Created user " + request.getParameter("HO_LN") + "," + request.getParameter("HO_FN"));
            ps.executeUpdate();
            if(!response.isCommitted()){
                response.sendRedirect("./signup-homeowners.jsp?suc=true");
            }
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured in INSERT - " + sqle.getMessage());
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
                System.out.println("SQLException error occured in Closing - " + sqle.getMessage());
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
