<%-- 
    Document   : request-a-pickup
    Created on : Jun 27, 2020, 11:01:41 AM
    Author     : miljau_a
--%>
<%@page import="com.easyride.models.User"%>
<%@page import="com.easyride.utils.EasyCabSession"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        EasyCabSession appSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
        User user = appSession.getUser();
    %> 
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta charset="utf-8">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

        <title>Request a Pickup | EasyCab</title>
        <style>

            html, body {
                height: 100%;
                margin: 0;
                padding: 0;
            }
            #container{
                padding-top: 10px;
                box-sizing: border-box;
                padding-bottom: 10px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }
            #content{
                width: 100%;
                display: flex;
                justify-content: space-around;
                margin-top: 5px;
            }
            #map {
                height: 100%;
                float: left;
                width: 63%;
                height: 500px;
            }
            #alerts {
                width: 60%;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark d-flex">
            <div class="d-flex flex-grow-1">
                <span class="w-100 d-lg-none d-block"></span>
                <a class="navbar-brand d-none d-lg-inline-block" href="#">
                    EasyRide
                </a>
            </div>
            <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/customer/request-a-pickup.jsp">Request A Pickup<span class="sr-only">(current)</span></a>
      </li>
    </ul>
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
        <div id="container">
            <div id="alerts">
                <c:if test="${errors != null && errors.size() > 0}">
                    <c:forEach var="error" items="${errors}" >
                        <div class="alert alert-danger" role="alert">${error}</div>
                    </c:forEach>

                </c:if>

                <c:if test="${messages != null && messages.size() > 0}">
                    <c:forEach var="message" items="${messages}" >
                        <div class="alert alert-success" role="alert">${message}</div>
                    </c:forEach>

                </c:if>
                <div id="message" class="alert alert-success">Click on the map to select a pickup location</div>
            </div>
            <div id="content">
                <div id="map"></div>

                <form  action="/customer/request-a-pickup" method="POST">
                    <input type="text" hidden name="pickupLocationLatitude" readonly id="pickupLocationLatitude"></text>
                    <input type="text" hidden name="pickupLocationLongitude" readonly id="pickupLocationLongitude"></text>
                    <input type="text" hidden name="destinationLatitude" readonly id="destinationLatitude"></text>
                    <input type="text" hidden name="destinationLongitude" readonly id="destinationLongitude"></text>

                    <div class="form-group">
                        <label for="pricePerKilometre">Price Per Kilometre</label>
                        <input type="text" class="form-control" id="pricePerKilometre" value="25" readonly>
                    </div>
                    <div class="form-group">
                        <label for="fare">Price(MVR)</label>
                        <input class="form-control" type="text" val="0" name="fare" id="fare">
                    </div>

                    <div class="form-group">
                        <label for="distance">Distance(KM)</label>
                        <input class="form-control" type="text" val="0" name="distance" id="distance">
                    </div>
                    <input class="btn btn-primary" type="submit" value="Request a Ride!" disabled id="requestSubmitButton"/>
                </form>
            </div>
        </div>
        <script>
function initMap() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function (position) {
			initMapTrue(position.coords.latitude, position.coords.longitude);
		});
	} else {
		initMapTrue(4.1755, 73.5093);
	}
}
function initMapTrue(lat, lng) {
	var map = new google.maps.Map(document.getElementById("map"), {
		zoom: 16,
		center: { lat, lng },
	});
	let listener = map.addListener("click", function (e) {
		placeMarker(e.latLng, map);
	});
	let markers = [];
	function placeMarker(position, map) {
		var marker = new google.maps.Marker({
			position: position,
			draggable: true,
			map: map,
		});
		map.panTo(position);
		markers.push(marker);
		if (markers.length == 1) {
			document.querySelector("#message").textContent = "Select your destination.";
		}

		if (markers.length >= 2) {
			google.maps.event.removeListener(listener);
			displayRoute(
				markers[0].getPosition(),
				markers[1].getPosition(),
				directionsService,
				directionsRenderer
			);
			markers.map(function (marker) {
				marker.setMap(null);
			});
			markers.splice(0, markers.length);
			document.querySelector("#message").textContent =
				"Now submit the form to request a ride!";
			// Enable the submit button.
			document.querySelector("#requestSubmitButton").removeAttribute("disabled");
		}
	}

	var directionsService = new google.maps.DirectionsService();
	var directionsRenderer = new google.maps.DirectionsRenderer({
		draggable: true,
		map: map,
	});
	directionsRenderer.addListener("directions_changed", function () {
		let directions = directionsRenderer.getDirections();
		let origin = directions.request.origin;
		let destination = directions.request.destination;
		document.querySelector("#pickupLocationLatitude").value = (
			origin.location || origin
		).lat();
		document.querySelector("#pickupLocationLongitude").value = (
			origin.location || origin
		).lng();
		document.querySelector("#destinationLatitude").value = (
			destination.location || destination
		).lat();
		document.querySelector("#destinationLongitude").value = (
			destination.location || destination
		).lng();
		document.querySelector("#distance").value = (
			calculateDistance(directions) / 1000
		).toFixed(3);
		document.querySelector("#fare").value = (
			(calculateDistance(directions) / 1000) *
			parseFloat(document.querySelector("#pricePerKilometre").value.trim())
		).toFixed(2);
	});
}

function displayRoute(origin, destination, service, display) {
	service.route(
		{
			origin: origin,
			destination: destination,
			waypoints: [],
			travelMode: "DRIVING",
			avoidTolls: true,
		},
		function (response, status) {
			if (status === "OK") {
				display.setDirections(response);
			} else {
				alert("Could not display directions due to: " + status);
			}
		}
	);
}

function calculateDistance(result) {
	if (result.routes.length == 0) {
		return null;
	}
	return result.routes[0].legs.reduce(function (total, curr) {
		return total + curr.distance.value;
	}, 0);
}


        </script>
        <script async defer
                src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkt9Sm5I1Rp2bGMWUN995nsQ3DFfNDc3U&callback=initMap">
        </script>
    </body>
</html>