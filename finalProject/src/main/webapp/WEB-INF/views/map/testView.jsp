<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Google Maps with Geolocation and Search</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height: 100%;
            width: 100%;
        }
        .map-container {
            position: relative;
            height: 100%;
        }
        .control-container {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            align-items: center;
            z-index: 1;
            padding: 0 10px;
        }
        .custom-map-control-button {
            background-color: #fff;
            border: 0;
            border-radius: 2px;
            box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
            margin-left: 10px;
            padding: 0 0.5em;
            font: 400 18px Roboto, Arial, sans-serif;
            overflow: hidden;
            height: 40px;
            cursor: pointer;
        }
        .custom-map-control-button:hover {
            background: rgb(235, 235, 235);
        }
    </style>
    <script async defer type="module" src="https://unpkg.com/@googlemaps/extended-component-library@0.6"></script>
</head>
<body>
    <div class="map-container">
        <div id="map"></div>
        <div class="control-container">
            <gmpx-place-picker placeholder="Enter an address"></gmpx-place-picker>
            <button class="custom-map-control-button" id="locationButton">현재 위치 찾아볼까요~?</button>
        </div>
    </div>

    <!-- The `defer` attribute causes the script to execute after the full HTML document has been parsed. -->
    <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAaPxCr1XL1mqEFAUAz8fUCSAOHhTMfrNU&callback=initMap&v=weekly" defer></script>
    <script>
    let map, infoWindow;

    function initMap() {
        map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 34.397, lng: 115.644 },
            zoom: 6,
        });
        infoWindow = new google.maps.InfoWindow();

        // 현재 위치 찾기 버튼
        const locationButton = document.getElementById("locationButton");
        locationButton.addEventListener("click", () => {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    (position) => {
                        const pos = {
                            lat: position.coords.latitude,
                            lng: position.coords.longitude,
                        };

                        infoWindow.setPosition(pos);
                        infoWindow.setContent("현재 위치입니다.");
                        infoWindow.open(map);
                        map.setCenter(pos);
                    },
                    () => {
                        handleLocationError(true, infoWindow, map.getCenter());
                    }
                );
            } else {
                handleLocationError(false, infoWindow, map.getCenter());
            }
        });

        // 장소 검색기능
        const placePicker = document.querySelector('gmpx-place-picker');
        const marker = new google.maps.Marker({ map: map });
        const infowindow = new google.maps.InfoWindow();

        placePicker.addEventListener('gmpx-placechange', () => {
            const place = placePicker.value;

            if (!place.location) {
                window.alert("No details available for input: '" + place.name + "'");
                infowindow.close();
                marker.setPosition(null);
                return;
            }

            if (place.viewport) {
                map.fitBounds(place.viewport);
            } else {
                map.setCenter(place.location);
                map.setZoom(17);
            }

            marker.setPosition(place.location);
            infowindow.setContent(
                `<strong>${place.displayName}</strong><br>
                <span>${place.formattedAddress}</span>`
            );
            infowindow.open(map, marker);
        });

        // DB에서 데이터를 가져와서 지도에 표시
        fetch("list.ma")
        .then(response => response.json())
        .then(data => {
            data.forEach(toilet => {
                const toiletPos = { lat: toilet.latitude, lng: toilet.longitude };
                const toiletMarker = new google.maps.Marker({
                    position: toiletPos,
                    map: map,
                    title: toilet.toiletName
                });

                toiletMarker.addListener('click', () => {
                    infoWindow.setContent(
                        `<div>
                            <h2>${toilet.toiletName}</h2>
                            <p>${toilet.toiletAddress}</p>
                            <p>남성 화장실: ${toilet.toiletMhB} / 여성 화장실: ${toilet.toiletWhB}</p>
                            <p>개방 시간: ${toilet.toiletOpen}</p>
                        </div>`
                    );
                    infoWindow.open(map, toiletMarker);
                });
            });
        })
        .catch(error => console.error('Error fetching toilet data:', error));
    }

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(
            browserHasGeolocation
                ? "Error: The Geolocation service failed."
                : "Error: Your browser doesn't support geolocation."
        );
        infoWindow.open(map);
    }

    window.initMap = initMap;
