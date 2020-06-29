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
        
        <script src="../js/jquery-3.5.1.slim.min.js"></script>
        <script src="../js/popper.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/login.css">
    </head>
    <body>
         <div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <img src="http://danielzawadzki.com/codepen/01/icon.svg" id="icon" alt="User Icon" />
    </div>
    
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

    <!-- Login Form -->
    <form method="POST" action="/public/login">
      <input type="text" id="email" class="fadeIn second" name="email" placeholder="login">
      <input type="password" id="password" class="fadeIn third" name="password" placeholder="password">
      <input type="submit" class="fadeIn fourth" value="Log In">
    </form>

    <!-- Remind Passowrd -->
    <div id="formFooter">
        Don&#39;t have an Account? <a class="underlineHover" href="/public/register.jsp">Sign up</a><br>
      <a class="underlineHover" href="#">Forgot Password?</a>
    </div>

  </div>
</div>
    </body>
</html>
