<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Homeowner Signup</title>
        <link rel="icon" type="image/x-icon" href="images/khaicon.png"/>
        <link href="css/main-format.css" rel="stylesheet"/>
        <link href="css/form-format.css" rel="stylesheet"/>
        <link href="css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-big">
                <div class="step-row">
                    <div id="progress"></div>
                    <div class="step-col">Step 1</div>
                    <div class="step-col">Step 2</div>
                    <div class="step-col">Step 3</div>
                    <div class="step-col">Step 4</div>
                </div>
                <form id='form1'>
                    <h1 class="h1-bold">Homeowner Information</h1>
                        <label for="HO_LN">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                        <label for="HO_FN">First Name</label><input type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                        <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE">Age</label><br>
                        <input type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin"><input type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                        <label for="HO_ADDRESS">Resident Classification</label><input type="text" name="HO_ADDRESS" placeholder="Select Classification"  class="form"><br>
                        <label for="HO_ADDRESS">Address In Kingsville</label><input type="text" name="HO_ADDRESS" placeholder="Address(House No., Street)"  class="form"><br>
                        <label for="HO_DATE">Date Home Property Was Occupied</label><input type="date" name="HO_DATE" id=""  class="form">
                        <br><br><br>
                        <div class="button-container">
                            <input id="Next1" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                            <input class="button-design-reject" type="button" value="Cancel" id="button-small">
                        </div>
                </form>
                
                <form id='form2'>
                    <h1 class="h1-bold">Homeowner Contact Information</h1>
                        <label for="HO_EMAIL">Email Address</label><input type="text" name="HO_EMAIL" placeholder="Email Address" required class="form"><br>
                        <label for="HO_CONTACTNUM">Landline/Mobile Number</label><input type="text" name="HO_CONTACTNUM" placeholder="Phone Number" required class="form"><br>
                        <br><br><br><br><br><br><br><br><br><br><br><br><br>
                        <div class="button-container">
                            <input id="Next2" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                            <input id="Back2" class="button-design-reject" type="button" value="Back">
                        </div>
                    <br>
                </form>  
                             
                <form id="form3">
                    <h1 class="h1-bold">Lot/Property Information</h1>
                    
                        <p>Title Information</p><br>
                        <label for="TIT_NUM" id="label-margin-medium">Title No.</label><label for="TIT_NAME" style="margin-left: 7.1%;">Registered Name</label><br>
                        <input type="text" name="TIT_NUM" placeholder="Title No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_NAME" placeholder="Full Name" required class="form-medium"><br>
                        <label for="TIT_SURNOM" id="label-margin-medium">Survey No.</label><label for="TIT_LOTNUM" style="margin-left: 2.5%;">Lot No.</label><br>
                        <input type="text" name="TIT_SURNOM" placeholder="Survey No." class="form-medium" id="form-margin-medium"><input type="text" name="TIT_LOTNUM" placeholder="Lot No." required class="form-medium"><br>
                        <label for="TIT_DATE" id="label-margin-medium">Date Registered</label><label for="TIT_AREA" style="margin-left: -6%;">Area</label><br>
                        <input type="date" name="TIT_DATE" class="form-medium" id="form-margin-medium"><input type="text" name="TIT_AREA" placeholder="Area" required class="form-medium"><br>
                        <p>Tax Declaration Information</p><br>
                        <label for="TAX_NUM" id="label-margin-medium">Tax Declaration No.</label><label for="PRP_INDEX" style="margin-left: -12.2%;">Property Index No.</label><br>
                        <input type="text" name="TAX_NUM" placeholder="Tax Declaration No." class="form-medium" id="form-margin-medium"><input type="text" name="PRP_INDEX" placeholder="Property Index No." required class="form-medium"><br>
                        <br><br><br>
                                    <div class="button-container">
                        <input id="Next3" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                        <input id="Back3" class="button-design-reject" type="button" value="Back">
                    </div>
                </form>
                
                <form id="form4">
                    <h1 class="h1-bold">Lot/Property Information (Cont.)</h1>
                        <p>KHA Membership</p><br>
                        <label for="HO_MI" id="label-margin-medium">Paid Membership Fee?</label><label for="HO_AGE" style="margin-left: -17%;">If paid, input date:</label><br>
                    <fieldset>  
                        <label for="PAID_YES"><input type="radio" name="PAID_MEM" id="PAID_YES" value="yes">Yes</label>
                        <label for="PAID_NO" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PAID_NO" value="no" style="margin-left: 2%;">No</label>
                        <input type="date" name="PAID_DATE" placeholder="" required style="margin-left: 21.4%;">
                    </fieldset><br>
                        <label for="MEM_NAME">Name Used in Membership</label><input type="text" name="MEM_NAME" placeholder="Full Name" required class="form"><br>
                        <p>Use of Property</p><br>
                    <fieldset>  
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_RES" value="yes">Residential</label>
                        <label for="PRP_USE"><input type="radio" name="PAID_MEM" id="PRP_BUS" value="no">Business</label>
                        <label for="PRP_USE" id="form-margin-medium"><input type="radio" name="PAID_MEM" id="PRP_BOTH" value="no">Both</label>
                    </fieldset><br>
                        <label for="BUS_NAME">If used for business, registered name of business:</label><input type="text" name="BUS_NAME" placeholder="Business Name" required class="form"><br>
                        <label for="BUS_TYPE">Type of business:</label><input type="text" name="BUS_TYPE" placeholder="Business Type" required class="form"><br>
                    <br>
                    <div class="button-container">
                        <input id="Next4" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                        <input id="Back4" class="button-design-reject" type="button" value="Back">
                    </div>
                    <br>
                </form>
                
            </div>
        </div>
        <script>
            var form1 = document.getElementById("form1");
            var form2 = document.getElementById("form2");
            var form3 = document.getElementById("form3");
            var form4 = document.getElementById("form4");
            
            var Next1 = document.getElementById("Next1");
            var Back1 = document.getElementById("Back1");
            var Next2 = document.getElementById("Next2");
            var Back2 = document.getElementById("Back2");
            var Next3 = document.getElementById("Next3");
            var Back3 = document.getElementById("Back3");
            var Next4 = document.getElementById("Next4");
            var Back4 = document.getElementById("Back4");
            
            Next1.onclick = function(){
                form1.style.left = "-1000px";
                form2.style.left = "32.5%";
                progress.style.width = "50%";
            }
            
            Back2.onclick = function(){
                form1.style.left = "32.5%";
                form2.style.left = "1000px";
                progress.style.width = "25%";
            }
            
            Next2.onclick = function(){
                form2.style.left = "-1000px";
                form3.style.left = "32.5%";
                progress.style.width = "75%";
            }
            
            Back3.onclick = function(){
                form2.style.left = "32.5%";
                form3.style.left = "1000px";
                progress.style.width = "50%";
            }
            
            Next3.onclick = function(){
                form3.style.left = "-1000px";
                form4.style.left = "32.5%";
                progress.style.width = "100%";
            }
            
            Back4.onclick = function(){
                form3.style.left = "32.5%";
                form4.style.left = "1000px";
                progress.style.width = "75%";
            }
            
            Next4.onclick = function(){
                form4.style.left = "-1000px";
                form5.style.left = "32.5%";
                progress.style.width = "100%";
            }
        </script>
    </body>
</html>