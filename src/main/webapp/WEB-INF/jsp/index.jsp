<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 03.05.2022
  Time: 19:05
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
    <title>Main</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;700&family=Roboto&display=swap"
          rel="stylesheet">
    <!-- <link rel="stylesheet" href="https://unpkg.com/flowbite@1.4.5/dist/flowbite.min.css" /> -->
    <link rel="stylesheet" href="./styles/index.css">
    <style>
        <%@include file="styles/index.css"%>

    </style>

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
        <a href="${pageContext.request.contextPath}/" class="menu__item">Map
            <a href="${pageContext.request.contextPath}/user/logOut" class="menu__item">Log out</a>
        </c:if>
    </ul>
</div>

<h1 class="title">OnlineParking</h1>

<div class="search-form__container">
    <form action="/user/searchBy" method="get" class="search-form">
        <input name="price" type="number" class="search-form__input" placeholder="Price">
        <input name="streetName" type="text" placeholder="Street name" class="search-form__input">
        <input type="submit" value="Search" class="search-form__btn">
    </form>
</div>

<form action="/user/orderBy" method="get" class="sort-form">
    <div class="sort-from__controller">
        <label for="contactChoice3" class="sort-form__label">Price</label>
        <input type="radio" id="contactChoice3" name="orderBy" value="price" checked class="sort-form__radio">
    </div>
    <div class="sort-from__controller">
        <label for="contactChoice4" class="sort-form__label">Street name</label>
        <input type="radio" id="contactChoice4" name="orderBy" value="streetName" class="sort-form__radio">
    </div>
    <input type="submit" value=Sort class="sort-form__submit">
</form>

<hr>

<div class="parkings">
    <ul class="parkings__list">
        <c:forEach var="parking" items="${parkingList}">
            <c:if test="${parking.verificationStatus=='CONFIRMED'}">
                <li class="parkings__list_item">
                    <div class="list_item_container">
                        <img src="https://cdn-icons-png.flaticon.com/512/708/708949.png" alt="car" width="50px"
                             height="50px" class="list_item_img"/>
                            <%--                        <img src="./images/parking.png" alt="car" width="50px" height="50px" class="list_item_img">--%>
                        <div class="list_item_name-street">
                            <p class="list_item_street"><c:out value="${parking.streetName}"/>
                                <c:out value="${parking.streetNumber}"/></p>
                            <div class="list_item_name-price">
                                <p>Capacity - <c:out value="${parking.freePlaces}"/></p>
                                <p><c:out value="${parking.price}"/>$</p>
                            </div>
                        </div>
                        <hr>
                        <div>

                            <c:if test="${sessionScope.userId!=null}">
                                <c:if test="${parking.freePlaces!=0}">
                                    <a href="/user/bookParking/?parkingId=${parking.id}" class="book_link">BOOK</a>
                                </c:if>
                                <c:if test="${parking.freePlaces==0}">
                                    <p class="filled">FILLED</p>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                </li>
            </c:if>
        </c:forEach>
    </ul>
</div>

</body>
</html>
