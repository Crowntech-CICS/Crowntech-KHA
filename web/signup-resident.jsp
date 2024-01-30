<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="header.css">
    <link rel="stylesheet" href="form.css">
    <link href="css/form.css" rel="stylesheet"/>
    <link href="css/navbar.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans"">
    <title>Resident Registration Form | Kingsville Homeowner Association</title>
</head>
<body>
    <header>
        <nav> 
            <a href="."><img src="images/khalogo.png" class="logo"></a>
        </nav>
    </header>
    <h1 class="center">Resident Registration</h1>
    <div class="form-box-lessee">
    <form action="">
        <div class="basic_info" id="form_container">
            <h1>Resident Information</h1><br>
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
            <h1>Resident Contact Information</h1><br>
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
            <h1>Homeowner Information</h1>
            <p>(Information about the owner of the property/lot)</p><br>
            <h2>Homeowner</h2>
            <div class="input_grid">
                <label for="HO_LN" id="form_input_title">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="login-form"><br>
                <label for="HO_FN" id="form_input_title">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="login-form"><br>
                <label for="HO_MI" id="form_input_title-md">Middle Initial</label>
                <input type="text" name="HO_MI" placeholder="Middle Initial" class="login-md-form"><br>
                <label for="HO_ADDRESS" id="form_input_title">Email Address</label><input type="text" name="HO_ADDRESS" placeholder="Email Address" required class="login-form"><br>
                <label for="HO_ADDRESS" id="form_input_title">Landline/Mobile No.</label><input type="text" name="HO_ADDRESS" placeholder="Phone Number" required class="login-form"><br>
                <label for="HO_DATE" id="form_input_title">Current Address</label><input type="text" name="HO_ADDRESS" placeholder="Address" required class="login-form">  
            </div>
            
            <h2>Representative/Caretaker</h2>
            <div class="input_grid">
                <label for="HO_LN" id="form_input_title">Last Name</label><input type="text" name="HO_LN" placeholder="Last Name" required class="login-form"><br>
                <label for="HO_FN" id="form_input_title">First Name</label><input type="text" name="HO_FN" placeholder="First Name" required class="login-form"><br>
                <label for="HO_MI" id="form_input_title-md">Middle Initial</label>
                <input type="text" name="HO_MI" placeholder="Middle Initial" class="login-md-form"><br>
                <label for="HO_ADDRESS" id="form_input_title">Email Address</label><input type="text" name="HO_ADDRESS" placeholder="Email Address" required class="login-form"><br>
                <label for="HO_ADDRESS" id="form_input_title">Landline/Mobile No.</label><input type="text" name="HO_ADDRESS" placeholder="Phone Number" required class="login-form"><br>
            </div>
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

</style>
</html>