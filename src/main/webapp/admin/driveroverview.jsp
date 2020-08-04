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
        <title>Driver Overview | EasyRide </title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body>
        <%@ include file="../WEB-INF/adminnavbar.jsp"%>
        <%
            Integer userId;
            try {
                userId = Integer.parseInt(request.getParameter("userId"));
            } catch (NumberFormatException err) {
                userId = 0;
            }
            if (userId == null) {
                userId = 0;
            }
            ArrayList<Ride> rides = UserDao.getRidesForToday(userId);
            session.setAttribute("rides", rides);
        %>
      <div class="card">
            <div class="card-body">
                <h5 class="card-title">Total Earnings for the Day</h5>
                <p class="card-text">MVR <%=UserDao.getEarningsForTheDay(userId)%></p>
            </div>
        </div>
        <div class="card">
            <div class="card-body">
                <h5 class="card-title">Total Number of Customers Served</h5>
                <p class="card-text"><%=RideDao.getTotalCustomersServed(userId)%></p>
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
                    <th scope="col">Status</th>
                    <th scope="col">Driver Story</th>
                    <th scope="col">User Story</th>
                </tr>
            </thead>
            <tbody>
                
                <c:forEach var="ride" items="${rides}" >
                    <tr>
                        <td>${ride.getId()}</td>
                        <td>${ride.getRequestedTimestamp()}</td>
                        <td>${ride.getEndTimestamp()}</td>
                        <td>${ride.getDistance()} km</td>
                        <td>${ride.getFare()}</td>
                        <td>${ride.getStatus()}</td>
                        <td><a href="/driver/story.jsp?rideId=${ride.getId()}">View Driver Story</a></td>
                        <td><a href="/customer/story.jsp?rideId=${ride.getId()}">View Customer Story</a></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