</script>
</body>
</html>
 --%>
<%--  <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Google Maps with Geolocation and Search</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height: 100%;
            width: 100%;
        }
        .map-container {
            position: relative;
            height: 100%;
        }
        .control-container {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            align-items: center;
            z-index: 1;
            padding: 0 10px;
        }
        .custom-map-control-button {
            background-color: #fff;
            border: 0;
            border-radius: 2px;
            box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
            margin-left: 10px;
            padding: 0 0.5em;
            font: 400 18px Roboto, Arial, sans-serif;
            overflow: hidden;
            height: 40px;
            cursor: pointer;
        }
        .custom-map-control-button:hover {
            background: rgb(235, 235, 235);
        }
    </style>
    <script async defer type="module" src="https://unpkg.com/@googlemaps/extended-component-library@0.6"></script>
</head>
<body>
    <div class="map-container">
        <div id="map"></div>
        <div class="control-container">
            <gmpx-place-picker placeholder="Enter an address"></gmpx-place-picker>
            <button class="custom-map-control-button" id="locationButton">현재 위치 찾아볼까요~?</button>
        </div>
    </div>

    <!-- The `defer` attribute causes the script to execute after the full HTML document has been parsed. -->
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAaPxCr1XL1mqEFAUAz8fUCSAOHhTMfrNU&callback=initMap&libraries=&v=weekly"
        defer></script>
    <script>
        let map, infoWindow;

        function initMap() {
            map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: 34.397, lng: 115.644 },
                zoom: 6,
            });
            infoWindow = new google.maps.InfoWindow();

            // 현재 위치 찾기 버튼
            const locationButton = document.getElementById("locationButton");
            locationButton.addEventListener("click", () => {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(
                        (position) => {
                            const pos = {
                                lat: position.coords.latitude,
                                lng: position.coords.longitude,
                            };

                            infoWindow.setPosition(pos);
                            infoWindow.setContent("현재 위치입니다.");
                            infoWindow.open(map);
                            map.setCenter(pos);
                        },
                        () => {
                            handleLocationError(true, infoWindow, map.getCenter());
                        }
                    );
                } else {
                    handleLocationError(false, infoWindow, map.getCenter());
                }
            });

            // 장소 검색기능
            const placePicker = document.querySelector('gmpx-place-picker');
            const marker = new google.maps.Marker({ map: map });
            const infowindow = new google.maps.InfoWindow();

            placePicker.addEventListener('gmpx-placechange', () => {
                const place = placePicker.value;

                if (!place.location) {
                    window.alert("No details available for input: '" + place.name + "'");
                    infowindow.close();
                    marker.setPosition(null);
                    return;
                }

                if (place.viewport) {
                    map.fitBounds(place.viewport);
                } else {
                    map.setCenter(place.location);
                    map.setZoom(17);
                }

                marker.setPosition(place.location);
                infowindow.setContent(
                    `<strong>${place.displayName}</strong><br>
                    <span>${place.formattedAddress}</span>`
                );
                infowindow.open(map, marker);
            });

            // DB에서 데이터를 가져와서 지도에 표시
            fetch("list.ma")
            .then(response => response.json())
            .then(data => {
                data.forEach(toilet => {
                    const toiletPos = { lat: toilet.latitude, lng: toilet.longitude };
                    const toiletMarker = new google.maps.Marker({
                        position: toiletPos,
                        map: map,
                        title: toilet.toiletName
                    });

                    toiletMarker.addListener('click', () => {
                        infoWindow.setContent(
                            `<div>
                                <h2>${toilet.toiletName}</h2>
                                <p>${toilet.toiletAddress}</p>
                                <p>남성 화장실: ${toilet.toiletMhB} / 여성 화장실: ${toilet.toiletWhB}</p>
                                <p>개방 시간: ${toilet.toiletOpen}</p>
                            </div>`
                        );
                        infoWindow.open(map, toiletMarker);
                    });
                });
            })
            .catch(error => console.error('Error fetching toilet data:', error));
        }

        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(
                browserHasGeolocation
                    ? "Error: The Geolocation service failed."
                    : "Error: Your browser doesn't support geolocation."
            );
            infoWindow.open(map);
        }

        window.initMap = initMap;
    </script>
