<%-- 
    Document   : dashboard
    Created on : Jun 23, 2020, 12:23:01 PM
    Author     : a2-miljau
--%>

<%@page import="com.easycab.models.User"%>
<%@page import="com.easycab.utils.EasyCabSession"%>
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
        <h1>Hello World!</h1>

    <c:if test="${user.getDriverStatus() != User.DriverStatus.Enroute } ">
        <form action="/driver/setstatus" method="POST">
            <span>Status:</span>
            <input type="radio" id="available" name="driverStatus" value="avialble">
            <label for="male">Available</label><br>
            <input type="radio" id="busy" name="driverStatus" value="busy">
            <label for="female">Busy</label><br>
            <input type="submit" value="Submit"/>
        </form> 
    </c:if>
</body>
</html>
