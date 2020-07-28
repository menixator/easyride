<%-- 
    Document   : login.jsp
    Created on : Jun 22, 2020, 12:04:04 PM
    Author     : a2-miljau
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>Login | EasyRide</title>

         <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">

        <style>
            html,
            body {
                height: 100%;
            }

            body {
                display: -ms-flexbox;
                display: flex;
                -ms-flex-align: center;
                align-items: center;
                padding-top: 40px;
                padding-bottom: 40px;
                background-color: #f5f5f5;
            }

            .form-signin {
                width: 100%;
                max-width: 330px;
                padding: 15px;
                margin: auto;
            }
            .form-signin .checkbox {
                font-weight: 400;
            }
            .form-signin .form-control {
                position: relative;
                box-sizing: border-box;
                height: auto;
                padding: 10px;
                font-size: 16px;
            }
            .form-signin .form-control:focus {
                z-index: 2;
            }
            .form-signin input[type="email"] {
                margin-bottom: -1px;
                border-bottom-right-radius: 0;
                border-bottom-left-radius: 0;
            }
            .form-signin input[type="password"] {
                margin-bottom: 10px;
                border-top-left-radius: 0;
                border-top-right-radius: 0;
            } 
            #container {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                width: 100%;
            }
        </style>
    </head>

    <body class="text-center">
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
            <form class="form-signin" method="POST" action="/public/login">
                <h1 class="h3 mb-3 font-weight-normal">Please sign in</h1>
                <label for="email" class="sr-only">Email address</label>
                <input type="text" id="email" class="form-control" placeholder="Email address" required autofocus>
                <label for="password" class="sr-only">Password</label>
                <input type="password" id="password" class="form-control" placeholder="Password" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
            </form>

        </div>

    </body>
</html>
