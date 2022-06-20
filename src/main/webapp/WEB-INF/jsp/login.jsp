<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 02.05.2022
  Time: 19:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <link rel="stylesheet" href="./styles/registration.css">
    <style>
        <%@include file="styles/registration.css"%>
    </style>
    <title>Title</title>
</head>
<body>
<form action="login" method="post" class="signup__form">
    <h2 class="signup__title login">Login</h2>
    <div class="signup__controller">
        <input type="text" name="emailAddress" placeholder="Email address" required class="signup__input"/>
    </div>
    <div class="signup__controller">
        <input type="password" name="password" placeholder="Password" required class="signup__input"/>
    </div>
    <input type="submit" value="Log In" class="signup__submit">
    <a href="/registration" class="signup__link">
        Registration
    </a>
</form>
</body>
</html>