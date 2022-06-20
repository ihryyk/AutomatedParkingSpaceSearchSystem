<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 06.05.2022
  Time: 18:00
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
    <style>
        <%@include file="styles/activeparking.css"%>
    </style>
    <link rel="stylesheet" href="./styles/activeparking.css">
    <title>Active parking</title>
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

<h1 class="active_title">Active Parkings</h1>
<div class="container">

    <ul class="parkings__list">
        <c:forEach var="parkingInform" items="${activeParking}">
            <li class="parkings__list_item">
                <div class="list_item_container">
                    <img src="https://cdn-icons-png.flaticon.com/512/708/708949.png" alt="car" width="50px"
                         height="50px" class="list_item_img">
                    <div class="list_item_name-street">
                        <p class="list_item_street"><c:out value="${parkingInform.parking.streetName}"/> <c:out
                                value="${parkingInform.parking.streetNumber}"/></p>
                        <div class="list_item_name-price">
                            <p><c:out value="${parkingInform.abonnement.name}"/></p>
                            <p><c:out value="${parkingInform.car.number}"/></p>
                            <p><c:out value="${parkingInform.parking.price}"/>$</p>
                        </div>
                    </div>
                    <hr>
                    <div>
                        <p class="list_item_time"><span>Start time: <c:out value="${parkingInform.startTime}"/></span>
                            <span>Finish time: <c:out value="${parkingInform.endTime}"/></span></p>
                    </div>
                </div>
                <form action="/user/cancelParking/?parkingInformId=${parkingInform.id}" method="post">
                    <input type="submit" value="CANCEL" class="btn_cancel">
                </form>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
