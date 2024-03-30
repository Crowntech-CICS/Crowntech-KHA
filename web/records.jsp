<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KHA | Records</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png">
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/table-format.css" rel="stylesheet"/>
        <link href="css/records.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <br><br><br><br><br><br>
        <div style="margin:auto; margin-top: 5px; max-width: 1800px; margin-left: 3.2%">
            <form class="sortSearch" action="" style="display: inline-flex;">
                <input type="text" placeholder="Search.." name="search" style="width: 1225px;">
                <button type="submit" style="margin-left: -20.3%;"><i class="fa fa-search"></i></button>
            </form>
            <button class="openSortB" onclick="openForm()">Sort</button>
            <!-- The sorting form -->
            <div class="sortPopup" id="sortForm" style="display: none;">
                <form action="SortHandler" class="form-container" method="POST">
                    <button type="button" class="button-design-reject" id="button-small" onclick="closeForm()" style="width: 251px; margin-left: -11px; margin-top: -10px; height: 48px">Close</button>
                    <br><br>
                    <label>Sort By Status:</label><br>
                    <input type="radio" id="paid" name="status" value="true">
                    <label for="paid">Paid</label>
                    <input type="radio" id="unpaid" name="status" value="false">
                    <label for="unpaid">Unpaid</label><br><br>
                    <label for="area">Sort By Area:</label>
                    <select name="area" id="area">
                        <option value ="null">-----</option>
                        <option value="1">Area 1</option>
                        <option value="1A">Area 1A</option>
                        <option value="2">Area 2</option>
                        <option value="3">Area 3</option>
                        <option value="4">Area 4</option>
                        <option value="5">Area 5</option>
                        <option value="5A">Area 5A</option>
                        <option value="6">Area 6</option>
                        <option value="7">Area 7</option>
                        <option value="8">Area 8</option>
                        <option value="9">Area 9</option>
                        <option value="10">Area 10</option>
                        <option value="11E">Area 11 East</option>
                        <option value="11W">Area 11 West</option>
                    </select>
                    <br><br>
                    <button type="submit" class="button-design" id="button-small" style="width: 230px; height: 48px">Filter Results</button>
                </form>
            </div>
        </div>
        <br>
        <div class="recordsHolder">
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
                    <tr>
                        <td class="tableContentText">Eldric B. Basa</td>
                        <td class="tableContentText">Block 7 Lot 13 Q.C.VILLE Townhomes Culiat Quezon City</td>
                        <td class="tableContentText">0917 125 6277</td>
                        <td class="tableContentText">Homeowner</td>
                        <td class="tableContentText">Unpaid</td>
                    </tr>
                    <tr>
                        <td class="tableContentText">Eldric</td>
                        <td class="tableContentText">Block</td>
                        <td class="tableContentText">0917 125 6277</td>
                        <td class="tableContentText">Homeowner</td>
                        <td class="tableContentText">Unpaid</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <br><br>
        <div class="button-container">
            <button class="button-design">
                Update Record
            </button>
        </div>
        <script src="scripts/sorttable.js"></script>
        <script>
                        function openForm() {
                            document.getElementById("sortForm").style.display = "block";
                        }

                        function closeForm() {
                            document.getElementById("sortForm").style.display = "none";
                        }

                        function searchFunc() {
                            var input, filter, table, tr, td, i, txtValue;
                            input = document.getElementById("nameSearch");
                            filter = input.value.toUpperCase();
                            table = document.getElementById("displayTable");
                            tr = table.getElementsByTagName("tr");
                            for (i = 0; i < tr.length; i++) {
                                td = tr[i].getElementsByTagName("td")[0];
                                if (td) {
                                    txtValue = td.textContent || td.innerText;
                                    if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                        tr[i].style.display = "";
                                    } else {
                                        tr[i].style.display = "none";
                                    }
                                }
                            }
                        }
        </script>
    </body>
</html>