<%-- 
    Document   : dashboard
    Created on : Jun 23, 2020, 12:23:01 PM
    Author     : a2-miljau
--%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.easyride.dao.UserDao"%>
<%@page import="com.easyride.dao.RideDao"%>
<%@page import="com.easyride.models.Ride"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.easyride.models.User"%>
<%@page import="com.easyride.utils.EasyCabSession"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Daily Overview | EasyRide </title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body>
        <%
            EasyCabSession appSession = (EasyCabSession) session.getAttribute(EasyCabSession.ATTR_NAME);
            User user = appSession.getUser();
        %> 
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark d-flex">
            <div class="d-flex flex-grow-1">
                <span class="w-100 d-lg-none d-block"></span>
                <a class="navbar-brand d-none d-lg-inline-block" href="#">
                    EasyRide
                </a>
            </div>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="/driver/dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/driver/dailyoverview.jsp">Daily Overview<span class="sr-only">(current)</span></a>
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


        <div id="activeRideCard" class="card">
            <div class="card-body">
                <h5 class="card-title">Total Earnings for the Day</h5>
                <p class="card-text">MVR <%=UserDao.getEarningsForTheDay(user.getId())%></p>
            </div>
        </div>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Ride Id</th>
                    <th scope="col">Requested</th>
                    <th scope="col">Ended</th>
                    <th scope="col">Distance</th>
                    <th scope="col">Fare</th>
                    <th scope="col">Story</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<Ride> rides = UserDao.getRidesForToday(user.getId());
                    session.setAttribute("rides", rides);
                %>
                <c:forEach var="ride" items="${rides}" >
                    <tr>
                        <td>${ride.getId()}</td>
                        <td>${ride.getRequestedTimestamp()}</td>
                        <td>${ride.getEndTimestamp()}</td>
                        <td>${ride.getDistance()} km</td>
                        <td>${ride.getFare()}</td>
                        <td><a href="/driver/story.jsp?rideId=${ride.getId()}">View Story</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
