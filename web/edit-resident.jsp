<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Edit Resident</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <%            int act = Integer.parseInt(request.getParameter("act"));
            // 1 is add, 2 is edit
        %>
        <div class="main-body">
            <%
                if (act == 1) {
                    out.println(""
                            + "<div class=\"signup-box-smallest\">"
                            + "<form style=\"left: 32.5%;\" action=\"UpdateInfo\">"
                            + "<h1 class=\"h1-bold\" id=\"h1small\">Edit Residents</h1>"
                            + "<div class=\"line\"></div><br>"
                            + "<label for=\"HO_LN_B\">Last Name</label><input type=\"text\" name=\"HO_LN_B\" placeholder=\"Last Name\" class=\"form\" required><br>"
                            + "<label for=\"HO_FN_B\">First Name</label><input type=\"text\" name=\"HO_FN_B\" placeholder=\"First Name\" class=\"form\" required><br>"
                            + "<label for=\"HO_MI_B\" id=\"label-margin\">Middle Initial</label><br>"
                            + "<input type=\"text\" name=\"HO_MI_B\" placeholder=\"Middle Initial\" class=\"form-small\" id=\"form-margin\" required><br>"
                            + "<label for=\"RES_REL\">Relationship with Resident</label>"
                            + "<select name=\"RES_REL\" class=\"form\" required>"
                            + "<option value=\"\" selected></option>"
                            + "<option value=\"Spouse\">Spouse</option>"
                            + "<option value=\"Child\">Child</option>"
                            + "<option value=\"Grandchild\">Grandchild</option>"
                            + "<option value=\"Househelp\">Househelp</option>"
                            + "<option value=\"Renter\">Renter</option>"
                            + "<option value=\"Parent\">Parent</option>"
                            + "<option value=\"Friend\">Friend</option>"
                            + "</select>"
                            + "<br>"
                            + "<input type=\"hidden\" name=\"FORM_NO\" value=\"3\">"
                            + "<div class=\"button-container\">"
                            + "<input class=\"button-design\" type=\"submit\" value=\"Save\" id=\"button-small\" style=\"margin-right: 10%;\">"
                            + "<input class=\"button-design-reject\" value=\"Cancel\" id=\"button-small\" onclick=\"location.href = 'profile.jsp'\">"
                            + "</div>"
                            + "</form>"
                            + "</div>");
                }
                else if (act == 2) {
                System.out.print("ACT = " + act);
                    Connection con = null;
                    ResultSet rs = null;
                    PreparedStatement ps = null;
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
                        ps = con.prepareStatement("SELECT * FROM USEROTHER WHERE USERID = ?");
                        ps.setString(1, (String) session.getAttribute("currID"));
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            out.println(""
                            + "<div class=\"signup-box-smallest\">"
                            + "<form style=\"left: 32.5%;\">"
                            + "<h1 class=\"h1-bold\" id=\"h1small\">Edit Residents</h1>"
                            + "<div class=\"line\"></div><br>"
                            + "<label for=\"HO_LN_C\">Last Name</label><input type=\"text\" name=\"HO_LN_C\" placeholder=\"" + rs.getString("LASTNAME") + "\"class=\"form\" required><br>"
                            + "<label for=\"HO_FN_C\">First Name</label><input type=\"text\" name=\"HO_FN_C\" placeholder=\"" + rs.getString("FIRSTNAME") + "\"class=\"form\" required><br>"
                            + "<label for=\"HO_MI_C\" id=\"label-margin\">Middle Initial</label><br>"
                            + "<input type=\"text\" name=\"HO_MI_C\" placeholder=\"" + rs.getString("MIDDLEINITIAL") + "\"class=\"form-small\" id=\"form-margin\" required><br>"
                            + "<label for=\"RES_REL_C\">Relationship with Resident</label>"
                            + "<select name=\"RES_REL_C\" class=\"form\" required>"
                            + "<option value=\"\" selected></option>"
                            + "<option value=\"Spouse\">Spouse</option>"
                            + "<option value=\"Child\">Child</option>"
                            + "<option value=\"Grandchild\">Grandchild</option>"
                            + "<option value=\"Househelp\">Househelp</option>"
                            + "<option value=\"Renter\">Renter</option>"
                            + "<option value=\"Parent\">Parent</option>"
                            + "<option value=\"Friend\">Friend</option>"
                            + "</select>"
                            + "<br>"
                            + "<input type=\"hidden\" name=\"FORM_NO\" value=\"7\">"
                            + "<input type=\"hidden\" name=\"UOTHER_ID_C\" value=\"" + rs.getString("USERID") + "\">"
                            + "<div class=\"button-container\">"
                            + "<input class=\"button-design\" type=\"submit\" value=\"Save\" id=\"button-small\" style=\"margin-right: 10%;\">"
                            + "<input class=\"button-design-reject\" value=\"Cancel\" id=\"button-small\" onclick=\"location.href = 'profile.jsp'\">"
                            + "</div>"
                            + "</form>"
                            + "</div>");
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
            %>
            <!--                <form style="left: 32.5%;">
                                <h1 class="h1-bold" id="h1small">Edit Residents</h1>
                                <div class="line"></div><br>
                                <label for="HO_LN_B">Last Name</label><input type="text" name="HO_LN_B" placeholder="Last Name" class="form" required><br>
                                <label for="HO_FN_B">First Name</label><input type="text" name="HO_FN_B" placeholder="First Name" class="form" required><br>
                                <label for="HO_MI_B" id="label-margin">Middle Initial</label><label for="HO_AGE_B" class="marginAge">Age</label><br>
                                <input type="text" name="HO_MI_B" placeholder="Middle Initial" class="form-small" id="form-margin" required><input type="number" name="HO_AGE_B" placeholder="Age" min="1" max="200" class="form-small" required><br>
                                <label for="RES_REL">Relationship with Resident</label>
                                <select name="RES_REL" class="form" required>
                                    <option value="" selected></option>
                                    <option value="Spouse">Spouse</option>
                                    <option value="Child">Child</option>
                                    <option value="Grandchild">Grandchild</option>
                                    <option value="Househelp">Househelp</option>
                                    <option value="Renter">Renter</option>
                                    <option value="Parent">Parent</option>
                                    <option value="Friend">Friend</option>
                                </select>
                                <br>
                                <input type="hidden" name="FORM_NO" value="3">
                                <div class="button-container">
                                    <input class="button-design" type="submit" value="Save" id="button-small" style="margin-right: 10%;">
                                    <input class="button-design-reject" value="Cancel" id="button-small" onclick="location.href = 'profile.jsp'">
                                </div>
                            </form>  -->
        </div>
    </body>
</html>