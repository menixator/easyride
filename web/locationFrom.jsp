<%-- 
    Document   : locationFrom
    Created on : Jun 28, 2020, 12:11:13 PM
    Author     : Ahmed Rivaj
--%>


<!DOCTYPE html>
<html>
<head>
<title>Autocomplete Places Search Box using Google Maps JavaScript API by CodexWorld</title>
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/maps.css">
</head>
<body>
    
<div class="container">
    <h1>Easy Ride</h1>
    <form method="POST" action="locationTo.jsp">
        <input id="location" type="hidden" name="location">
        <input id="lat" type="hidden" name="lat">
        <input id="lon" type="hidden" name="lat">
        <input id="country" type="hidden" name="country">
        <input id="postal_code" type="hidden" name="postal_code">
        <!--<span id="location" name="location"></span>-->
        <input type="submit" class="btn btn-primary">
    </form>
	<!-- Search input -->
	<input id="searchInput" class="controls" type="text" placeholder="Enter a location">
	
	<!-- Google map -->
	<div id="map"></div>
	
	<!-- Display geo location data -->
	<ul class="geo-data">

	</ul>
</div>

<script src="https://maps.googleapis.com/maps/api/js?libraries=places&key=AIzaSyCWAjAb3xz1kqKBsf9a5CE23bxIn21cGmw&callback=initMap" async defer></script>
<script>
function initMap() {
    var map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 4.2052286, lng: 73.5170519},
      zoom: 13
    });
    var input = document.getElementById('searchInput');
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.bindTo('bounds', map);

    var infowindow = new google.maps.InfoWindow();
    var marker = new google.maps.Marker({
        map: map,
        anchorPoint: new google.maps.Point(0, -29)
    });

    autocomplete.addListener('place_changed', function() {
        infowindow.close();
        marker.setVisible(false);
        var place = autocomplete.getPlace();
        if (!place.geometry) {
            window.alert("Autocomplete's returned place contains no geometry");
            return;
        }
  
        // If the place has a geometry, then present it on a map.
        if (place.geometry.viewport) {
            map.fitBounds(place.geometry.viewport);
        } else {
            map.setCenter(place.geometry.location);
            map.setZoom(17);
        }
        marker.setIcon(({
            url: place.icon,
            size: new google.maps.Size(71, 71),
            origin: new google.maps.Point(0, 0),
            anchor: new google.maps.Point(17, 34),
            scaledSize: new google.maps.Size(35, 35)
        }));
        marker.setPosition(place.geometry.location);
        marker.setVisible(true);
    
        var address = '';
        if (place.address_components) {
            address = [
              (place.address_components[0] && place.address_components[0].short_name || ''),
              (place.address_components[1] && place.address_components[1].short_name || ''),
              (place.address_components[2] && place.address_components[2].short_name || '')
            ].join(' ');
        }
    
        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
        infowindow.open(map, marker);
      
        // Location details
        for (var i = 0; i < place.address_components.length; i++) {
            if(place.address_components[i].types[0] == 'postal_code'){
                document.getElementById('postal_code').value = place.address_components[i].long_name;
            }
            if(place.address_components[i].types[0] == 'country'){
                document.getElementById('country').value = place.address_components[i].long_name;
            }
        }
        document.getElementById('location').value = place.formatted_address;
        document.getElementById('lat').value = place.geometry.location.lat();
        document.getElementById('lon').value = place.geometry.location.lng();
    });
}
</script>
</body>
</html>