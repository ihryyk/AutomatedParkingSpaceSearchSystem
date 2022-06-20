<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link rel="stylesheet" href="./styles/registration.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <style>
        <%@include file="styles/registration.css"%>
    </style>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Title</title>
</head>
<body>
<c:if test="${popUps=='registration'}">
    <script>

        Swal.fire({
            icon: 'error',
            title: 'Error>',
            text: 'You input arent valid data',
        })
    </script>
    ${sessionScope.remove("popUps")}
</c:if>

<h2 class="signup__title">Registration</h2>
<form:form action="registration" modelAttribute="user" method="post" cssClass="signup__form">
    <div class="signup__controller">
        <form:input path="name" type="text" placeholder="Name" cssClass="signup__input"/>
        <form:errors path="name"/>
    </div>
    <div class="signup__controller">
        <form:input path="surname" type="text" placeholder="Surname" cssClass="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="emailAddress" type="text" placeholder="Email address" cssClass="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="phoneNumber" type="text" placeholder="Phone number" id="phone" cssClass="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="password" type="text" placeholder="Password" id="password" cssClass="signup__input"/>
    </div>
    <div class="signup__controller">
        <input type="radio" id="contactChoice1" name="registration" value="User" checked>
        <label for="contactChoice1">
            User
        </label>

        <input type="radio" id="contactChoice2" name="registration" value="ParkingOwner">
        <label for="contactChoice2">
            Parking owner
        </label>
    </div>
    <input type="submit" value="Create account" class="signup__submit">
</form:form>
<a href="/login" class="signup__link">
    Login
</a>
</body>
</html>
