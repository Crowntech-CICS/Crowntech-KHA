package controller.auth;

import java.io.IOException;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Homeowner;
import model.Resident;
import model.UserLot;
import model.Vehicle;
import model.connections.ConnectionPoolManager;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Login extends HttpServlet {
    private static final Log logger = LogFactory.getLog(Login.class);
    protected static Connection con;
    protected static ResultSet rs;
    protected static PreparedStatement ps;
    protected int allowedTries = 3;
    protected int ctr;
       
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
        logger.info("Login Servlet processRequest.");
        String encrpytKey = getServletContext().getInitParameter("key");
        String cipher = getServletContext().getInitParameter("cipher");
        HttpSession session = request.getSession();
        boolean logState = session.getAttribute("username") != null;
        if(logState) {
            response.sendRedirect("index.jsp");
        }  
               
        boolean found = false;
        ctr = (int) session.getAttribute("tries");
        String userEmail = request.getParameter("email").toLowerCase();
        String userPass = model.Encryption.encrypt(request.getParameter("password"), encrpytKey, cipher);

        try{
            //Get connection from connection pool
            con = ConnectionPoolManager.getDataSource().getConnection();
            ps = con.prepareStatement("select * from get_login(?,?);");
            ps.setString(1, userEmail);
            ps.setString(2, userPass);
            rs = ps.executeQuery();
            
            if(rs.next()){ //If user is in database
                System.out.println("FOUND IN DB");
                //Get data from ResultSet
                String emailDB = rs.getString("EMAIL").trim().toLowerCase();
                String passwordDB = rs.getString("PASSWORD").trim();
                String userID = rs.getString("USERID").trim();
                String levelDB = rs.getString("RESIDENTCLASS").trim().toLowerCase();
                String userName = rs.getString("FIRSTNAME").trim();
                String lastName = rs.getString("LASTNAME").trim();
                String middleIni = rs.getString("MIDDLEINITIAL").trim();
                String resDB = rs.getString("RESIDENTCLASS").trim();
                int age = rs.getInt("AGE");              
                
                logger.info(String.format("Email: %s - Level: %s", emailDB, levelDB));//print the contents resultset row
                
                if(userEmail.equalsIgnoreCase(emailDB) && userPass.equals(passwordDB)){
                    if(levelDB.equals("homeowner")) {
                        Homeowner user = new Homeowner();
                        ps = con.prepareStatement("select * from homeowner where userid = ?");
                        ps.setString(1, userID);
                        rs = ps.executeQuery();
                        if(rs.next()){
                            String mobNo = rs.getString("mobileno");
                            String landNo = rs.getString("landlineno");
                            String rep = rs.getString("representative");
                            String repMobNo = rs.getString("repmobileno");
                            String houseNo = rs.getString("houseno");
                            String street = rs.getString("streetname");
                            String village = rs.getString("village");
                            String barangay = rs.getString("barangay");
                            String city = rs.getString("city");
                            String province = rs.getString("province");
                            String orNum = rs.getString("ornum");
                            
                            user = new Homeowner(userID, emailDB, lastName, userName, middleIni, age, resDB,
                            mobNo, landNo, rep, repMobNo, houseNo,
                            street, village, barangay, city, province, orNum);
                        }
                        ps = con.prepareStatement("select * from vehicle where userid = ?");
                        ps.setString(1, userID);
                        rs = ps.executeQuery();
                        ArrayList<Vehicle> cars = new ArrayList<>(); 
                        if(rs.next()) {
                            String vhID = rs.getString("vehicleid").trim();
                            String type = rs.getString("type").trim();
                            String plateno = rs.getString("plateno").trim();
                            String brand = rs.getString("brand").trim();
                            String model = rs.getString("model").trim();
                            String vLN = rs.getString("lastname").trim();
                            String vFN = rs.getString("firstname").trim();
                            String vMN = rs.getString("middleinitial").trim();
                            
                            Vehicle car = new Vehicle(vhID, userID, type, plateno, brand, model, vLN, vFN, vMN);
                            cars.add(car);
                        }
                        user.setCars(cars);
                        
                        ps = con.prepareStatement("select * from userlot where userid = ?");
                        ps.setString(1, userID);
                        rs = ps.executeQuery();
                        ArrayList<UserLot> lots = new ArrayList<>();
                        if(rs.next()){
                            String propID = rs.getString("propertyid").trim();
                            String titleNo = rs.getString("titleno").trim();
                            String lotRegName = rs.getString("registeredname").trim();
                            String houseNo = rs.getString("houseno").trim();
                            String street = rs.getString("streetname").trim();
                            String barangay = rs.getString("barangay").trim();
                            String area = rs.getString("area").trim();
                            String surNo = rs.getString("surveyNo").trim();
                            String lotNo = rs.getString("lotno").trim();
                            Date dateReg = rs.getDate("dateregistered");
                            float balance = rs.getFloat("balance");
                            String use = rs.getString("use");
                            String businessName = rs.getString("businessname").trim();
                            String businessType = rs.getString("businesstype").trim();
                            Date paymentDate = rs.getDate("paymentdate");
                            String taxDecNo = rs.getString("taxdecno").trim();
                            String propInNo = rs.getString("propindexno").trim();
                            
                            UserLot lot = new UserLot(propID, titleNo, lotRegName,
                            houseNo, street, barangay, area,
                            surNo, lotNo, dateReg, balance, use, businessName, businessType,
                            paymentDate, taxDecNo, propInNo);
                            
                            lots.add(lot);
                        }
                        user.setLot(lots);
                        
                        session.setAttribute("currUser", user);
                    }
                    
                    if(levelDB.equals("resident")) {
                        Resident user = new Resident();
                        ps = con.prepareStatement("select * from resident where userid = ?");
                        ps.setString(1, userID);
                        rs = ps.executeQuery();
                        while(rs.next()){
                            String propID = rs.getString("propertyid").trim();
                            String relationship = rs.getString("relationship").trim();
                            
                            user = new Resident(userID, emailDB, lastName, userName, middleIni, age, resDB, propID, relationship);
                        }
                        
                        session.setAttribute("currUser", user);
                    }
                    
                    // User user = new User(userID, emailDB, lastName, userName, middleIni, age, levelDB);
                    session.setAttribute("username", userName);
                    session.setAttribute("level", levelDB);
                    session.setAttribute("currID", userID);
                    System.out.println("Found user in the database");
                    found = true;                    
                }
            } else { //Not in database
                logger.error("NO RECORD IN DB");
            }
            
            if(found){ //verifies if the user is in the database and redirect them to the homepage
                if(!con.isClosed())
                    con.close();
                ctr = 0;
                session.removeAttribute("tries");
                response.sendRedirect("generalpurpose/index.jsp");
            }
            else if(ctr < allowedTries - 1){ //shows a message that the email or password is wrong (total of 3 tries)
                ctr++;
                session.setAttribute("tries", ctr);
                request.setAttribute("succ", "true"); //NOTE: FOR VERIFICATION FOR POPUP IN THE LOGIN PAGE
                response.sendRedirect("login.jsp");
            }
            else{ //throw an error message which will redirect the user to error 440 page
                ctr = 0;
                session.removeAttribute("tries");
                response.sendRedirect("./accounts/password/reset.jsp");
            }
        } catch(SQLException sqle){
            logger.error("SQLException error occured in try - " + sqle.getMessage());
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
                logger.error("SQLException error occured in finally - " + sqle.getMessage());
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
