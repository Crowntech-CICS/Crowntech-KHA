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
            <form action="SortHandler" method="POST" style='display: inline-block;'>
                <select name="area" class="button-year-design">
                    <option value="null">Select Year</option>
                    <option value="2024">2024</option>
                    <option value="2025">2025</option>
                    <option value="2026">2026</option>
                    <option value="2027">2027</option>
                    <option value="2028">2028</option>
                    <option value="2029">2029</option>
                    <option value="2030">2030</option>
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
                        
                        
                        for(int i = 0 ; i < 12; i++){
                            if(i%2!=0){
                            out.print("<tr><td class=\"tableContentText\">" + Months[i] + "</td>");
                            out.print("<td class=\"tableContentText\">" + aPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText\">" + mPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText\">" + bPaid[i] + "</td></tr>");
                        }
                        else{
                            out.print("<tr><td class=\"tableContentText2\">" + Months[i] + "</td>");
                            out.print("<td class=\"tableContentText2\">" + aPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText2\">" + mPaid[i] + "</td>");
                            out.print("<td class=\"tableContentText2\">" + bPaid[i] + "</td></tr>");
                        }
                        
                        }
                    %>
                    
                    <tr>
                        <td class="tableContentText">Total Funds</td>
                        <td class="tableContentText">21800.0</td>
                        <td class="tableContentText">15900.0</td>
                        <td class="tableContentText">8400.0</td>
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
            <form action="ExportPDF">
                <button class="button-design" type="submit" id="button-small">
                    Export
                </button>
            </form>
            <form action="FinanceTrack">
                <button class="button-design" type="submit" id="button-small" style="margin-left: 20%;">
                    Refresh
                </button>
            </form>
        </div>
    </body>
</html>