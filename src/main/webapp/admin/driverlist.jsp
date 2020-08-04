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
        <title>Driver List | EasyRide </title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

    </head>
        <%@ include file="../WEB-INF/adminnavbar.jsp"%>
        <table class="table" id="admins">
            <thead>
                <tr>
                    <th scope="col">User Id</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Vehicle Registration Number</th>
                    <th scope="col">License Number</th>
                    <th scope="col">Driver Overview</th>
                    <th scope="col">Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<User> users = UserDao.getDriverList();
                    session.setAttribute("users", users);
                %>
                <c:forEach var="user" items="${users}" >
                    <tr>
                        <td>${user.getId()}</td>
                        <td>${user.getName()}</td>
                        <td>${user.getEmail()}</td>
                        <td>${user.getVehicalRegistrationNumber()}</td>
                        <td>${user.getLicenseNumber()}</td>
                        <td><a class="btn btn-primary" href="/admin/driveroverview.jsp?userId=${user.getId()}">Overview</a></td>
                        <td><button data-id="${user.getId()}" class="btn btn-danger delete-button">Delete</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <script type="text/javascript">
            [].slice.call(document.querySelectorAll(".delete-button")).forEach(button => {

            button.addEventListener("click", function (event) {
            if (confirm("Are you sure you want to delete this user?")) {
            event.target.parentElement.parentElement.remove();
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/admin/usermanagement/delete?userId=" + event.target.getAttribute("data-id"), true);
            xhr.setRequestHeader("content-type", "application/json");
            xhr.send();
            }
            })
            })
        </script>
    </body>
</html>
