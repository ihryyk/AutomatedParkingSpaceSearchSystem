<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 04.05.2022
  Time: 20:03
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
    <link rel="stylesheet" href="./styles/showCar.css">
    <link rel="stylesheet" href="./styles/applyParking.css">
    <style>
        <%@include file="styles/applyParking.css"%>
        <%@include file="styles/showCar.css"%>
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

<h1 class="car_title">Cars</h1>

<div class="container">
    <c:forEach var="car" items="${carList}">
        <div class="parking owner">
            <img src="https://cdn-icons.flaticon.com/png/512/2962/premium/2962303.png?token=exp=1654803723~hmac=512b9574a17e76d30fcf05a0258c728f"
                 alt="car" width="50px" height="50px" class="car_img">
            <div class="parking_data">
                <div class="parking_price-abonement">
                    <p>Brand:
                        <c:out value="${car.brand}"/>
                        <c:out value="${parking.verificationStatus}"/>
                    </p>
                    <p>Car Number:
                        <c:out value="${car.number}"/>
                    </p>
                    <!-- <p>Price:
                            <c:out value="${parking.price}" />$
                        </p> -->
                </div>
            </div>
            <hr>
            <form action="/user/deleteCar/?carId=${car.id}" method="post"
                  style="display: flex; justify-content:center;">
                <input type="submit" value="DELETE" class="btn_delete">
            </form>
        </div>
    </c:forEach>
</div>

<input type="button" value="add" onclick="window.location.href = '/user/profile/addCar'" class="add_car">

</body>
</html>
