<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%@include file="navbar.jsp" %>
    <div class="vehicle-container">
        <div class="vehicle-box">
        <div class="center"><h1>PLATE NUMBER - BRAND MODEL/YEAR - OWNER</h1></div>
        <div class="line"></div>
        <div>
            <h2 class="center">Vehicle Information</h2>
            <div class="line"></div>
            <div class="info-title"><p>Plate Number: </p><span>AAA 111</span></div>
            <div class="info-title"><p>Registered Owner: </p><span>LASTNAME, Firstname</span></div>
            <div class="info-title"><p>Brand: </p><span>Ferrari</span></div>
            <div class="info-title"><p>Year/Model: </p><span>2025</span></div>
            <button class="buttonP" >Edit Information</button>
        </div>
    </div>
    <div class="vehicle-box">
        <div class="center"><h1>PLATE NUMBER - BRAND MODEL/YEAR - OWNER</h1></div>
        <div class="line"></div>
        <div>
            <h2 class="center">Vehicle Information</h2>
            <div class="line"></div>
            <div class="info-title"><p>Plate Number: </p><span>BBB 222</span></div>
            <div class="info-title"><p>Registered Owner: </p><span>LASTNAME, Firstname</span></div>
            <div class="info-title"><p>Brand: </p><span>Honda</span></div>
            <div class="info-title"><p>Year/Model: </p><span>City 2023</span></div>
            <button class="buttonP" >Edit Information</button>
        </div>
    </div>
    </div>
    
</body>
<style>
    *{
        margin: 0;
    }
    h2{
        font-size: 3rem;
    }
    .info-title span{
        font-size: 2rem;
        align-self: center;
    }
    .info-title p {
        text-transform: uppercase;
        font-size: 2rem;
    }
    .info-title{
        display: flex;
        border-radius: 1rem;
        margin: 1rem 0;
        max-width: 100%;
        border: 2px black solid;
        font-size: 1.5rem;
        font-weight: bold;
        padding: 0.125rem 1rem;
        justify-content: space-between;
    }
    .center{
        display: flex;
        justify-content: center;
    }
    body {
        background-color: #939992;
    }
    .vehicle-container{
        margin-top: 1rem;
        align-items: center;
        gap: 2rem;
        display: flex;
        flex-direction: column;
    }
    .line{
        border-bottom: 2px gray solid;
    }
    .vehicle-box{
        border-radius: 2rem;
        padding: 1rem;
        width: 90%;
        background-color: #D9D9D9;
    }
    .buttonP {
    width: 300px;
    height: 52px;
    margin-right: 10px;
    background: #4A5C46;
    border: none;
    color: white;
    border-radius: 50px;
    font-size: 24px;
    margin-bottom: 13px;
    flex: 1;
    }
</style>
</html>