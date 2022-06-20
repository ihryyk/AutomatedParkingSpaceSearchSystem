<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 12.05.2022
  Time: 21:59
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
    <link rel="stylesheet" href="./styles/earning.css">
    <style>
        <%@include file="styles/earning.css"%>
        <%@include file="styles/parkingInfo.css"%>
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
            <a href="${pageContext.request.contextPath}/parkingOwner/createParking" class="menu__item">Register
                parking</a>
            <a href="${pageContext.request.contextPath}/user/logOut" class="menu__item">Log out</a>
        </c:if>
    </ul>
</div>

<h1 class="earn_title">Earnings</h1>
<div class="forms">
    <form action="/parkingOwner/Earnings" method="get" class="form_select">
        <label>
            <select name="year" class="select_input">
                <c:forEach items="${years}" var="year">
                    <option value="${year}">
                        <c:out value="${year}"/>
                    </option>
                </c:forEach>
            </select>
        </label>
        <input type="submit" value="APPLY" class="select_submit">
    </form>
</div>
<div>
    <ul class="earn__list">
        <c:forEach items="${earnings}" var="earning">
            <li class="earn__list_item">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135673.png" alt="money" width="50px"
                     height="50px" class="earn_img">
                <p class="earn__list_month">
                    <c:out value="${earning.key}"/>
                </p>
                <p class="earn__list_earning">
                    Earnings this month -
                    <c:out value="${earning.value}"/>$
                </p>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
