<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 06.05.2022
  Time: 20:45
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
    <link rel="stylesheet" href="./styles/allAbonements.css">
    <style>
        <%@include file="styles/allAbonements.css"%>
    </style>
    <title>All abonements</title>
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

<h1 class="abonements_title">Abonnements</h1>

<form action="/user/searchAbonnements" method="get" class="search_form">
    <div class="search-from__controller">
        <input type="number" placeholder="Search" required name="parameter" class="search-form__input">
    </div>
    <div class="search-from__controller">
        <input type="radio" id="contactChoice1" name="searchBy" value="Price" checked class="search-form__radio">
        <label for="contactChoice1" class="search-form__label">Price</label>
        <input type="radio" id="contactChoice2" name="searchBy" value="Amount" class="search-form__radio">
        <label for="contactChoice2" class="search-form__label">Amount</label>
        <input type="radio" id="contactChoice3" name="searchBy" value="Discount" class="search-form__radio">
        <label for="contactChoice2" class="search-form__label">Discount</label>
    </div>
    <input type="submit" value="Search" class="search-form__btn"/>
</form>

<div class="container">
    <ul class="abonements__list">

        <c:forEach var="abonnement" items="${abonnements}">
            <li class="abonements__list_item">
                <div class="list_item_container">
                    <img src="https://cdn-icons.flaticon.com/png/512/3629/premium/3629873.png?token=exp=1654804144~hmac=d21bd529a454924f71d2f9b3ff6dca63"
                         alt="car" width="50px" height="50px" class="list_item_img">
                    <div class="list_item_name-street">
                        <p class="list_item_name">
                            <c:out value="${abonnement.key.name}"/>
                        </p>
                        <p class="abonement_price">Price -
                            <c:out value="${abonnement.key.price}"/>$
                        </p>
                        <div class="list_item_name-price">
                            <p>
                                <c:out value="${abonnement.key.discount}"/>
                            </p>
                            <p>
                                <c:out value="${abonnement.key.amount}"/>
                            </p>
                        </div>
                    </div>
                    <hr>
                    <div>
                        <p class="list_item_time"><span>Start date:
                                <c:out value="${abonnement.key.startDate}"/>
                            </span> <span>End date:
                                <c:out value="${abonnement.key.endDate}"/>
                            </span></p>
                    </div>
                </div>
                <c:if test="${abonnement.value==false}">
                    <form action="/user/buyAbonnements?abonId=${abonnement.key.id}" method="post">
                        <input type="submit" value="Buy" class="btn_buy"/>
                    </form>
                </c:if>
                <c:if test="${abonnement.value==true}">
                    <p class="abonement_bought">Bought</p>
                </c:if>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
