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
        <title>Driver Dashboard Page</title>
    </head>
    <body>
        <%
            EasyCabSession appSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
            User user = appSession.getUser();
        %> 
        <h1>Driver Dashboard</h1>
                <div>${user.getDriverStatus().toString()}</div>
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
        <form action="/driver/setstatus" method="POST">
            <span>Status:</span>
            <select name="driverStatus" id="driverStatus">
                <option value="Busy">Busy</option>
                <option value="Available">Available</option>
            </select>

            <input type="submit" value="Submit"/>
        </form> 

    </body>
</html>
