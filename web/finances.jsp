<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("login.jsp");
    } else if (!session.getAttribute("level").equals("admin") && !session.getAttribute("level").equals("staff")) {
        response.sendRedirect("index.jsp");
    }
%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Finances</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br><br>
        <div class="financeButtonSpacing">
            <form name="form1" action="FinanceTrack" method="POST" style='display: inline-block;'>
                <select name="year" class="button-year-design" onchange="javascript:document.form1.submit()">
                    <option value="" selected disabled hidden>Select Year</option>
                    <option value="2024">2024</option>
                    <option value="2023">2023</option>
                    <option value="2022">2022</option>
                    <option value="2021">2021</option>
                    <option value="2007">2007</option>
                    <option value="2016">2016</option>
                    <option value="1988">1988</option>
                </select>
            </form>
        </div>
        <br>
        <div class="financeHolder">
            <table class="tableContent" id="financesLeft">
                <thead>
                    <tr>
                        <th class="tableTitle">Month</th>
                        <th class="tableTitle">Application Fees</th>
                        <th class="tableTitle">Monthly Fees</th>
                        <th class="tableTitle">Balance Dues</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        
                        String Months[] = {"January","February","March","April","May","June","July","August","September","October","November","December"};
                        double aPaid[] = (double[])session.getAttribute("memPaid");
                        double mPaid[] = (double[])session.getAttribute("monPaid");
                        double bPaid[] = (double[])session.getAttribute("balPaid");
                        
                        double aTotal=0;
                        double mTotal=0;
                        double bTotal=0;
                        
                        
                        
                        
                        for(int i = 0 ; i < 12; i++){
                            if(i%2!=0){
                            out.print("<tr><td class=\"tableContentText\">" + Months[i] + "</td>");
                            out.print("<td class=\"tableContentText\">₱" + aPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText\">₱" + mPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText\">₱" + bPaid[i] + "</td></tr>");
                            
                            
                        }
                        else{
                            out.print("<tr><td class=\"tableContentText2\">" + Months[i] + "</td>");
                            out.print("<td class=\"tableContentText2\">₱" + aPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText2\">₱" + mPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText2\">₱" + bPaid[i] + "</td></tr>");
                        }
                            aTotal+=aPaid[i];
                            mTotal+=mPaid[i];
                            bTotal+=bPaid[i];
                            
                            session.setAttribute("aTotal",aTotal);
                            session.setAttribute("mTotal",mTotal);
                            session.setAttribute("bTotal",bTotal);
                        }
                    %>
                    
                    <tr>
                        <td class="tableContentText">Total Funds</td>
                        <td class="tableContentText">₱${aTotal}</td>
                        <td class="tableContentText">₱${mTotal}</td>
                        <td class="tableContentText">₱${bTotal}</td>
                    </tr>
                </tbody>
            </table>
           
            <table class="tableContentR" id="financesRight">
                <tr><td class="tableContentText3">Number of Paid Homeowners: <br><p class="financesP">${homeownerPaid}/${homeownerTotal}</p></td></tr>
                <tr><td class="tableContentText4">Number of Paid Memberships: <br><p class="financesP">${membershipPaid}/${membershipTotal}</p></td></tr>
                <tr><td class="tableContentText5">Number of Paid Lots: <br><p class="financesP">${lotPaid}/${lotTotal}</p></td></tr>
            </table>
        </div>
        <br><br>
        <div class="button-container">
            <form action="FinanceTrack">
                <button class="button-design" type="submit" id="button-small" >
                    Refresh
                </button>
            </form>
            <form action="ExportPDF">
                <button class="button-design" type="submit" id="button-small" style="margin-left: 20%;">
                    Export
                </button>
            </form>
        </div>
    </body>
</html>