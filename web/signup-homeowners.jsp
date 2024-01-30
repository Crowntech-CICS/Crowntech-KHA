<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="header.css">
    <!--<link rel="stylesheet" href="form.css">-->
    <link href="css/form.css" rel="stylesheet"/>
    <link href="css/navbar.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans"">
    <title>Homeowner Registration Form | Kingsville Homeowner Association</title>
</head>
<body>
    <header>
        <nav> 
            <a href="."><img src="images/khalogo.png" class="logo"></a>
        </nav>
    </header>
    <h1 class="center">Homeowner Registration</h1>
    <div class="form-box-homeowner">
    <form action="">
        <div class="basic_info" id="form_container">
            <h1>Homeowner Information</h1><br>
            <label for="HO_LN" id="form_input_title">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="login-form"><br>
            <label for="HO_FN" id="form_input_title">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="login-form"><br>
            <label for="HO_MI" id="form_input_title-md">Middle Initial</label><label for="HO_AGE" id="form_input_title">Age</label>
            <input type="text" name="HO_MI" placeholder="Middle Initial" class="login-md-form">
            <input type="number" name="HO_AGE" placeholder="Age" min="1" max="200" required class="login-age-form"><br>
            <label for="HO_ADDRESS" id="form_input_title">Resident Classification</label><input type="text" name="HO_ADDRESS" placeholder="Select Classification" required class="login-form"><br>
            <label for="HO_ADDRESS" id="form_input_title">Address In Kingsville</label><input type="text" name="HO_ADDRESS" placeholder="Address(House No., Street)" required class="login-form"><br>
            <label for="HO_DATE" id="form_input_title">Date Home Property Was Occupied</label><input type="date" name="HO_DATE" id="" required class="login-form">    
        </div>
        <div class="contact_info" id="form_container">
            <h1>Homeowner Contact Information</h1><br>
            <label for="HO_EMAIL" id="form_input_title">Email Address</label><input type="email" name="HO_EMAIL" placeholder="Email Address" required class="login-form">
            <label for="HO_CONTACTNUM" id="form_input_title">Landline/Mobile Number</label><input type="text" name="HO_CONTACTNUM" placeholder="Phone Number" required class="login-form">
        </div>
        <div class="residents" id="form_container">
            <h1>Other Persons Staying in the Home Property</h1><br>
            <label for="HO_LN" id="form_input_title">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="login-form"><br>
            <label for="HO_FN" id="form_input_title">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="login-form"><br>
            <label for="HO_MI" id="form_input_title-md">Middle Initial</label><label for="HO_AGE" id="form_input_title">Age:</label>
            <input type="text" name="HO_MI" placeholder="Middle Initial" class="login-md-form">
            <input type="number" name="HO_AGE" placeholder="Age" min="1" max="200" required class="login-age-form">
            <label for="RES_REL" id="form_input_title">Relationship with Resident</label>
            <select name="RES_REL" id="" class="login-form">
                <option value="" selected>Relationship</option>
                <option value="">Spouse</option>
                <option value="">Son/Daughter</option>
                <option value="">Grandchild</option>
                <option value="">Househelp</option>
                <option value="">Renter</option>
                <option value="">Parent</option>
                <option value="">Friend</option>
            </select>
            <div class="add_more">
                <button class="res_add" onclick="">Add more</button>
            </div>   
        </div>
        <div class="lot_info" id="form_container">
            <h1>Lot/Property Information</h1>
            <h2>Title Information</h2>
            <div class="input_grid">
                <label for="TIT_NUM" id="form_input_title-titleno">Title No.</label><label for="TIT_NAME" id="form_input_title">Registered Name</label>
                <input type="text" name="TIT_NUM" placeholder="Title No." required class="login-lot-form">
                <input type="text" name="TIT_NAME" placeholder="Full Name" required class="login-lot-form">
                <label for="TIT_LOTNUM" id="form_input_title-survey">Survey No.</label><label for="TIT_LOTNUM" id="form_input_title">Lot No.</label>
                <input type="text" name="TIT_LOTNUM" placeholder="Survey No." required class="login-lot-form">
                <input type="text" name="TIT_LOTNUM" placeholder="Lot No." required class="login-lot-form"><br>
                <label for="TIT_DATE" id="form_input_title-datereg">Date Registered</label><label for="TIT_AREA" id="form_input_title">Area</label><br>
                <input type="date" name="TIT_DATE" placeholder="" required class="login-lot-form">
                <input type="number" name="TIT_AREA" placeholder="Area sq. m" min=1 required class="login-lot-form">
            </div>
            
            <h2>Tax Declaration Information</h2>
            <div class="input_grid">
                <label for="TAX_NUM" id="form_input_title-taxdec">Tax Declaration No.</label><label for="PRP_INDEX" id="form_input_title">Property Index No.</label>
                <input type="text" name="TAX_NUM" placeholder="Tax Declaration No." required class="login-lot-form">
                <input type="text" name="PRP_INDEX" placeholder="Property Index No." required class="login-lot-form">
            </div>
            
            <h2>KHA Membership</h2>
            <div class="input_grid">
                <label for="PAID_DATE"id="form_input_title-paidmember">Paid Membership Fee?</label><label for="PAID_DATE" id="form_input_title">If paid, date paid</label>
                <div class="input_grp">
                    <fieldset>  
                        <label for="PAID_YES" id="form_input_title-radiobutton"><input type="radio" name="PAID_MEM" id="PAID_YES" value="yes">Yes</label>
                        <label for="PAID_NO" id="form_input_title-radiobutton"><input type="radio" name="PAID_MEM" id="PAID_NO" value="no">No</label>
                        <input type="date" name="PAID_DATE" placeholder="" required class="login-lot-form-paid">
                    <fieldset>  
                </div>
            </div>
            <label for="MEM_NAME" id="form_input_title">Name used in Membership</label><input type="text" name="MEM_NAME" placeholder="Full Name" required class="login-form">
            
            <h2>Use of Property</h2>
            <fieldset>                      
                <label for="PRP_USE" id="form_input_title-radiobutton"><input type="radio" name="PAID_MEM" id="PRP_RES" value="residential">Residential</label>
                <label for="PRP_USE" id="form_input_title-radiobutton"><input type="radio" name="PAID_MEM" id="PRP_BUS" value="business">Business</label>
                <label for="PRP_USE" id="form_input_title-radiobutton"><input type="radio" name="PAID_MEM" id="PRP_BOTH" value="both">Both</label>
            </fieldset><br>
            <label for="BUS_NAME" id="form_input_title">If used for business, registered name of business:</label><input type="text" name="BUS_NAME" placeholder="Business Name" required class="login-form"><br>
            <label for="BUS_TYPE" id="form_input_title">Type of business:</label><input type="text" name="BUS_TYPE" placeholder="Business Type" required class="login-form">
            
        </div>
        
        <div class="vehicle_info" id="form_container">
            <h1>Vehicle Information</h1>
            <div class="input_grid">
                <label for="VEH_PLATE" id="form_input_title-plate">Plate No.</label><label for="VEH_TYPE" id="form_input_title">Type of Vehicle</label><br>
                <input type="text" name="VEH_PLATE" placeholder="Plate No." required class="login-lot-form">
                <input type="text" name="VEH_TYPE" placeholder="Type of Vehicle." required class="login-lot-form">
                <label for="VEH_BRAND" id="form_input_title-brand">Brand</label><label for="VEH_MODEL" id="form_input_title">Year/Model</label><br>
                <input type="text" name="VEH_BRAND" placeholder="Brand" required class="login-lot-form">
                <input type="text" name="VEH_MODEL" placeholder="Year/Model" required class="login-lot-form">
            </div>
            <label for="BUS_NAME" id="form_input_title">Registered Owner</label><input type="text" name="BUS_NAME" placeholder="Business Name" required class="login-form">
            <div class="add_more">
                <button class="res_add" onclick="">Add more</button>
            </div>   
        </div>
        <div class="upload_files" id="form_container" class="form_input_title">
            <p>Upload Digital Copy of Required Documents</p>
            <input type="file" class="file_button" name="FILES_UPLOAD" id="" accept="image/*,.pdf" multiple>
        </div>
        <input type="submit" class="button-design" value="Apply">
    </form>
    </div>
</body>
<style>
    * {
        margin: 0;
        font-family: "Noto Sans";
    }
    body {
        background-color: #939992;
    }
    .center {
        text-align:center;
        font-size: 2.5rem;
    }
</style>
</html>
