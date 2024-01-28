<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <title>Welcome ${newUser.username}! | Kingsville Homeowners Association</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link rel="icon" type="image/x-icon" href="images/Valorant-Emblem.png"/>
    <link rel="stylesheet" href="CSS/welcome.css"/>
    <link rel="stylesheet" href="CSS/navbar.css"/>
  </head>
  <body>
    <div>
      <div class="container">
        <%@include file="navbar.jsp" %>
        <div class="main-content">
          <h1 class="content-h1" id="welcome2-h1">
            <span>welcome,
            <span class="user">${newUser.username}</span>
            !</span>
          </h1>
        </div>
        <div class="content-bg"  style="position:fixed">
          <img
            alt="BGwallpaper"
            src="https://scontent.fmnl3-3.fna.fbcdn.net/v/t39.30808-6/310016574_466993525463645_3575387101460071969_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=783fdb&_nc_eui2=AeHeFI4zAksHRpio1zg8fenwhgMIEgCbPiGGAwgSAJs-IdvSeymooKs6mqyfICZv0SDh9tqQoeR9aMoRz9k76Yr5&_nc_ohc=XYEN6vfFEqQAX_UD0KH&_nc_ht=scontent.fmnl3-3.fna&oh=00_AfBYs9AkFzEY3OMJuY0Ho7kTi2Ab6Firy67IzE83W3LVFw&oe=65B1D8BA"
            loading="eager"
            class="bg-img"
          />
        </div>
      </div>
    </div>
  </body>
</html>