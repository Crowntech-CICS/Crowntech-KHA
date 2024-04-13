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
            <div class="signup-box-big" style="overflow-y: auto">
                <div class="step-row">
                    <div id="progress"></div>
                    <div class="step-col">Step 1</div>
                    <div class="step-col">Step 2</div>
                    <div class="step-col">Step 3</div>
                    <div class="step-col">Step 4</div>
                </div>
                <form id='form1'>
                    <h1 class="h1-bold">Homeowner Information</h1>
                        <label for="HO_LN">Last Name</label><input onchange="finalForm.HO_LN.value = this.value" type="text" name="HO_LN" placeholder="Last Name" class="form"><br>
                        <label for="HO_FN">First Name</label><input onchange="finalForm.HO_FN.value = this.value" type="text" name="HO_FN" placeholder="First Name" class="form"><br>
                        <label for="HO_MI" id="label-margin">Middle Initial</label><label for="HO_AGE">Age</label>
                        <input onchange="finalForm.HO_MI.value = this.value"type="text" name="HO_MI" placeholder="Middle Initial" class="form-small" id="form-margin">
                        <input onchange="finalForm.HO_AGE.value = this.value" type="number" name="HO_AGE" placeholder="Age" min="1" max="200"  class="form-small"><br>
                        <label for="HO_HOUSENUM">HOUSE NO</label><input onchange="finalForm.HO_HOUSENUM.value = this.value" type="text" name="HO_ADDRESS" placeholder="Address"  class="form"><br>
                        <label for="HO_STREET">STREET</label><input onchange="finalForm.HO_STREET.value = this.value" type="text" name="HO_ADDRESS" placeholder="Address"  class="form"><br>
                        <label for="HO_VILLAGE">VILLAGE</label><input onchange="finalForm.HO_VILLAGE.value = this.value" type="text" name="HO_ADDRESS" placeholder="Address"  class="form"><br>
                        <label for="HO_BARANGAY">BARANGAY</label><input onchange="finalForm.HO_BARANGAY.value = this.value" type="text" name="HO_ADDRESS" placeholder="Address"  class="form"><br>
                        <label for="HO_CITY">CITY</label><input onchange="finalForm.HO_CITY.value = this.value" type="text" name="HO_ADDRESS" placeholder="Address"  class="form"><br>
                        <label for="HO_PROVINCE">PROVINCE</label><input onchange="finalForm.HO_PROVINCE.value = this.value" type="text" name="HO_ADDRESS" placeholder="Address"  class="form"><br>
                        <label for="HO_DATE">Date Home Property Was Occupied</label><input onchange="finalForm.HO_DATE.value = this.value" type="date" name="HO_DATE" id=""  class="form">
                        <br><br><br>
                        <div class="button-container">
                            <input id="Next1" class="button-design" type="button" value="Next" style="margin-right: 10%;">
                            <input class="button-design-reject" type="button" value="Cancel" id="button-small">
                        </div>
                </form>
                
                <form id='form2'>
                    <h1 class="h1-bold">Homeowner Contact Information</h1>
                        <label for="HO_EMAIL">Email Address</label><input onchange="finalForm.HO_EMAIL.value = this.value" type="text" name="HO_EMAIL" placeholder="Email Address" required class="form"><br>
                        <label for="HO_LANDLINE">Landline Number</label><input onchange="finalForm.HO_LANDLINE.value = this.value" type="text" name="HO_LANDLINE" placeholder="Landline Number" required class="form"><br>
                        <label for="HO_PHONE">Mobile Number</label><input onchange="finalForm.HO_PHONE.value = this.value" type="text" name="HO_PHONE" placeholder="Phone Number" required class="form"><br>
                        <br><br><br><br><br><br><br><br><br><br>
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
                        <input onchange="finalForm.TIT_NUM.value = this.value" type="text" name="TIT_NUM" placeholder="Title No." class="form-medium" id="form-margin-medium">
                        <input onchange="finalForm.TIT_NAME.value = this.value" type="text" name="TIT_NAME" placeholder="Full Name" required class="form-medium"><br>
                        <label for="TIT_SURNOM" id="label-margin-medium">Survey No.</label><label for="TIT_LOTNUM" style="margin-left: 2.5%;">Lot No.</label><br>
                        <input onchange="finalForm.TIT_SURNUM.value = this.value" type="text" name="TIT_SURNOM" placeholder="Survey No." class="form-medium" id="form-margin-medium">
                        <input onchange="finalForm.TIT_LOTNUM.value = this.value" type="text" name="TIT_LOTNUM" placeholder="Lot No." required class="form-medium"><br>
                        <label for="TIT_DATE" id="label-margin-medium">Date Registered</label><label for="TIT_AREA" style="margin-left: -6%;">Area</label><br>
                        <input onchange="finalForm.TIT_DATE.value = this.value" type="date" name="TIT_DATE" class="form-medium" id="form-margin-medium">
                        <input onchange="finalForm.TIT_AREA.value = this.value" type="text" name="TIT_AREA" placeholder="Area" required class="form-medium"><br>
                        <p>Tax Declaration Information</p><br>
                        <label for="TAX_NUM" id="label-margin-medium">Tax Declaration No.</label><label for="PRP_INDEX" style="margin-left: -12.2%;">Property Index No.</label><br>
                        <input onchange="finalForm.TAX_NUM.value = this.value" type="text" name="TAX_NUM" placeholder="Tax Declaration No." class="form-medium" id="form-margin-medium"><input type="text" name="PRP_INDEX" placeholder="Property Index No." required class="form-medium"><br>
                        
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
                        <label for="PAID_YES"><input onclick="finalForm.MEM_PAID.value = this.value" type="radio" name="PAID_MEM" id="PAID_YES" value="yes">Yes</label>
                        <label for="PAID_NO" id="form-margin-medium"><input  onclick="finalForm.MEM_PAID.value = this.value" type="radio" name="PAID_MEM" id="PAID_NO" value="no" style="margin-left: 2%;">No</label>
                        <input onchange="finalForm.MEM_PAID_DATE.value = this.value" type="date" name="PAID_DATE" placeholder="" required style="margin-left: 21.4%;">
                    </fieldset><br>
                        <label for="MEM_NAME">Name Used in Membership</label><input onchange="finalForm.MEM_NAME.value = this.value" type="text" name="MEM_NAME" placeholder="Full Name" required class="form"><br>
                        <label for="MEM_NAME">OR NUMBER</label><input onchange="finalForm.HO_ORNUM.value = this.value" type="text" name="OR_NUM" placeholder="OR NUM" required class="form"><br>
                        <p>Use of Property</p><br>
                    <fieldset>  
                        <label for="PRP_USE"><input onclick="finalForm.PRP_USE.value = this.value" type="radio" name="PRP_USE" id="PRP_RES" value="Residential">Residential</label>
                        <label for="PRP_USE"><input onclick="finalForm.PRP_USE.value = this.value" type="radio" name="PRP_USE" id="PRP_BUS" value="Business">Business</label>
                        <label for="PRP_USE" id="form-margin-medium"><input onclick="finalForm.PRP_USE.value = this.value" type="radio" name="PRP_USE" id="PRP_BOTH" value="Both">Both</label>
                    </fieldset><br>
                        <label for="BUS_NAME">If used for business, registered name of business:</label><input onchange="finalForm.BUS_NAME.value = this.value" type="text" name="BUS_NAME" placeholder="Business Name" required class="form"><br>
                        <label for="BUS_TYPE">Type of business:</label><input onchange="finalForm.BUS_TYPE.value = this.value" type="text" name="BUS_TYPE" placeholder="Business Type" required class="form"><br>
                    <br>
                    <div class="button-container">
                        <input id="Next4" class="button-design" type="button" value="Submit" style="margin-right: 10%;">
                        <input id="Back4" class="button-design-reject" type="button" value="Back">
                    </div>
                    <br>
                </form>
                                
                <form id="finalForm" action="CreateHomeowner" method="POST">
                    <input type="hidden" name="HO_LN"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_FN"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_MI"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_AGE"> <!-- USER -->
                    <input type="hidden" name="HO_ORNUM"> <!-- USER -->
                    <input type="hidden" name="HO_HOUSENUM"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_STREET"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_VILLAGE"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_BARANGAY"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_CITY"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_PROVINCE"> <!-- HOMEOWNER -->
                    <input type="hidden" name="HO_DATE"> <!-- USER -->
                    <input type="hidden" name="HO_EMAIL"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_LANDLINE"><!-- HOMEOWNER -->
                    <input type="hidden" name="HO_PHONE"><!-- HOMEOWNER -->
                    <input type="hidden" name="TIT_NUM"><!--USERLOT-->
                    <input type="hidden" name="TIT_SURNUM"><!--USERLOT-->
                    <input type="hidden" name="TIT_LOTNUM"><!--USERLOT-->
                    <input type="hidden" name="TIT_REGNAME"><!--USERLOT-->
                    <input type="hidden" name="TIT_DATE"><!--USERLOT-->
                    <input type="hidden" name="TIT_AREA"><!--USERLOT-->
                    <input type="hidden" name="PRP_INDEX"><!--TAXDECINFO-->
                    <input type="hidden" name="TAX_NUM"><!--TAXDECINFO-->
                    <input type="hidden" name="MEM_PAID"><!--KHAMEMBERSHIP-->
                    <input type="hidden" name="MEM_PAID_DATE"><!--KHAMEMBERSHIP-->
                    <input type="hidden" name="MEM_NAME"><!--KHAMEMBERSHIP-->
                    <input type="hidden" name="PRP_USE"><!--PROPERTYUSE-->
                    <input type="hidden" name="BUS_NAME"><!--PROPERTYUSE-->
                    <input type="hidden" name="BUS_TYPE"><!--PROPERTYUSE-->
                </form>
            </div>
        </div>
        <script>
            window.onload = function() {
                if(new URLSearchParams(window.location.search).get('suc') === 'true'){
                    alert('Successfully added Homeowner to the records.');
                    window.location.href = 'records.jsp';
                }
            };
            
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
                var form = document.getElementById('finalForm');
                
                if(confirm('Are you sure all the information are correct and want to submit this form?')){
                    form.submit();
                }
            };
            
            /*Next4.onclick = function(){
                form4.style.left = "-1000px";
                form5.style.left = "32.5%";
                progress.style.width = "100%";
            }*/
        </script>
    </body>
</html>