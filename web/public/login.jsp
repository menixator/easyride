<%-- 
    Document   : login.jsp
    Created on : Jun 22, 2020, 12:04:04 PM
    Author     : a2-miljau
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Login to Easycab!</h1>
        <c:if test="${errors != null && errors.size() > 0}">
            <c:forEach var="error" items="${errors}" >
                <div> Error: ${error}</div>
            </c:forEach>

        </c:if>
                
      <c:if test="${messages != null && messages.size() > 0}">
            <c:forEach var="message" items="${messages}" >
                <div> ${message}</div>
            </c:forEach>

        </c:if>
        <form method="POST" action="/public/login">
            <label for="email">Email</label><input type="text" id="email" name="email"/>
            <label for="username">Password</label><input type="password" id="password" name="password"/>
            <input type="submit" value="Submit"/>
        </form>
        <div>Don't have an account? Register <a href="/public/register.jsp">here</a></div>
    </body>
</html>
