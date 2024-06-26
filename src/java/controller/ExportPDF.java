/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import controller.auth.Login;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.itextpdf.text.Font;
import com.itextpdf.text.pdf.draw.LineSeparator;
import java.io.FileOutputStream;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
/**
 *
 * @author Joseph Robles
 */
public class ExportPDF extends HttpServlet {

    Connection con;
    
    public static String emailCreds;
    HttpSession session;
    String strSelYear;
    int selYear;
    
    
    private static Font catFont = new Font(Font.FontFamily.TIMES_ROMAN, 18,
            Font.BOLD);
    private static Font redFont = new Font(Font.FontFamily.TIMES_ROMAN, 12,
            Font.NORMAL, BaseColor.RED);
    private static Font subFont = new Font(Font.FontFamily.TIMES_ROMAN, 16,
            Font.BOLD);
    private static Font smallBold = new Font(Font.FontFamily.TIMES_ROMAN, 12,
            Font.BOLD);
    
    
    private static final BaseColor cellColor = new BaseColor(168,208,141,255);
    private static final BaseColor cellColor2 = new BaseColor(255,229,153,255);
    private static final BaseColor cellColor3 = new BaseColor(243,161,161,255);
    
    private static String[] months = {"January","February","March","April","May","June","July","August","September","October","November","December"};

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        long millis = System.currentTimeMillis();
        java.sql.Date curDate = new java.sql.Date(millis);
        Calendar cal = Calendar.getInstance();
        cal.setTime(curDate);
        this.strSelYear = request.getParameter("year");
        selYear = cal.get(Calendar.YEAR);
        System.out.println(strSelYear);
        if(strSelYear == null) selYear = cal.get(Calendar.YEAR);
        else selYear = Integer.parseInt(strSelYear);
        
        
        //Establish Connection
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
        
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition","attachment; filename=\"" + createFileName() + "\"");
        
        this.session = request.getSession();
        OutputStream out =  response.getOutputStream();
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, out);
            document.open();
            addMetaData(document);
