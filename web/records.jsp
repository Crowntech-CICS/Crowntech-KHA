<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Current Members</title>
        <link href="css/records.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div>
            <form>
                <img src="images/SearchIcon.png" class="searchIcon">
                <input type="text" placeholder="Search" class="searchBar">
                <input type="button" hidden />
            </form>
        </div>
        <div class="greetingBanner">
	<table class="tableContent">
        <thead>
		<tr>
                    <th class="tableTitle">Name</th>
                    <th class="tableTitle">Address</th>
                    <th class="tableTitle">Contact Number</th>
                    <th class="tableTitle">Status</th>
                    <th class="tableTitle">Paid</th>
		</tr>
         </thead>
         <tbody>
		
         </tbody>
	</table>
        </div>
    </body>
</html>
