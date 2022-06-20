<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 13.05.2022
  Time: 14:35
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
    <link rel="stylesheet" href="./styles/registeredParking.css">
    <style>
        <%@include file="styles/registeredParking.css"%>
        <%@include file="styles/registration.css"%>
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
            <a href="/parkingOwner/" class="menu__item">Home</a>
            <a href="${pageContext.request.contextPath}/user/profile" class="menu__item">Update profile</a>
            <a href="${pageContext.request.contextPath}/user/logOut" class="menu__item">Log out</a>
            <a href="${pageContext.request.contextPath}/parkingOwner/createParking" class="menu__item">Register
                parking</a>
        </c:if>
    </ul>
</div>


<form:form action="/parkingOwner/registeredParking" modelAttribute="parking" method="post" cssClass="signup__form">
    <form:hidden path="id"/>
    <div class="signup__controller">
        <form:input path="streetName" placeholder="Street name" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="streetNumber" placeholder="Street number" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="price" placeholder="Price for 1 parking" class="signup__input"/>
    </div>
    <div class="signup__controller">
        <form:input path="capacity" placeholder="Capacity" class="signup__input"/>
    </div>
    <input type="submit" value="Add documents" class="signup__submit">
    <input type="submit" value="submit" class="signup__submit">
</form:form>
</body>
</html>
