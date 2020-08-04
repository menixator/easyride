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
        <%@ include file="../WEB-INF/drivernavbar.jsp"%>
        <h1>Driver Dashboard</h1>
        <form>
            <div class="form-group">
                <label for="driverStatus">Driver Status</label>
                <select class="form-control" name="driverStatus" id="driverStatus" disabled>
                    <option value="Busy">Busy</option>
                    <option value="Available">Available</option>
                    <option value="Offline">Offline</option>
                </select>
            </div>
        </form> 
        <div id="activeRideCard" class="card" style="visibility: hidden">
            <div class="card-body">
                <h5 class="card-title">Active Ride</h5>
                <p class="card-text">You've been assigned a ride!</p>
                <a href="#" class="btn btn-primary">Go to Story</a>
            </div>
        </div>
        <script type="text/javascript">

            var driverStatus = document.querySelector("#driverStatus");
            var changingStatus = false;
            function checkStatus() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/driver/status", true);
                xhr.setRequestHeader("content-type", "application/json");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.responseText == "Enroute") {
                            driverStatus.disabled = true;
                        } else if (!changingStatus) {
                            driverStatus.disabled = false;
                            var opt = [].slice.call(driverStatus.children).findIndex(child = > child.value == xhr.responseText);
                            if (opt >= 0) {
                                driverStatus.selectedIndex = opt;
                            }
                        }
                        setTimeout(checkStatus, 3000);
                    }

                }
                xhr.send();
            }
            checkStatus();
            driverStatus.addEventListener("change", function () {
                console.log('onchange called');
                var selectedStatus = driverStatus.children[driverStatus.selectedIndex].value;
                changingStatus = true;
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "/driver/status/" + selectedStatus, true);
                xhr.setRequestHeader("content-type", "application/json");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        driverStatus.disabled = false;
                        changingStatus = false;
                    }
                }
                driverStatus.disabled = true;
                xhr.send();
            });

            function checkForActiveRide() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/notifs/activeRideId", true);
                xhr.setRequestHeader("content-type", "application/json");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        let card = document.querySelector("#activeRideCard");
                        if (xhr.responseText == "null" || xhr.responseText == "") {
                            card.style.visibility = "hidden";
                        } else {
                            card.style.removeProperty("visibility");
                            card.querySelector('a').href = "/driver/story.jsp?rideId=" + xhr.responseText;
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