</body>
</html> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Google Maps with Geolocation and Search</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }
        #map {
            height: 100%;
            width: 100%;
        }
        .map-container {
            position: relative;
            height: 100%;
        }
        .control-container {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            align-items: center;
            z-index: 1;
            padding: 0 10px;
        }
        .custom-map-control-button {
            background-color: #fff;
            border: 0;
            border-radius: 2px;
            box-shadow: 0 1px 4px -1px rgba(0, 0, 0, 0.3);
            margin-left: 10px;
            padding: 0 0.5em;
            font: 400 18px Roboto, Arial, sans-serif;
            overflow: hidden;
            height: 40px;
            cursor: pointer;
        }
        .custom-map-control-button:hover {
            background: rgb(235, 235, 235);
        }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAaPxCr1XL1mqEFAUAz8fUCSAOHhTMfrNU&libraries=places&callback=initMap" async defer></script>
</head>
<body>
    <div class="map-container">
        <div id="map"></div>
        <div class="control-container">
            <input type="text" id="place-input" placeholder="Enter an address" class="custom-map-control-button">
            <button class="custom-map-control-button" id="locationButton">현재 위치 찾아볼까요~?</button>
        </div>
    </div>

    <script>
        let map, infoWindow;

        function initMap() {
            map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: 34.397, lng: 115.644 },
                zoom: 6,
            });
            infoWindow = new google.maps.InfoWindow();

            // 현재 위치 찾기 버튼
            const locationButton = document.getElementById("locationButton");
            locationButton.addEventListener("click", () => {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(
                        (position) => {
                            const pos = {
                                lat: position.coords.latitude,
                                lng: position.coords.longitude,
                            };

                            infoWindow.setPosition(pos);
                            infoWindow.setContent("현재 위치입니다.");
                            infoWindow.open(map);
                            map.setCenter(pos);
                        },
                        () => {
                            handleLocationError(true, infoWindow, map.getCenter());
                        }
                    );
                } else {
                    handleLocationError(false, infoWindow, map.getCenter());
                }
            });

            // 장소 검색기능
            const input = document.getElementById('place-input');
            const searchBox = new google.maps.places.SearchBox(input);

            searchBox.addListener('places_changed', () => {
                const places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                const bounds = new google.maps.LatLngBounds();
                places.forEach(place => {
                    if (!place.geometry || !place.geometry.location) {
                        console.log("Returned place contains no geometry");
                        return;
                    }

                    const marker = new google.maps.Marker({
                        map: map,
                        title: place.name,
                        position: place.geometry.location
                    });

                    if (place.geometry.viewport) {
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }

                    const infowindow = new google.maps.InfoWindow({
                        content: `<div><strong>${place.name}</strong><br>${place.formatted_address}</div>`
                    });

                    marker.addListener('click', () => {
                        infowindow.open(map, marker);
                    });
                });
                map.fitBounds(bounds);
            });

            // DB에서 데이터를 가져와서 지도에 표시
            fetch("list.ma")
            .then(response => response.json())
            .then(data => {
                data.forEach(toilet => {
                    const toiletPos = { lat: toilet.latitude, lng: toilet.longitude };
                    const toiletMarker = new google.maps.Marker({
                        position: toiletPos,
                        map: map,
                        title: toilet.toiletName
                    });

                    toiletMarker.addListener('click', () => {
                        infoWindow.setContent(
                            `<div>
                                <h2>${toilet.toiletName}</h2>
                                <p>${toilet.toiletAddress}</p>
                                <p>남성 화장실: ${toilet.toiletMhB} / 여성 화장실: ${toilet.toiletWhB}</p>
                                <p>개방 시간: ${toilet.toiletOpen}</p>
                            </div>`
                        );
                        infoWindow.open(map, toiletMarker);
                    });
                });
            })
            .catch(error => console.error('Error fetching toilet data:', error));
        }

        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(
                browserHasGeolocation
                    ? "Error: The Geolocation service failed."
                    : "Error: Your browser doesn't support geolocation."
            );
            infoWindow.open(map);
        }
    </script>
</body>
</html>
