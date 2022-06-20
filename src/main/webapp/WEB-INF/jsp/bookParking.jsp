<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 05.05.2022
  Time: 19:48
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
    <link rel="stylesheet" href="./styles/bookParking.css">
    <style>
        <%@include file="styles/bookParking.css"%>
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

<h1 class="book_title">Book Parking</h1>

<form action="${pageContext.request.contextPath}/user/applyParking" method="get" class="book_form">
    <div class="book__form_controller">
        <label for="carNumber" class="book_label">Car</label>
        <input name="carNumber" list="userCars" required class="book_input">
        <datalist id="userCars">
            <c:forEach var="car" items="${userCars}">
            <option value="${car.number}">
                </c:forEach>
        </datalist>
    </div>
    <div class="book__form_controller">
        <label for="abonnementName" class="book_label">Abonnement</label>
        <input name="abonnementName" list="userAbonnements" required class="book_input">
        <datalist id="userAbonnements">
            <c:forEach var="abonnement" items="${userAbonnements}">
            <option value="${abonnement.name}">
                </c:forEach>
        </datalist>
    </div>
    <div class="book__form_controller">
        <label for="startDate" class="book_label">Start date</label>
        <input type="datetime-local" required name="startDate" class="book_input">
    </div>
    <div class="book__form_controller">
        <label for="endDate" class="book_label">End date</label>
        <input type="datetime-local" required name="endDate" class="book_input">
    </div>
    <input type="submit" value="submit" class="btn_submit">
</form>


<!-- <form action="${pageContext.request.contextPath}/user/applyParking" method="get">
  Car:  <input name="carNumber" list="userCars"  required>
    <datalist id="userCars">
        <c:forEach var="car" items="${userCars}">
        <option value="${car.number}">
            </c:forEach>
    </datalist>
    <br>
  Abonnement:  <input name="abonnementName" list="userAbonnements"  required>
    <datalist id="userAbonnements">
        <c:forEach var="abonnement" items="${userAbonnements}">
        <option value="${abonnement.name}">
            </c:forEach>
    </datalist>
    <br>
    Start date <input type="datetime-local" required name="startDate">
    <br>
    End date <input type="datetime-local" required name="endDate">
    <br>
    <input type="submit" value="submit">
</form> -->
</body>
</html>

<!-- <%--<form action="${pageContext.request.contextPath}/librarian/applyOrder?applyId=${order.id}"--%>
<%--      method="post">--%>
<%--    <tr>--%>
<%--        <td></td>--%>
<%--        <td><label>--%>
<%--            Start order day:--%>
<%--            <input type="date" MIN="<dt:todayDate/>" required name="startDate"/>--%>
<%--        </label></td>--%>

<%--        <td><label>--%>
<%--            End order day:--%>
<%--            <input type="date" min="<dt:todayDate/>" required name="endDate"/>--%>
<%--        </label></td>--%>
<%--    </tr>--%>
<%--    <input type="submit" value="apply">--%>
<%--</form>--%> -->
