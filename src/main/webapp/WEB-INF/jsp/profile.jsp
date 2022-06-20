<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 04.05.2022
  Time: 19:38
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
    <link rel="stylesheet" href="./styles/profile.css">
    <link rel="stylesheet" href="./styles/registration.css">
    <style>
        <%@include file="styles/registration.css"%>
        <%@include file="styles/profile.css"%>
    </style>
    <title>Title</title>
</head>
<body>
<div class="hamburger-menu">
    <input id="menu__toggle" type="checkbox"/>
    <label class="menu__btn" for="menu__toggle">
        <span></span>
    </label>
    <ul class="menu__box">
        <c:if test="${sessionScope.userId==null}">
            <a href="${pageContext.request.contextPath}/login" class="menu__item">Log in</a>
            <a href="${pageContext.request.contextPath}/registration" class="menu__item">Registration</a>
        </c:if>
        <c:if test="${sessionScope.userId!=null}">
            <c:if test="${sessionScope.userRole=='OWNER'}">
                <a href="/parkingOwner/" class="menu__item">Home</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="menu__item">Update profile</a>
                <a href="${pageContext.request.contextPath}/user/logOut" class="menu__item">Log out</a>
                <a href="${pageContext.request.contextPath}/parkingOwner/createParking" class="menu__item">Register
                    parking</a>
            </c:if>
            <c:if test="${sessionScope.userRole == 'USER'}">
                <a href="/" class="menu__item">Home</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="menu__item">Update profile</a>
                <a href="${pageContext.request.contextPath}/user/activeParking" class="menu__item">Active parking</a>
                <a href="${pageContext.request.contextPath}/user/history" class="menu__item">History</a>
                <a href="${pageContext.request.contextPath}/user/abonnements" class="menu__item">Abonnements</a>
                <a href="${pageContext.request.contextPath}/user/logOut" class="menu__item">Log out</a>
            </c:if>

        </c:if>


    </ul>
</div>


<form:form action="profile" modelAttribute="user" method="post" class="signup__form">
    <form:hidden path="id"/>
    <div class="signup__controller">
        <form:input path="name" placeholder="Name" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="surname" placeholder="Surname" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="emailAddress" placeholder="Email address" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="phoneNumber" placeholder="Phone number" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="password" placeholder="Password" class="signup__input"/>
    </div>
    <input type="submit" value="submit" class="signup__submit">
</form:form>

<c:if test="${sessionScope.userRole == 'USER'}">
    <a href="${pageContext.request.contextPath}/user/profile/userCar" class="signup__link">
        Show car
    </a>
</c:if>
</body>
</html>
