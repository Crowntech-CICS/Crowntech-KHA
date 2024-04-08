<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Expires", "0");
    //Check Logged In State
    boolean logState = session.getAttribute("username") != null ? true : false;
    if (!logState) {
        response.sendRedirect("../login/login.jsp");
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width">
        <title>KHA | Signup</title>
        <link rel="icon" type="image/x-icon" href="../images/khaicon.png"/>
        <link href="../css/main-format.css" rel="stylesheet"/>
        <link href="../css/form-format.css" rel="stylesheet"/>
        <link href="../css/navbar.css" rel="stylesheet"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="main-body">
            <div class="signup-box-small">
                <div class="step-row">
                    <div id="progressSignup"></div>
                    <div class="step-col-signup">Personal Info.</div>
                    <div class="step-col-signup">Other Info.</div>
                    <div class="step-col-signup">Confirm</div>
                    <div class="step-col-signup">Complete!</div>
                </div>
                <form id='form1' action="Signup"  method="POST">
                    <h1 class="h1-bold">Personal Information</h1>
                    <div class="line"></div><br>
                    <label for="HO_LN">Last Name</label>
                    <input type="text" id="LN1" onChange="document.form2.HO_LN.value = this.value" placeholder="ex. Smith" class="form" required><br>
                    <label for="HO_FN">First Name</label>
                    <input type="text" id="FN1" onChange="document.form2.HO_FN.value = this.value" placeholder="ex. John" class="form" required><br>
                    <label for="HO_MI" id="label-margin">Middle Initial</label><br>
                    <input type="text" id="MI1" onChange="document.form2.HO_MI.value = this.value" placeholder="ex. A." class="form-small" id="form-margin" required><br>
                    <label for="HO_EMAIL">Email Address</label>
                    <input type="text" id="EMAIL1" onChange="document.form2.HO_EMAIL.value = this.value" placeholder="ex. johnsmith@email.com" required class="form" required>
                    <br><br>
                    <div class="button-container">
                        <input class="button-design-reject" type="button" value="Cancel" id="button-small" style="margin-right: 10%;">
                        <input id="Next1" class="button-design" type="button" value="Next">
                    </div>
                </form>

                <form id='form2' name="form2" action="Signup"  method="POST" enctype="multipart/form-data">
                    <input type="hidden" name="HO_LN" class="form">
                    <input type="hidden" name="HO_FN" class="form">
                    <input type="hidden" name="HO_MI" class="form">
                    <input type="hidden" name="HO_EMAIL" class="form">
                    <h1 class="h1-bold">Other Information</h1>
                    <div class="line"></div><br>
                    <div class="upload_files" id="form_container" class="form_input_title">
                        <p style="text-align: center; color: black;">Upload Digital Copy of Required Documents:</p>
                        <p style="text-align: center; color: black;">(1) Official Receipt</p><br>
                        <input type="file" id="FILE_UPLOAD1" class="file_button" name="FILES_UPLOAD" id="input-none" accept="image/*,.pdf" multiple style="margin-left: 33%; border:none;" required>
                    </div>
                    <br><br><br><br><br><br><br><br><br>
                    <div class="button-container">
                        <input id="Back2" class="button-design-reject" type="button" value="Back" style="margin-right: 10%;">
                        <input id="Next2" class="button-design" type="button" value="Next">
                    </div>
                    <br>
                </form>  

                <form id='form3'>
                    <h1 class="h1-bold">Registration Confirmation</h1>
                    <div class="line"></div><br>
                    <p style="color: black;">Your registration is now ready for submission. Kindly recheck your response before submitting.</p>
                    <br><br><br><br>
                    <div class="button-container">
                        <input id="Back3" class="button-design-reject" type="button" value="Back" style="margin-right: 10%;">
                        <input id="Next3" class="button-design" type="button" value="Submit">
                    </div>
                    <br>
                </form>  
                
                <form id='form4'>
                    <h1 class="h1-bold">Registration Complete</h1>
                    <div class="line"></div><br>
                    <p style="color: black;">Your registration is now being processed. For any further questions and concerns, ask for staff assistance, thank you!</p>
                    <br><br><br><br>
                    <div class="button-container">
                        <input id="Next3" class="button-design" type="button" onClick="document.form2.submit()" value="Go Back">
                    </div>
                    <br>
                </form>  
            </div>
        </div>
        <script>
            var form1 = document.getElementById("form1");
            var form2 = document.getElementById("form2");
            var form3 = document.getElementById("form3");

            var Next1 = document.getElementById("Next1");
            var Back1 = document.getElementById("Back1");
            var Next2 = document.getElementById("Next2");
            var Back2 = document.getElementById("Back2");
            var Next3 = document.getElementById("Next3");
            var Back3 = document.getElementById("Back3");
            var Next4 = document.getElementById("Next4");
            var Back4 = document.getElementById("Back4");
            
            //First text form next button
            Next1.onclick = function () {
                if(document.getElementById("LN1").value !== ""){
                    if(document.getElementById("FN1").value !== ""){
                        if(document.getElementById("MI1").value !== ""){
                            if(document.getElementById("EMAIL1").value !== ""){
                                form1.style.left = "-1000px";
                                form2.style.left = "32.5%";
                                progressSignup.style.width = "50%";
                            } else {
                                alert("Fill in the Email Field.");
                            }
                        } else {
                            alert("Fill in the Middle Initial Field.");
                        }
                    } else {
                        alert("Fill in the First Name Field.");
                    }
                } else {
                    alert("Fill in the Last Name Field.");
                }
            };

            Back2.onclick = function () {
                form1.style.left = "32.5%";
                form2.style.left = "1000px";
                progressSignup.style.width = "25%";             
            };
            //File upload form next button
            Next2.onclick = function () {
                if(document.getElementById("FILE_UPLOAD1").files.length !== 0){
                    form2.style.left = "-1000px";
                    form3.style.left = "32.5%";
                    progressSignup.style.width = "75%";
                } else {
                    alert("Please upload the required file.");
                }
            };

            Back3.onclick = function () {
                form2.style.left = "32.5%";
                form3.style.left = "1000px";
                progressSignup.style.width = "50%";
            };

            Next3.onclick = function () {
                form3.style.left = "-1000px";
                form4.style.left = "32.5%";
                progressSignup.style.width = "100%";
            };

            Back4.onclick = function () {
                form3.style.left = "32.5%";
                form4.style.left = "1000px";
                progressSignup.style.width = "75%";
            };
        </script>
    </body>
</html>