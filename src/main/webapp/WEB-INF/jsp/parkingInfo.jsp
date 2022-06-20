<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 10.05.2022
  Time: 17:20
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
    <link rel="stylesheet" href="./styles/parkingInfo.css">
    <link rel="stylesheet" href="./styles/activeparking.css">
    <style>
        <%@include file="styles/activeparking.css"%>
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

<h1 class="parkingInfo_title">Parking Info</h1>

<div class="forms">
    <form action="/parkingOwner/parkingInfo" method="get" class="form_select">
        <label>
            <select name="parkingStatus" class="select_input">
                <c:forEach items="${parkingStatus}" var="status">
                    <option value="${status}">
                        <c:out value="${status}"/>
                    </option>
                </c:forEach>
            </select>
            <input name="sort" value="parkingStatus" style="display: none">
        </label>
        <input type="submit" value="APPLY" class="select_submit">
    </form>

    <form action="/parkingOwner/parkingInfo" method="get" class="form_select">
        <label>
            <select name="month" class="select_input">
                <c:forEach items="${months}" var="month">
                    <option value="${month.value}">
                        <c:out value="${month.key}"/>
                    </option>
                </c:forEach>
            </select>
        </label>
        <input name="sort" value="month" style="display: none">
        <input type="submit" value="APPLY" class="select_submit">
    </form>
</div>


<a href="/parkingOwner/Earnings" class="earn_link">
    Earnings
</a>

<div class="container">
    <ul class="parkings__list">
        <c:forEach var="parkingInform" items="${parkingInfoList}">
        <li class="parkings__list_item">
            <div class="list_item_container">
                <img src="https://cdn-icons-png.flaticon.com/512/708/708949.png" alt="car" width="50px" height="50px"
                     class="list_item_img">
                <div class="list_item_name-street">
                    <p class="list_item_street">
                        <c:out value="${parkingInform.parking.streetName}"/>/
                        <c:out value="${parkingInform.parking.streetNumber}"/>
                    </p>
                    <div class="list_item_name-price">
                        <p>
                            <c:out value="${parkingInform.abonnement.name}"/>
                        </p>
                        <p>
                            <c:out value="${parkingInform.car.number}"/>
                        </p>
                        <p>
                            <c:out value="${parkingInform.parking.price}"/>$
                        </p>
                    </div>

                </div>
                <hr>
                <div>
                    <p class="list_item_time"><span>Start time:
                                <c:out value="${parkingInform.startTime}"/>
                            </span> <span>Finish time:
                                <c:out value="${parkingInform.endTime}"/>
                            </span></p>
                </div>
                <p style="text-align: center; font-size: 24px;">Status:
                    <c:out value="${parkingInform.parkingStatus}"/>
                </p>
            </div>
            <c:forEach items="${info}" var="value">
                <c:out value="${value.key}"/>:
                <c:out value="${value.value}"/>
                <br>
            </c:forEach>
            </c:forEach>
            <c:if test="${month!=null}">
                <a href="/parkingOwner/getPDF?month=${month}">
                    PDF
                </a>
            </c:if>
        </li>
    </ul>
</div>

</body>
</html>
