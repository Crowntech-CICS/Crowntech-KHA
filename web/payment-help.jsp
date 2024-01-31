<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Steps</title>
</head>
<body>
    <%@include file="navbar.jsp" %>
    <div class="center">
        <div class="method-box">
        <h1>How to pay Over the Counter</h1>
        <div class="line"></div>
        <p>Step 1. Go to the KHA Office in the subdivision clubhouse</p>
        <p>Step 2. Ask for your current balance through the counter</p>
        <p>Step 3. Pay the amount through cash</p>
        <p>Step 4. Wait for your receipt</p>
        <p>Step 5. DONE!</p>
    </div>
    <div class="method-box">
        <h1>How to pay using Bank Transfer</h1>
        <div class="line"></div>
        <p>Step 1. Log into your bank's website or connect via the bank's app.</p>
        <p>Step 2. Click on the transfer feature and choose transfer to another bank.</p>
        <p>Step 3. Enter the routing and account numbers for the account at the other bank.</p>
        <p>Step 4. Make the transfer.</p>
        <p>Step 5. Your bank may require verification that you are the owner of the other account. The transfer likely will take one to two days or maybe more if verification is needed.</p>
        <p>Step 6. DONE!</p>
    </div>
    </div>
    
</body>
<style>
    body{
        background-color: #939992;        
    }
    .center {
        margin-top: 1rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 2rem;
    }
    .line{
        border-bottom: 2px gray solid;
    }
    .method-box{
        border-radius: 2rem;
        padding: 1rem;
        width: 90%;
        background-color: #D9D9D9;
    }
    p{
        font-size: 1.5rem;
    }
</style>
</html>