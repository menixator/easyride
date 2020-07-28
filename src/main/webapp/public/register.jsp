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
        <title>Register Page</title>
    </head>
    <body>
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
            
    <form method="POST" action="/public/register">
        <label for="name">Name</label><input type="text" id="name" name="name"/>
        <label for="email">Email</label><input type="text" id="email" name="email"/>
        <label for="email">Contact Number</label><input type="text" id="contactNumber" name="contactNumber"/>
        <label for="password">Password</label><input type="password" id="password" name="password"/>
        <label for="passwordAgain">Enter Password Again for Verification</label><input type="passwordAgain" id="passwordAgain" name="passwordAgain"/>
        <input type="submit" value="Submit"/>
    </form>
</body>
</html>
