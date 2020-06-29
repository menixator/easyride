<%-- 
    Document   : login
    Created on : Jun 21, 2020, 3:16:01 AM
    Author     : Ahmed Rivaj
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        
        
        <script src="js/jquery-3.5.1.slim.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/login.css">
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
      <input type="text" id="password" class="fadeIn third" name="password" placeholder="password">
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




