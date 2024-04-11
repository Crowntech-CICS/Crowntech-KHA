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

/**
 *
 * @author ejlu1
 */
public class UpdateInfo extends HttpServlet {

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

        String lastName = request.getParameter("HO_LN"),
                firstName = request.getParameter("HO_FN"),
                middleIni = request.getParameter("HO_MI"),
                address = request.getParameter("HO_ADDRESS"),
                age = request.getParameter("HO_AGE"),
                date = request.getParameter("HO_DATE"),
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
            String query;
            switch (page) {
                case 1:
                    query = "UPDATE USERS SET ";
                    String[] p1Inputs = {lastName, firstName, middleIni, date, address, age};
                    for (int x = 0; p1Inputs.length > x; x++) {
                        if(p1Inputs[x] != null) {
                            
                        }
                    }
                    break;
                case 2:
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