//            addTitlePage(document);
            addContent(document);
            document.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            out.close();
        }
        
        try {
            PreparedStatement ps = con.prepareStatement("INSERT INTO LOGS(LOGID,USERID,\"ACTION\",\"TIME\",\"DATE\") VALUES (?,?,?,CURRENT TIME,CURRENT DATE)");
            ps.setString(1, UUID.randomUUID().toString().substring(0,8));
            ps.setString(2, (String) request.getSession().getAttribute("currID"));
            ps.setString(3, "Exported Monthly Dues Report.");
            ps.executeUpdate();
            ps.close();
        } catch (SQLException sqle) {
            System.out.println("SQLException OUT error occured - " + sqle.getMessage());
            response.sendError(500);
        }
        
        if(!response.isCommitted())
            response.sendRedirect("admin/finances.jsp");
    }
    
    private static void addMetaData(Document document) {
        document.addTitle("Kingsville Finance Report");
        document.addSubject(new Date().toString());
        document.addKeywords("Kingsville Homeowners Association, Finance, Report");
        document.addAuthor(System.getProperty("user.name"));
        document.addCreator(System.getProperty("user.name"));
    }
    
    private void addContent(Document document) throws DocumentException {
        Paragraph preface = new Paragraph();
        
        
        
        // We add one empty line
        addEmptyLine(preface, 1);
        // Lets write a big header
        preface.add(new Paragraph("Kingsville Homeowners Association", catFont));

        // Will create: Report generated by: _name, _date
        preface.add(new Paragraph(
                "Report generated by: " + System.getProperty("user.name") + ", " + new Date(), //$NON-NLS-1$ //$NON-NLS-2$ //$NON-NLS-3$
                smallBold));
        preface.add(new Paragraph(
                "HOA Monthly Income Statement for the Year " + selYear ,
                smallBold));
        preface.add(new Paragraph(
                "in PHP ",
                smallBold));
        LineSeparator l = new LineSeparator();
        addEmptyLine(preface, 1);
        document.add(preface);
        
        preface = new Paragraph("",smallBold);
        addEmptyLine(preface,1);
        
        document.add(l);
        
        document.add(preface);
        
        // add a table
        PdfPTable table = createTable1();
        document.add(table);
        document.add(preface);
        document.add(l);
        document.add(preface);
        table = createTable2();
        
        document.add(table);

    }

    private PdfPTable createTable1()
            throws BadElementException {
        PdfPTable table = new PdfPTable(4);

        double totalMA[] = (double[])session.getAttribute("memPaid");
        double totalMF[] = (double[])session.getAttribute("monPaid");
        double totalBD[] = (double[])session.getAttribute("balPaid");
        double sumMA = 0;
        double sumMF = 0;
        double sumBD = 0;
        
        
        

        PdfPCell c1 = new PdfPCell(new Phrase("Month"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setBackgroundColor(cellColor);
        table.addCell(c1);

        c1 = new PdfPCell(new Phrase("Applications Fees"));
        c1.setBackgroundColor(cellColor);
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);

        c1 = new PdfPCell(new Phrase("Monthly Fees"));
        c1.setBackgroundColor(cellColor);
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        
        c1 = new PdfPCell(new Phrase("Balance Dues"));
        c1.setBackgroundColor(cellColor);
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        

        for(int i=0;i<12;i++){
            
        table.addCell(months[i]);
        table.addCell("₱"+String.valueOf(totalMA[i]));
        table.addCell("₱"+String.valueOf(totalMF[i]));
        table.addCell("₱"+String.valueOf(totalBD[i]));
        sumMA += totalMA[i];
        sumMF += totalMF[i];
        sumBD += totalBD[i];
        
        }
        table.addCell("Total Funds");
        table.addCell("₱"+String.valueOf(sumMA));
        table.addCell("₱"+String.valueOf(sumMF));
        table.addCell("₱"+String.valueOf(sumBD));

        c1 = new PdfPCell(new Phrase("Monthly Income"));
        c1.setBackgroundColor(cellColor);
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        

        return table;

    }
    
    private PdfPTable createTable2()
            throws BadElementException{
        PdfPTable table = new PdfPTable(2);
        
        String hoPaid = session.getAttribute("homeownerPaid").toString();
        String maPaid = session.getAttribute("membershipPaid").toString();
        String lotPaid = session.getAttribute("lotPaid").toString();
        String hoTotal = session.getAttribute("homeownerTotal").toString();
        String maTotal = session.getAttribute("membershipTotal").toString();
        String lotTotal = session.getAttribute("lotTotal").toString();
        
        
        PdfPCell c1 = new PdfPCell(new Phrase("NUMBER OF PAID HOMEOWNERS"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setBackgroundColor(cellColor);
        table.addCell(c1);
        
        c1 = new PdfPCell(new Phrase(hoPaid +" / "+ hoTotal));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        
        c1 = new PdfPCell(new Phrase("NUMBER OF PAID MEMBERSHIPS"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setBackgroundColor(cellColor2);
        table.addCell(c1);
        
        c1 = new PdfPCell(new Phrase(maPaid +" / "+ maTotal));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        
        c1 = new PdfPCell(new Phrase("NUMBER OF PAID LOTS"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setBackgroundColor(cellColor3);
        table.addCell(c1);
        
        c1 = new PdfPCell(new Phrase(lotPaid +" / "+ lotTotal));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(c1);
        
        return table;
    }

    private static void createList(Section subCatPart) {
        List list = new List(true, false, 10);
        list.add(new ListItem("First point"));
        list.add(new ListItem("Second point"));
        list.add(new ListItem("Third point"));
        subCatPart.add(list);
    }

    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }
    
    private String createFileName(){
        String fileName;
        
        fileName = "Kingsville Finance Report " + selYear +": "+ System.getProperty("user.name") + ", " + new Date() + ".pdf";
        
        return fileName;
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

class FooterGenerator extends PdfPageEventHelper {
    private PdfTemplate pageTotal;
    protected BaseFont baseFont;
    public FooterGenerator() throws DocumentException {
        try {
            baseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }    
        
    @Override
    public void onOpenDocument(PdfWriter writer, Document document) {
        pageTotal = writer.getDirectContent().createTemplate(100, 100);
    }
    
    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        Font font = new Font(Font.FontFamily.HELVETICA, 12, Font.ITALIC);
        
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
        String dateFormat = dtf.format(LocalDateTime.now());
        
        PdfContentByte cb = writer.getDirectContent();
        ColumnText.showTextAligned(cb, Paragraph.ALIGN_LEFT, new Phrase(dateFormat + " Generated by: " + ExportPDF.emailCreds, font), 
                document.left(),
                document.bottom(), 0);
        
        cb.saveState();
        String text = "Page " + writer.getPageNumber() + " of ";
 
        float textSize = baseFont.getWidthPoint(text, 10);
         
        cb.beginText();
        cb.setFontAndSize(baseFont, 10);
        cb.setTextMatrix(document.right() - textSize - 40, document.bottom() - 5);
        cb.showText(text);
        cb.endText();
        cb.addTemplate(pageTotal, document.right() - 40, document.bottom() - 5);
        cb.restoreState();
    }
    
    @Override
    public void onCloseDocument(PdfWriter writer, Document document) {
        pageTotal.beginText();
        pageTotal.setFontAndSize(baseFont, 10);
        pageTotal.showText(String.valueOf(writer.getPageNumber()));
        pageTotal.endText();
    }
}

