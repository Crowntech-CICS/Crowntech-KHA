/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ejlu1
 */
public class SignupServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String lastName = request.getParameter("HO_LN"),
               firstName = request.getParameter("HO_FN"),
               middleIni = request.getParameter("HO_MI"),
               address = request.getParameter("HO_ADDRESS"),
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
               propUse = request.getParameter("PRP_USE"),
               plateNo = request.getParameter("VEH_PLATE"),
               carType = request.getParameter("VEH_TYPE"),
               carMod = request.getParameter("VEH_MODEL"),
               carBrand = request.getParameter("VEH_BRAND"),
               carOwner = request.getParameter("VEH_OWNER");
        int age = 0,
            ageB = 0;
        if(request.getParameter("HO_AGE") != null) {
            age = Integer.parseInt(request.getParameter("HO_AGE"));
        }
        if(request.getParameter("HO_AGE_B") != null) {
            ageB = Integer.parseInt(request.getParameter("HO_AGE_B"));
        }
        
        System.out.println("Page 1 \nDetails: \nName: " + lastName + firstName + middleIni + "\nDate: " + date + "\nAddress: " + address
        + "\nAge: " + age + "");
        System.out.println("Page 6: \nDetails: \nPlate No: " + plateNo + "\nCar Type: " + carType + "\nModel: " + carMod + "\nBrand: " + carBrand + "\nOwner: " + carOwner);
        response.sendRedirect("signup-homeowners.jsp");
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
