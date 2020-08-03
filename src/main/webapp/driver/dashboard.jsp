<%-- 
    Document   : dashboard
    Created on : Jun 23, 2020, 12:23:01 PM
    Author     : a2-miljau
--%>
<%@page import="com.easyride.dao.RideDao"%>
<%@page import="com.easyride.models.Ride"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.easyride.models.User"%>
<%@page import="com.easyride.utils.EasyCabSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Driver Dashboard | EasyRide </title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body>
        <%
            EasyCabSession appSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
            User user = appSession.getUser();
            String driverStatus = user.getDriverStatus().toString();
        %> 
         <nav class="navbar navbar-expand-lg navbar-dark bg-dark d-flex">
            <div class="d-flex flex-grow-1">
                <span class="w-100 d-lg-none d-block"></span>
                <a class="navbar-brand d-none d-lg-inline-block" href="#">
                    EasyRide
                </a>
            </div>
            <div class="collapse navbar-collapse text-right align-items-end flex-column">
                <div class="d-flex">
                    <span class="navbar-text pr-2">
                        Logged in as <%=user.getName()%>
                    </span>

                    <form class="form-inline my-2 my-lg-0" method="POST" action="/logout">
                        <button class="btn btn-outline-danger my-2 my-sm-0" type="submit">Logout</button>
                    </form>
                </div>

            </div> 
        </nav>
        <h1>Driver Dashboard</h1>
        <form>
            <div class="form-group">
                <label for="driverStatus">Driver Status</label>
                <select class="form-control" name="driverStatus" id="driverStatus">
                    <option value="Busy" <%= driverStatus == "Busy" ? "selected" : ""%>>Busy</option>
                    <option value="Available" <%= driverStatus == "Available" ? "selected" : ""%>>Available</option>
                    <option value="Offline" <%= driverStatus == "Offline" ? "selected" : ""%>>Offline</option>
                </select>
            </div>
        </form> 
                <div id="activeRideCard" class="card" style="visibility: hidden">
  <div class="card-body">
    <h5 class="card-title">Active Ride</h5>
    <p class="card-text">You've been assigneed a ride!</p>
    <a href="#" class="btn btn-primary">Go to Story</a>
  </div>
</div>
                <script type="text/javascript">

                   var driverStatus = document.querySelector("#driverStatus");
            
                    driverStatus.addEventListener("change",function(){
                       console.log('onchange called');
                     var selectedStatus = driverStatus.children[driverStatus.selectedIndex].value;
                     
                     var xhr = new XMLHttpRequest();
                     xhr.open("POST", "/driver/status/" + selectedStatus, true);
                     xhr.setRequestHeader("content-type","application/json");
                     xhr.onreadystatechange  = function(){
                         if (xhr.readyState === XMLHttpRequest.DONE) {
                             driverStatus.disabled = false;
                         }
                     }
                     driverStatus.disabled = true;
                     xhr.send();
                   });
                   
                   function checkForActiveRide(){
                     var xhr = new XMLHttpRequest();
                     xhr.open("GET", "/notifs/activeRideId", true);
                     xhr.setRequestHeader("content-type","application/json");
                     xhr.onreadystatechange  = function(){
                         if (xhr.readyState === XMLHttpRequest.DONE) {
                            let card = document.querySelector("#activeRideCard"); 
                            if (xhr.responseText == "null"){
                                 card.style.visibility = "hidden";
                             } else {
                                 card.style.removeProperty("visibility");
                                 card.querySelector('a').href="/driver/story.jsp?rideId="+xhr.responseText;
                             }
                            setTimeout(checkForActiveRide, 2000); 
                        }
                     }
                       xhr.send();
                       
                   }
                   checkForActiveRide();
                </script>

    </body>
</html>
