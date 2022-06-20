<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 07.05.2022
  Time: 16:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0"/>
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <link rel="stylesheet" href="./styles/applyParking.css">
    <style>
        <%@include file="styles/applyParking.css"%>
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
            <a href="/" class="menu__item">Home</a>
            <a href="${pageContext.request.contextPath}/user/profile" class="menu__item">Update profile</a>
            <a href="${pageContext.request.contextPath}/user/activeParking" class="menu__item">Active parking</a>
            <a href="${pageContext.request.contextPath}/user/history" class="menu__item">History</a>
            <a href="${pageContext.request.contextPath}/user/abonnements" class="menu__item">Abonnements</a>
            <a href="${pageContext.request.contextPath}/user/logOut" class="menu__item">Log out</a>
        </c:if>
    </ul>
</div>

<h1 class="apply_title">Apply parking</h1>

<div class="container">
    <div class="parking">
        <img src="https://cdn-icons-png.flaticon.com/512/708/708949.png" alt="car" width="50px" height="50px"
             class="parking_img">
        <div class="parking_data">
            <p class="parking_street">
                <c:out value="${parkingInform.parking.streetName}"/>/
                <c:out value="${parkingInform.parking.streetNumber}"/>
            </p>
            <div class="parking_price-abonement">
                <p>Abonnement name:
                    <c:out value="${parkingInform.abonnement.name}"/>
                </p>
                <p>Car number:
                    <c:out value="${parkingInform.car.number}"/>
                </p>
                <p>Price:
                    <c:out value="${parkingInform.price}"/>$
                </p>
            </div>
        </div>
        <hr>
        <div class="parking_time">
            <p class="parking_time-time"><span>Start time:
                    <c:out value="${parkingInform.startTime}"/>
                </span> <span>Finish time:
                    <c:out value="${parkingInform.endTime}"/>
                </span></p>
        </div>
        <form:form action="/user/applyParking" modelAttribute="parkingInform" method="post">
            <form:hidden path="id"/>
            <form:hidden path="parking"/>
            <form:hidden path="price"/>
            <form:hidden path="startTime"/>
            <form:hidden path="endTime"/>
            <form:hidden path="parkingStatus"/>
            <form:hidden path="car"/>
            <form:hidden path="abonnement"/>
            <input type="submit" value="Submit" class="btn_apply">
        </form:form>
    </div>

</div>

<%--<form action="/user/applyParking?parkingInform=${parkingInform}"--%>
<%--      method="post">--%>
<%--    <input type="submit" value="Apply">--%>
<%--</form>--%>

</body>
</html>
