/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ejlu1
 */
public class UpdateInfo extends HttpServlet {
    protected Connection con;
    protected ResultSet rs;
    protected PreparedStatement ps;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        String lastName = request.getParameter("HO_LN"),
                firstName = request.getParameter("HO_FN"),
                middleIni = request.getParameter("HO_MI"),
                age = request.getParameter("HO_AGE"),
                date = request.getParameter("HO_DATE"),
                email = request.getParameter("HO_EMAIL"),
                mobileNo = request.getParameter("HO_MOBNO"),
                landNo = request.getParameter("HO_LANDNO"),
                houseNo = request.getParameter("ADD_HOUSENO"),
                street = request.getParameter("ADD_STREET"),
                village = request.getParameter("ADD_VILL"),
                barangay = request.getParameter("ADD_BAR"),
                city = request.getParameter("ADD_CITY"),
                province = request.getParameter("ADD_PROV"),
                lnB = request.getParameter("HO_LN_B"),
                fnB = request.getParameter("HO_FN_B"),
                miB = request.getParameter("HO_MI_B"),
                otherID = request.getParameter("UOTHER_ID"),
                resRel = request.getParameter("RES_REL"),
                lnC = request.getParameter("HO_LN_C"),
                fnC = request.getParameter("HO_FN_C"),
                miC = request.getParameter("HO_MI_C"),
                resRelC = request.getParameter("RES_REL_C"),
                titleNo = request.getParameter("TIT_NUM"),
                surNum = request.getParameter("TIT_SURNUM"),
                lotNum = request.getParameter("TIT_LOTNUM"),
                titDate = request.getParameter("TIT_DATE"),
                titArea = request.getParameter("TIT_AREA"),
                taxNum = request.getParameter("TAX_NUM"),
                propInd = request.getParameter("PRP_INDEX"),
                payDate = request.getParameter("PAID_DATE"),
                memName = request.getParameter("MEM_NAME"),
                propUse = request.getParameter("PRP_USE"),
                vhID = request.getParameter("VHID"),
                vhPlate = request.getParameter("VEH_PLATE"),
                vhType = request.getParameter("VEH_TYPE"),
                vhBrand = request.getParameter("VEH_BRAND"),
                vhModel = request.getParameter("VEH_MODEL"),
                vhOwner = request.getParameter("VEH_OWNER");
        int page = 0;
        if (request.getParameter("FORM_NO") != null) {
            page = Integer.parseInt(request.getParameter("FORM_NO"));
        }
        String HOID = "";
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
            PreparedStatement ps;
            ResultSet rs;
            switch (page) {
                case 1: // Page 1 of Update Form (Personal Information Form)
                    //  p1Inputs = {lastName, firstName, middleIni, date, age, landline, mobile};
                    ps = con.prepareStatement("SELECT * FROM USERS WHERE USERID = ?");
                    ps.setString(1, (String) session.getAttribute("currID"));
                    System.out.println("Username in UpdateInfo: " + (String) session.getAttribute("currID"));
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        if (lastName.trim().equals("")) {
                            lastName = rs.getString("LASTNAME");
                        }
                        if (firstName.trim().equals("")) {
                            firstName = rs.getString("FIRSTNAME");
                        }
                        if (middleIni.trim().equals("")) {
                            middleIni = rs.getString("MIDDLEINITIAL");
                        }
                        if (age.trim().equals("")) {
                            age = Integer.toString(rs.getInt("AGE"));
                        }
                        HOID = rs.getString("userid");
                        System.out.println("UPDATE USERS SET LASTNAME = " + lastName + ", FIRSTNAME = " + firstName + ", MIDDLEINITIAL = " + middleIni + ", AGE = " + age + ", DATEOCCUPIED = " + date);
                        PreparedStatement psUpdate = con.prepareStatement("UPDATE USERS SET LASTNAME = ?, FIRSTNAME = ?, MIDDLEINITIAL = ?, AGE = ? WHERE USERID = ?");
                        psUpdate.setString(1, lastName);
                        psUpdate.setString(2, firstName);
                        psUpdate.setString(3, middleIni);
                        psUpdate.setString(4, age);
                        psUpdate.setString(5, (String) session.getAttribute("currID"));
                        psUpdate.executeUpdate();
                    }
                    PreparedStatement psHO = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE userid = ?");
                    psHO.setString(1, HOID);
                    rs = psHO.executeQuery();
                    System.out.println("psHO executed");
                    while (rs.next()) {
                        if (lastName.trim().equals("")) {
                            lastName = rs.getString("LASTNAME");
                        }
                        if (firstName.trim().equals("")) {
                            firstName = rs.getString("FIRSTNAME");
                        }
                        if (middleIni.trim().equals("")) {
                            middleIni = rs.getString("MIDDLEINITIAL");
                        }
                        if (landNo.trim().equals("")) {
                            landNo = rs.getString("LANDLINENO");
                        }
                        if (mobileNo.trim().equals("")) {
                            mobileNo = rs.getString("MOBILENO");
                        }
                        System.out.println("UPDATE HOMEOWNER SET LASTNAME = " + lastName + ", FIRSTNAME = " + firstName + ", MIDDLEINITIAL = " + middleIni);
                        PreparedStatement psUpdate = con.prepareStatement("UPDATE HOMEOWNER SET LASTNAME = ?, FIRSTNAME = ?, MIDDLEINITIAL = ?, LANDLINENO = ?, MOBILENO = ? WHERE HOMEOWNERID = ?");
                        psUpdate.setString(1, lastName);
                        psUpdate.setString(2, firstName);
                        psUpdate.setString(3, middleIni);
                        psUpdate.setString(4, landNo);
                        psUpdate.setString(5, mobileNo);
                        psUpdate.setString(6, HOID);
                        psUpdate.executeUpdate();
                    }
                    break;
                case 2: // Page 2 of Update Form (Address Form)
                    // p2Inputs = {houseno, street, village, barangay, city, province};
                    ps = con.prepareStatement("SELECT * FROM USERS WHERE USERID = ?");
                    ps.setString(1, (String) session.getAttribute("currID"));
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        HOID = rs.getString("HOMEOWNERID");
                        if (houseNo.trim().equals("")) {
                            houseNo = rs.getString("HOUSENO");
                        }
                        if (street.trim().equals("")) {
                            street = rs.getString("STREETNAME");
                        }
                        PreparedStatement psUpdate = con.prepareStatement("UPDATE USERS SET HOUSENO = ?, STREETNAME = ? WHERE USERID = ?");
                        psUpdate.setString(1, houseNo);
                        psUpdate.setString(2, street);
                        psUpdate.setString(3, (String) session.getAttribute("currID"));
                        psUpdate.executeUpdate();
                    }
                    psHO = con.prepareStatement("SELECT * FROM HOMEOWNER WHERE HOMEOWNERID = ?");
                    psHO.setString(1, HOID);
                    rs = psHO.executeQuery();
                    while (rs.next()) {
                        if (houseNo.trim().equals("")) {
                            houseNo = rs.getString("HOUSENO");
                        }
                        if (street.trim().equals("")) {
                            street = rs.getString("STREETNAME");
                        }
                        if (village.trim().equals("")) {
                            village = rs.getString("VILLAGE");
                        }
                        if (barangay.trim().equals("")) {
                            barangay = rs.getString("BARANGAY");
                        }
                        if (city.trim().equals("")) {
                            city = rs.getString("CITY");
                        }
                        if (province.trim().equals("")) {
                            province = rs.getString("PROVINCE");
                        }
                        PreparedStatement psUpdate = con.prepareStatement("UPDATE HOMEOWNER SET HOUSENO = ?, STREETNAME = ?, VILLAGE = ?, BARANGAY = ?, CITY = ?, PROVINCE = ? WHERE HOMEOWNERID = ?");
                        psUpdate.setString(1, houseNo.trim());
                        psUpdate.setString(2, street.trim());
                        psUpdate.setString(3, village.trim());
                        psUpdate.setString(4, barangay.trim());
                        psUpdate.setString(5, city.trim());
                        psUpdate.setString(6, province.trim());
                        psUpdate.setString(7, HOID.trim());
                        psUpdate.executeUpdate();
                    }
                    break;
                case 3: // Page 3 of Update Form (Add more Users)
                    // p3Inputs = {otherID, lnB, fnB, miB, resRel};
                    ps = con.prepareStatement("INSERT INTO USEROTHER (PROPERTYID, LASTNAME, FIRSTNAME, MIDDLEINITIAL, RELATIONSHIP) VALUES (?, ?, ?, ?, ?)");
                    System.out.print("Relationship: " + resRel);
                    ps.setString(1, otherID);
                    ps.setString(2, lnB);
                    ps.setString(3, fnB);
                    ps.setString(4, miB);
                    ps.setString(5, resRel);
                    ps.executeUpdate();
                    break;
                case 4: // Page 4 of Update Form
                    // p4Inputs = {titleNo, surNum, lotNum, titDate};
                    break;
                case 5:
                    break;
                case 6: // Edit Vehicle Information
                    // p6Inputs = {vhID, vhType, vhBrand, vhModel, vhOwner};
                    
                    ps = con.prepareStatement("SELECT * FROM VEHICLE WHERE VEHICLEID = ?");
                    ps.setString(1, vhID);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        if (vhType.trim().equals("")) {
                            vhType = rs.getString("TYPE");
                        }
                        if (vhBrand.trim().equals("")) {
                            vhBrand = rs.getString("BRAND");
                        }
                        if (vhModel.trim().equals("")) {
                            vhModel = rs.getString("MODEL");
                        }
                        if (vhOwner.trim().equals("")) {
                            vhOwner = rs.getString("registeredname");
                        }
                        if(vhPlate.trim().equals("")) {
                            vhPlate = rs.getString("plateno");
                        }
                    }
                    System.out.println("Taken inputs: " + vhPlate + vhID + vhType + vhBrand + vhModel + vhOwner);
                    PreparedStatement psUpdate = con.prepareStatement("UPDATE VEHICLE SET TYPE = ?, brand = ?, model = ?, registeredname = ?, plateno = ? WHERE VEHICLEID = ?");
                    psUpdate.setString(1, vhType);
                    psUpdate.setString(2, vhBrand);
                    psUpdate.setString(3, vhModel);
                    psUpdate.setString(4, vhOwner);
                    psUpdate.setString(5, vhPlate);
                    psUpdate.setString(6, vhID);
                    psUpdate.executeUpdate();
                    break;
                case 7: // updates the current other users (residents)
                    // p7Inputs = {otherID, lnB, fnB, miB, resRel, lnC, fnC, miC, resRelC}
                    if (lnB.trim().equals("")) {
                        lnB = lnC;
                    }
                    if (fnB.trim().equals("")) {
                        fnB = fnC;
                    }
                    if (miB.trim().equals("")) {
                        miB = miC;
                    }
                    if (resRel.trim().equals("")) {
                        resRel = resRelC;
                    }
                    psUpdate = con.prepareStatement("UPDATE USEROTHER SET LASTNAME = ?, FIRSTNAME = ?, MIDDLEINITIAL = ?, RELATIONSHIP = ? WHERE PROPERTYID = ? AND LASTNAME = ? AND FIRSTNAME = ? AND MIDDLEINITIAL = ? AND RELATIONSHIP = ?");
                    psUpdate.setString(1, lnB);
                    psUpdate.setString(2, fnB);
                    psUpdate.setString(3, miB);
                    psUpdate.setString(4, resRel);
                    psUpdate.setString(5, otherID);
                    psUpdate.setString(6, lnC);
                    psUpdate.setString(7, fnC);
                    psUpdate.setString(8, miC);
                    psUpdate.setString(9, resRelC);
                    psUpdate.executeUpdate();
                    
                    break;
                default:
                    response.sendRedirect("edit-homeowners.jsp");
                    break;
            }

        } catch (SQLException sqle) {
            System.out.println("SQLException IN error occured - " + sqle.getMessage());
            response.sendError(500);
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException sqle) {
                System.out.println("SQLException OUT error occured - " + sqle.getMessage());
                response.sendError(500);
            }
        }
        if(page == 6){
            response.sendRedirect(request.getContextPath() + "/staff/records-vehicles.jsp");
        }else {
            response.sendRedirect("profile.jsp");
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
