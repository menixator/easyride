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
    <head>
        <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
        <meta charset="utf-8">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

        <title>User Story | EasyCab</title>
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
                flex-direction: column;
                max-width: 680px;
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
        <%
            EasyCabSession appSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
            User user = appSession.getUser();
            String banner = user.getType() == User.UserType.Admin ? "../WEB-INF/adminnavbar.jsp" : "../WEB-INF/customernavbar.jsp";
        %> 
        <jsp:include page="<%=banner%>" ></jsp:include>
        <div id="container">

            <div id="content">
                <div id="invalidRideId" class="alert alert-danger" role="alert" style="visibility: hidden">
                    The provided Ride identifier is invalid.
                </div>
            </div>
        </div>
        <script type="text/javascript">
        var match = document.location.search.match(/rideId=(\d+)/);
        var rideId;
        if (match) {
                rideId = parseInt(match[1]);
        } else {
                document.querySelector("#invalidRideId").style.removeProperty("visibility");
        }

        function updateStory(story) {
                if (story.errors.length > 0) {
                        story.errors
                                .map((error) => {
                                        var div = document.createElement("div");
                                        div.className = "alert alert-danger";
                                        div.textContent = error;
                                        return div;
                                })
                                .forEach((errorDiv) => {
                                        document.querySelector("#content").appendChild(errorDiv);
                                });
                }
                (story.notifs || [])
                        .filter(
                                (notif) =>
                                        !!~[
                                                "CustomerInitialNotif",
                                                "InProgressNotif",
                                                "WaitingForCustomerToEnterNotif",
                                                "RideEndedNotif",
                                        ].indexOf(notif.type)
                        )
                        .filter((notif) => {
                                return (
                                        [].slice
                                                .call(document.querySelector("#content").children)
                                                .findIndex((child) => child.getAttribute("data-id") == notif.id.toString()) ==
                                        -1
                                );
                        })
                        .map((notif) => {
                                switch (notif.type) {
                                        case "RideEndedNotif": {
                                                var div = document.createElement("div");
                                                div.setAttribute("data-id", notif.id);
                                                div.className = "alert alert-info";
                                                div.textContent = "Hope you had a good ride!";
                                                return div;
                                        }
                                        case "CustomerInitialNotif":
                                                //{'driverName': 'driver', 'vehicalRegistrationNumber': '000'}
                                                var data = JSON.parse(notif.data);
                                                var div = document.createElement("div");
                                                div.setAttribute("data-id", notif.id);
                                                div.className = "alert alert-info";
                                                div.textContent =
                                                        "You driver " +
                                                        data.driverName +
                                                        " will be picking you up in their vehical with the registration number: " +
                                                        data.vehicalRegisitrationNumber;
                                                return div;
                                        case "InProgressNotif":
                                                var div = document.createElement("div");
                                                div.setAttribute("data-id", notif.id);
                                                div.className = "alert alert-info";
                                                div.textContent = "Enjoy the ride!";
                                                return div;
                                        case "WaitingForCustomerToEnterNotif":
                                                //{'driverName': 'driver', 'vehicalRegistrationNumber': '000'}
                                                var data = JSON.parse(notif.data);
                                                var div = document.createElement("div");
                                                div.setAttribute("data-id", notif.id);
                                                div.className = "alert alert-info";
                                                var span = document.createElement("span");
                                                div.appendChild(span);
                                                span.textContent = "Your driver is here!";
                                                if (story.currentRideStatus == "WaitingForCustomerToEnter") {
                                                        var nextButton = document.createElement("button");
                                                        nextButton.className = "btn btn-primary mt-3";
                                                        nextButton.style.width = "100%";
                                                        nextButton.textContent = "I have Entered/am Entering!";
                                                        nextButton.addEventListener("click", function (event) {
                                                                event.target.remove();
                                                                var xhr = new XMLHttpRequest();
                                                                xhr.open(
                                                                        "GET",
                                                                        "/notifs/setRideStatus?rideId=" + rideId.toString() + "&nextStatus=InProgress",
                                                                        true
                                                                );
                                                                xhr.setRequestHeader("content-type", "application/json");
                                                                xhr.send();
                                                        });
                                                        div.appendChild(nextButton);
                                                }
                                                return div;
                                        default:
                                                return null;
                                }
                        })
                        .filter((div) => div != null)
                        .forEach((div) => {
                                document.querySelector("#content").appendChild(div);
                        });
                setTimeout(refreshStory, 5000);
        }

        function refreshStory() {
                var xhr = new XMLHttpRequest();
                xhr.open("GET", "/notifs/all?rideId=" + rideId, true);
                xhr.setRequestHeader("content-type", "application/json");
                xhr.onreadystatechange = function () {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                                updateStory(JSON.parse(xhr.responseText));
                        }
                };
                xhr.send();
        }
        refreshStory();

        </script>
    </body>
</html>