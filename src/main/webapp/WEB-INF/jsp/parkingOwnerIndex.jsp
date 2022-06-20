<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ihorb
  Date: 10.05.2022
  Time: 16:11
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
    <link rel="stylesheet" href="./styles/parkingOwnerIndex.css">
    <link rel="stylesheet" href="./styles/applyParking.css">
    <style>
        <%@include file="styles/applyParking.css"%>
        <%@include file="styles/parkingOwnerIndex.css"%>
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

<h1 class="owner_title">Parking Owner</h1>


<div class="container">
    <c:forEach var="parking" items="${parkingList}">
        <div class="parking owner">
                <%--                <img src="./images/spaces.png" alt="car" width="50px" height="50px" class="parkingOwner_img">--%>
            <img src="https://cdn-icons-png.flaticon.com/512/2482/2482060.png"
                 alt="car" width="50px" height="50px" class="parkingOwner_img">
            <div class="parking_data">
                <p class="parking_street">
                    <c:out value="${parking.streetName}"/>
                    <c:out value="${parking.streetNumber}"/>
                </p>
                <div class="parking_price-abonement">
                    <p>Verification status:
                        <c:out value="${parking.verificationStatus}"/>
                    </p>
                    <p>Capacity:
                        <c:out value="${parking.capacity}"/>
                    </p>
                    <p>Available places:
                        <c:out value="${parking.freePlaces}"/>
                    </p>
                    <p>Price:
                        <c:out value="${parking.price}"/>$
                    </p>
                </div>
            </div>
            <hr>
            <div class="parking_links">
                <a href="/parkingOwner/updateParking?parkingId=${parking.id}" class="parking_link">
                    Update parking
                </a>
                |
                <a href="/parkingOwner/parkingInfo?parkingId=${parking.id}" class="parking_link">
                    Information about parking
                </a>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html>
