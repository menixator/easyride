<%-- 
    Document   : request-a-pickup
    Created on : Jun 27, 2020, 11:01:41 AM
    Author     : miljau_a
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Request a Pickup</title>
    <style>
      #right-panel {
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }

      #right-panel select, #right-panel input {
        font-size: 15px;
      }

      #right-panel select {
        width: 100%;
      }

      #right-panel i {
        font-size: 12px;
      }
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
        float: left;
        width: 63%;
        height: 100%;
      }
      #right-panel {
        float: right;
        width: 34%;
        height: 100%;
      }
      .panel {
        height: 100%;
        overflow: auto;
      }
    </style>
  </head>
  <body>
      <c:if test="${errors != null && errors.size() > 0}">
        <c:forEach var="error" items="${errors}" >
            <div> Error: ${error}</div>
        </c:forEach>
	<div id="message">Click on the map to select a pickup location</div>
      </c:if>
    <div id="map"></div>

    <div id="right-panel">
    	<form action="/customer/request-a-pickup" method="POST">
		<input type="text" name="pickupLocationLatitude" readonly id="pickupLocationLatitude"></text>
		<input type="text" name="pickupLocationLongitude" readonly id="pickupLocationLongitude"></text>
		<input type="text" name="destinationLatitiude" readonly id="destinationLatitiude"></text>
		<input type="text" name="destinationLongitude" readonly id="destinationLongitude"></text>
		</br>
		<input type="text" id="pricePerKilometre" value="25">
		</br>
		<label for="price">Price(MVR)</label>
		<input type="text" val="0" name="price" id="price">
		</br>
		<label for="distance">Distance(km)</label>
		<input type="text" val="0" name="distance" id="distance">
                <input type="submit" value="submit" disabled id="requestSubmitButton"/>
	</form>
    </div>
    <script>
	
function initMap() {
	if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(function(position) {
			initMapTrue(position.coords.latitude, position.coords.longitude);
		});
	} else {
		initMapTrue(4.1755, 73.5093);
	}
}
function initMapTrue(lat, lng) {
	var map = new google.maps.Map(document.getElementById("map"), {
		zoom: 16,
		center: { lat, lng }
	});

	

	let listener = map.addListener("click", function (e) {
		placeMarker(e.latLng, map);
	});
	
	let markers = [];

	function placeMarker(position, map) {
		var marker = new google.maps.Marker({
			position: position,
			draggable: true,
			map: map
		});
		map.panTo(position);
		markers.push(marker);
		
		if (markers.length == 1 ) {
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
			markers.map(marker => marker.setMap(null));
			markers.splice(0,markers.length);
			document.querySelector("#message").remove();
                        // Enable the submit button.
                        document.querySelector("#requestSubmitButton").removeAttribute("disabled");
		}
	}

	var directionsService = new google.maps.DirectionsService();
	var directionsRenderer = new google.maps.DirectionsRenderer({
		draggable: true,
		map: map
	});

	directionsRenderer.addListener("directions_changed", function() {
		let directions = directionsRenderer.getDirections();
		let origin = directions.request.origin;
		let destination = directions.request.destination;
		
		document.querySelector("#pickupLocationLatitude").value =(  origin.location || origin ).lat();
		document.querySelector("#pickupLocationLongitude").value = ( origin.location || origin).lng();

		document.querySelector("#destinationLatitiude").value = (destination.location || destination).lat();
		document.querySelector("#destinationLongitude").value = (destination.location || destination).lng();
				
		document.querySelector("#distance").value=(calculateDistance(directions)/1000).toFixed(3);
		document.querySelector("#price").value=((calculateDistance(directions)/1000)*parseFloat(document.querySelector("#pricePerKilometre").value.trim())).toFixed(2);
	});
}

function displayRoute(origin, destination, service, display) {
	service.route(
		{
			origin: origin,
			destination: destination,
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

function calculateDistance(result) {
	if (result.routes.length == 0) {
		return null;
	}
	return result.routes[0].legs.reduce(
		(total, curr) => total + curr.distance.value,
		0
	);
}

    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkt9Sm5I1Rp2bGMWUN995nsQ3DFfNDc3U&callback=initMap">
    </script>
  </body>
</html>