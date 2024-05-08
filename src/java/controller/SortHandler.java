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
import javax.servlet.http.HttpSession;

/**
 *
 * @author ejlu1
 */
public class SortHandler extends HttpServlet {

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
            
        String  stat = request.getParameter("status"),
                area = request.getParameter("area");
        
        boolean sortDate;
       
        // Checking Form Inputs
        System.out.println(String.format("Status: %s || Area: %s",stat, area));
        try {
        if(area != null && stat != null && !area.equals("null")) {
            response.sendRedirect(request.getContextPath() + "/staff/records.jsp?find=AREA " + area + " " + stat);
        } else if(area != null && !area.equals("null")){
            response.sendRedirect(request.getContextPath() + "/staff/records.jsp?find=AREA " + area);
            System.out.println("Condition check: " + !area.equals("null"));
        } else if(stat != null) {
            response.sendRedirect(request.getContextPath() + "/staff/records.jsp?find= " + stat);
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/records.jsp");
        }
        } catch(IllegalStateException ise) {
            System.out.println("IllegalStateException: " + ise.getMessage());
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

}
