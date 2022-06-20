<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 06.05.2022
  Time: 20:30
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
    <link rel="stylesheet" href="./styles/userAbonements.css">
    <link rel="stylesheet" href="./styles/allAbonements.css">
    <style>
        <%@include file="styles/allAbonements.css"%>
    </style>
    <style>
        <%@include file="styles/userAbonements.css"%>
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


<c:forEach var="abonnement" items="${abonnements}">
    <ul class="abonements__list">
        <li class="abonements__list_item">
            <div class="list_item_container">
                <img src="https://cdn-icons.flaticon.com/png/512/3629/premium/3629873.png?token=exp=1654804144~hmac=d21bd529a454924f71d2f9b3ff6dca63"
                     alt="car" width="50px" height="50px" class="list_item_img">
                <div class="list_item_name-street">
                    <p class="list_item_name">Abonement Name</p>
                    <p class="abonement_price">Price - 300$</p>
                    <div class="list_item_name-price">
                        <p>Discount - 100$</p>
                        <p>Amount - 200$</p>
                    </div>

                </div>
                <hr>
                <div>
                    <p class="list_item_time"><span>Start date: 12 march</span> <span>Finish date: 13 may</span></p>
                </div>
            </div>
        </li>


        <li class="abonements__list_item">
            <div class="list_item_container">
                <img src="https://cdn-icons.flaticon.com/png/512/3629/premium/3629873.png?token=exp=1654804144~hmac=d21bd529a454924f71d2f9b3ff6dca63"
                     alt="car" width="50px" height="50px" class="list_item_img">
                <div class="list_item_name-street">
                    <p class="list_item_name">
                        <c:out value="${abonnement.name}"/>
                    </p>
                    <p class="abonement_price">Price -
                        <c:out value="${abonnement.price}"/>$
                    </p>
                    <div class="list_item_name-price">
                        <p>Discount -
                            <c:out value="${abonnement.discount}"/>$
                        </p>
                        <p>Amount -
                            <c:out value="${abonnement.amount}"/>$
                        </p>
                    </div>

                </div>
                <hr>
                <div>
                    <p class="list_item_time"><span>Start date:
                            <c:out value="${abonnement.startDate}"/>
                        </span> <span>Finish date:
                            <c:out value="${abonnement.endDate}"/>
                        </span></p>
                </div>
            </div>
        </li>
    </ul>

</c:forEach>
<br>
<input type="button" value="Buy abonnements" onclick="window.location.href = '/user/abonnements/allAbonnements'"
       class="buy_btn">
</body>
</html>
