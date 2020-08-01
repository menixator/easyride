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
        <c:if test="${user.getDriverStatus() == User.DriverStatus.Enroute } ">
            <%
                Ride ride = RideDao.getActiveRideForDriver(user);

            %>
            <div

                <h3>Currently Assigned Task</h3>
                <div>Fare: <span>${ride.getFare()}</span></div>
                <div id="map"></div>
                <script async defer
                        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkt9Sm5I1Rp2bGMWUN995nsQ3DFfNDc3U&callback=initMap">
                </script>
                <script type="javascript">
                    var origin = { lat: ${ride.getPickupLocationLatitude()}, lng: ride.getPickupLocationLongitude() };
                    var dest = { lat: ${ride.getDestinationLatitude()}, lng: ${ride.getDestinationLongitude()} };
                    function initMap(){
                        var map = new google.maps.Map(document.getElementById("map"), {
                                zoom: 16,
                                center: { lat, lng }
                        });
                        var directionsService = new google.maps.DirectionsService();
                        var directionsRenderer = new google.maps.DirectionsRenderer({
                                draggable: true,
                                map: map
                        });
                        directionsService.route(
                        {
                                origin: origin,
                                destination: dest,
                                waypoints: [],
                                travelMode: "DRIVING",
                                avoidTolls: true
                        },
                        function(response, status) {
                                if (status === "OK") {
                                        display.setDirections(response);
                                } else {
                                        alert("Could not display directions due to: " + status);
                                }
                        }
                        );
                    }
                </script>
            </div>
        </c:if>
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
                </script>

    </body>
</html>
