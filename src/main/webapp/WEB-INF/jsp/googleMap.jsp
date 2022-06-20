<%@page session="false"%>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1.0" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <link rel="stylesheet" href="./styles/googleMap.css">
    <style>
        <%@include file="styles/googleMap.css"%>
    </style>
    <title></title>
    <script
            src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&key=AIzaSyDxS8WSvbLkzJPrH2TVqfVspGs4QgSLWy8">
    </script>
    <script>
        var map;
        function initialize() {
            var mapOptions = {
                zoom: 1,
                center: new google.maps.LatLng(48.295637, 26.6949621)
            };

            // Display a map on the page
            map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions);

            // Multiple Markers
            var markers = [
                ['Kyiv, Ukraine', 50.401699,30.252508],
                ['Lviv, Ukraine', 49.8326679,23.9421957]
            ];


            // Loop through our array of markers & place each one on the map
            for( i = 0; i < markers.length; i++ ) {
                var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
                bounds.extend(position);
                marker = new google.maps.Marker({
                    position: position,
                    map: map,
                    title: markers[i][0]
                });

                // Automatically center the map fitting all markers on the screen
                map.fitBounds(bounds);
            }

            // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
            var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
                this.setZoom(14);
                google.maps.event.removeListener(boundsListener);
            });
        }

        google.maps.event.addDomListener(window, 'load', initialize);
    </script>
</head>
<body>
<div class="hamburger-menu">
    <input id="menu__toggle" type="checkbox" />
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
<div id="map-canvas" style="height:800px; width:390px;"></div>
</body>
</html>