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
        <title>Customer List | EasyRide </title>
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
                    <a class="nav-link" href="/admin/ridelist.jsp">Ride List</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/customerlist.jsp">Customer List</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/adminlist.jsp">Admin List</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/driverlist.jsp">Driver List</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/registerdriver.jsp">Register Driver</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="/admin/registeradmin">Register Admin</a>
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

        <table class="table" id="admins">
            <thead>
                <tr>
                    <th scope="col">User Id</th>
                    <th scope="col">Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<User> users = UserDao.getCustomerList();
                    session.setAttribute("users", users);
                %>
                <c:forEach var="user" items="${users}" >
                    <tr>
                        <td>${user.getId()}</td>
                        <td>${user.getName()}</td>
                        <td>${user.getEmail()}</td>
                        <td><button data-id="${user.getId()}" class="btn btn-danger delete-button">Delete</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <script type="text/javascript">
            [].slice.call(document.querySelectorAll(".delete-button")).forEach(button = > {

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
