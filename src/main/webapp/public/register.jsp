<%-- 
    Document   : register.jsp
    Created on : Jun 22, 2020, 12:04:04 PM
    Author     : miljau
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register | EasyRide </title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/all.css">
        <style>
            html, body, #container {width: 100vw; height: 100vh; margin: 0px;}
            #container { 
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
            }
        </style>
    </head>
    <body>


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
            </div>
            <form method="POST" action="/public/register">
                <h4 class="card-title mt-3 text-center">Create an Account</h4>

                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                    </div>
                    <input name="name" class="form-control" placeholder="Full name" type="text">
                </div> <!-- form-group// -->
                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-envelope"></i> </span>
                    </div>
                    <input name="email" class="form-control" placeholder="Email address" type="email">
                </div> <!-- form-group// -->
                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-phone"></i> </span>
                    </div>
                    <input name="contactNumber" class="form-control" placeholder="Contact Number" type="text">
                </div> <!-- form-group// -->

                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                    </div>
                    <input name="password" class="form-control" placeholder="Password" type="password">
                </div> <!-- form-group// -->
                <div class="form-group input-group">
                    <div class="input-group-prepend">
                        <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                    </div>
                    <input name="passwordAgain" class="form-control" placeholder="Repeat password" type="password">
                </div> <!-- form-group// -->                                      
                <div class="form-group">
                    <button type="submit" class="btn btn-primary btn-block"> Create Account  </button>
                </div> <!-- form-group// -->      
                <p class="text-center">Have an account? <a href="/public/login">Log In</a> </p>                                                                 
            </form>

        </div> 

    </body>
</html>
