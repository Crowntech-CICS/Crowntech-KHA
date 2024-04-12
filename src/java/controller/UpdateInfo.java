/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import static controller.Login.con;
import static controller.Login.ps;
import static controller.Login.rs;
import java.io.*;
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

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String lastName = request.getParameter("HO_LN"),
                firstName = request.getParameter("HO_FN"),
                middleIni = request.getParameter("HO_MI"),
                address = request.getParameter("HO_ADDRESS"),
                age = request.getParameter("HO_AGE"),
                date = request.getParameter("HO_DATE"),
                resClass = request.getParameter("HO_CLASS"),
                email = request.getParameter("HO_EMAIL"),
                mobileNo = request.getParameter("HO_CONTACTNUM"),
                lnB = request.getParameter("HO_LN_B"),
                fnB = request.getParameter("HO_FN_B"),
                miB = request.getParameter("HO_MI_B"),
                resRel = request.getParameter("RES_REL"),
                titleNo = request.getParameter("TIT_NUM"),
                surNum = request.getParameter("TIT_SURNUM"),
                lotNum = request.getParameter("TIT_LOTNUM"),
                titDate = request.getParameter("TIT_DATE"),
                titArea = request.getParameter("TIT_AREA"),
                taxNum = request.getParameter("TAX_NUM"),
                propInd = request.getParameter("PRP_INDEX"),
                payDate = request.getParameter("PAID_DATE"),
                memName = request.getParameter("MEM_NAME"),
                propUse = request.getParameter("PRP_USE");
        int page = Integer.parseInt(request.getParameter("FORM_NO"));
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
        if (page == 1) {
            String[] p1Inputs = {lastName, firstName, middleIni, date, address, age};
            for (int x = 0; p1Inputs.length > x; x++) {

            }
        }
        try {
            PreparedStatement ps;
            ResultSet rs;
            switch (page) {
                case 1:
                    //  p1Inputs = {lastName, firstName, middleIni, date, address, age};
                    ps = con.prepareStatement("SELECT * FROM USERS WHERE USERID = ?");
                    ps.setString(1, (String) session.getAttribute("currID"));
                    System.out.println("Username in UpdateInfo: " + (String) session.getAttribute("currID"));
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        if (lastName.equals("")) {
                            lastName = rs.getString("LASTNAME");
                        }
                        if (firstName.equals("")) {
                            firstName = rs.getString("FIRSTNAME");
                        }
                        if (middleIni.equals("")) {
                            middleIni = rs.getString("MIDDLEINITIAL");
                        }
                        if (date.equals("")) {
                            date = rs.getString("DATEOCCUPIED");
                        }
                        if (age.equals("")) {
                            age = Integer.toString(rs.getInt("AGE"));
                        }
                        HOID = rs.getString("HOMEOWNERID");
                        System.out.println("UPDATE USERS SET LASTNAME = " + lastName + ", FIRSTNAME = " + firstName + ", MIDDLEINITIAL = " + middleIni + ", AGE = " + age + ", DATEOCCUPIED = " + date);
                        PreparedStatement psUpdate = con.prepareStatement("UPDATE USERS SET LASTNAME = ?, FIRSTNAME = ?, MIDDLEINITIAL = ?, AGE = ?, DATEOCCUPIED = ? WHERE USERID = ?");
                        psUpdate.setString(1, lastName);
                        psUpdate.setString(2, firstName);
                        psUpdate.setString(3, middleIni);
                        psUpdate.setString(4, age);
                        psUpdate.setString(5, date);
                        psUpdate.setString(6, (String) session.getAttribute("currID"));
                        psUpdate.executeUpdate();
                    }
                    PreparedStatement psHO = con.prepareStatement("SELECT * FROM USERS WHERE HOMEOWNERID = ?");
                    psHO.setString(1, HOID);
                    rs = psHO.executeQuery();
                    while(rs.next()){
                        if (lastName.equals("")) {
                            lastName = rs.getString("LASTNAME");
                        }
                        if (firstName.equals("")) {
                            firstName = rs.getString("FIRSTNAME");
                        }
                        if (middleIni.equals("")) {
                            middleIni = rs.getString("MIDDLEINITIAL");
                        }
                        if (date.equals("")) {
                            date = rs.getString("DATEOCCUPIED");
                        }
                        if (age.equals("")) {
                            age = Integer.toString(rs.getInt("AGE"));
                        }
                        System.out.println("UPDATE HOMEOWNER SET LASTNAME = " + lastName + ", FIRSTNAME = " + firstName + ", MIDDLEINITIAL = " + middleIni + ", AGE = " + age + ", DATEOCCUPIED = " + date);
                        PreparedStatement psUpdate = con.prepareStatement("UPDATE HOMEOWNER SET LASTNAME = ?, FIRSTNAME = ?, MIDDLEINITIAL = ? WHERE HOMEOWNERID = ?");
                        psUpdate.setString(1, lastName);
                        psUpdate.setString(2, firstName);
                        psUpdate.setString(3, middleIni);
                        psUpdate.setString(4, HOID);
                        psUpdate.executeUpdate();
                    }
                    break;
                case 2:
                    // p2Inputs = {email, mobileNo};
                    ps = con.prepareStatement("SELECT * FROM USERS WHERE USERID = ?");
                    ps.setString(1, (String) session.getAttribute("currID"));
                    rs = ps.executeQuery();
                    while(rs.next()) {
                        HOID = rs.getString("HOMEOWNERID");
                    }
                    psHO = con.prepareStatement("SELECT * FROM USERS WHERE HOMEOWNERID = ?");
                    psHO.setString(1, HOID);
                    rs = psHO.executeQuery();
                    while(rs.next()){
                        if(email.equals(""))
                            email = rs.getString("EMAIL");
                        if(mobileNo.equals(""))
                            mobileNo = rs.getString("MOBILENO");
                    }
                    break;
                case 3:
                    break;
                case 4:
                    break;
                case 5:
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
        response.sendRedirect("edit-homeowners.jsp");
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
