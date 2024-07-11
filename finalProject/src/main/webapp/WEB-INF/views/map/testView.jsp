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
            height: 90%;
            width: 70%;
        }
        .map-container {
            position: relative;
            height: 100%;
        }
        .control-container {
            position: absolute;
            top: 10px;
            left: 25%;
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
        .info-panel {
		    position: absolute;
		    top: 0;
		    right: 0;
		    width: 30%;
		    height: 100%;
		    background-color: #fff;
		    padding: 20px;
		    box-sizing: border-box;
		    overflow-y: auto;
		    z-index: 1; /* 정보 패널이 제어 요소 위에 표시되도록 z-index 설정 */
		}
    </style>
    <!-- Google Maps API -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAaPxCr1XL1mqEFAUAz8fUCSAOHhTMfrNU&libraries=places&callback=initMap" async defer></script>
</head>
<body>
    <div class="map-container">
    <div id="map"></div>

    <!-- 제어 요소를 포함할 div -->
    <div class="control-container">
        <!-- 장소 검색 입력란 -->
        <input type="text" id="place-input" placeholder="Enter an address" class="custom-map-control-button">
        <!-- 현재 위치 찾기 버튼 -->
        <button class="custom-map-control-button" id="locationButton">현재 위치 찾아볼까요~?</button>
    </div>

    <div id="info-panel" class="info-panel"></div>
</div>

    <script>
        let map, infoWindow;

        function initMap() {
            // 초기 맵 설정
            map = new google.maps.Map(document.getElementById("map"), {
                center: { lat: 37.5, lng: 127 }, // 초기 위치는 서울로 설정
                zoom: 12,
            });
            infoWindow = new google.maps.InfoWindow();

            // 현재 위치 찾기 버튼 클릭 시 동작
            const locationButton = document.getElementById("locationButton");
            locationButton.addEventListener("click", () => {
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(
                        (position) => {
                            const pos = {
                                lat: position.coords.latitude,
                                lng: position.coords.longitude,
                            };
                            
                            // 현재 위치로 지도 중심 설정
                            infoWindow.setPosition(pos);
                            infoWindow.setContent("현재 위치입니다.");
                            infoWindow.open(map);
                            map.setCenter(pos);
                            map.setZoom(17); // 지도 줌 레벨 조정
                        },
                        () => {
                            handleLocationError(true, infoWindow, map.getCenter());
                        }
                    );
                } else {
                    handleLocationError(false, infoWindow, map.getCenter());
                }
            });

            // 장소 검색 기능 설정
            const input = document.getElementById('place-input');
            const searchBox = new google.maps.places.SearchBox(input);

            // 장소 검색 이벤트 처리
            searchBox.addListener('places_changed', () => {
                const places = searchBox.getPlaces();

                if (places.length == 0) {
                    return;
                }

                // 검색된 장소들을 지도에 표시
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
                        /* icon: {
                            url: 'resources/uploadFiles/똥.jpg', // 사용자 정의 마커 이미지 경로
                            scaledSize: new google.maps.Size(30, 30) // 이미지 크기 조정
                        } */
                        
                    });

                    // 검색된 장소들에 맞게 지도 bounds 조정
                    if (place.geometry.viewport) {
                        bounds.union(place.geometry.viewport);
                    } else {
                        bounds.extend(place.geometry.location);
                    }

                    // 마커 클릭 시 정보창 표시
                    marker.addListener('click', () => {
                        infoWindow.setContent(`<div><strong>${place.name}</strong><br>${place.formatted_address}</div>`);
                        infoWindow.open(map, marker);
                        updateInfoPanel(`<strong>${place.name}</strong><br>${place.formatted_address}`);
                    });
                });

                // 검색된 장소들에 맞게 지도 중심 및 줌 레벨 조정
                map.fitBounds(bounds);
            });

            fetch("list.ma")
            .then(response => response.json())
            .then(data => {
                data.forEach(toilet => {
                    const toiletPos = { lat: toilet.latitude, lng: toilet.longitude };
                    const toiletMarker = new google.maps.Marker({
                        position: toiletPos,
                        map: map,
                        title: toilet.toiletName
                        /* icon: {
                            url: 'resources/uploadFiles/똥.jpg', // 사용자 정의 마커 이미지 경로
                            scaledSize: new google.maps.Size(30, 30) // 이미지 크기 조정
                        } */
                        /* icon: {
                            url: 'https://search.pstatic.net/sunny/?src=https%3A%2F%2Fcdn-icons-png.freepik.com%2F256%2F2619%2F2619403.png&type=a340', // 사용자 정의 마커 이미지 경로
                            scaledSize: new google.maps.Size(30, 30) // 이미지 크기 조정
                        } */
                    });

                    // 화장실 정보를 포함한 정보창 설정
                    toiletMarker.addListener('click', () => {
                        // 데이터 구조에 맞게 변수명을 수정하세요
                        const toiletName = toilet.toiletName || '화장실 이름 없음';
                        const toiletAddress = toilet.toiletAddress || '주소 정보 없음';
                        const toiletMhB = toilet.toiletMhB || '0';
                        const toiletWhB = toilet.toiletWhB || '0';
                        const toiletOpen = toilet.toiletOpen || '개방 시간 정보 없음';
                        const toiletSeat = toilet.toiletSeat || '정보 없음';
                        const toiletSafeBell = toilet.toiletSafeBell || '정보 없음';
                        const toiletDiaper = toilet.toiletDiaper || '정보 없음';
                        const toiletUpdate = toilet.toiletUpdate || '정보 없음';
                        const contentString = `
                            <div>
                                <h2>`+toiletName+`</h2>
                                <p>`+toiletAddress+`</p>
                                <p>개방 시간: `+toiletOpen+`</p>
                            </div>
                        `;
                        const contentString2 = `
                            <div>
                                <h1>`+toiletName+`</h1>
                                <p>`+toiletAddress+`</p>
                                <p>개방 시간: `+toiletOpen+`</p>
                                <p>좌변기 종류: `+toiletSeat+`</p>
                                <p>비상벨 유무: `+toiletSafeBell+`</p>
                                <p>기저귀 교환대 유무: `+toiletDiaper+`</p>
                                <p>최근 업데이트 일자: `+toiletUpdate+`</p>
                            </div>
                        `;
						console.log(contentString);
                        infoWindow.setContent(contentString);
                        infoWindow.open(map, toiletMarker);
                        updateInfoPanel(contentString2);
                    });
                });
            })
            .catch(error => console.error('Error fetching toilet data:', error));
        }
	
     // 정보 패널 업데이트 함수
        function updateInfoPanel(content) {
            const infoPanel = document.getElementById('info-panel');
            infoPanel.innerHTML = content;
        }
     // 마커 클릭 시 정보창 및 정보 패널 업데이트
        marker.addListener('click', () => {
            infoWindow.setContent(`<div><strong>${place.name}</strong><br>${place.formatted_address}</div>`);
            infoWindow.open(map, marker);
            updateInfoPanel(`<strong>${place.name}</strong><br>${place.formatted_address}`);
        });

        // 위치 정보 오류 처리 함수
        function handleLocationError(browserHasGeolocation, infoWindow, pos) {
            infoWindow.setPosition(pos);
            infoWindow.setContent(
                browserHasGeolocation ?
                "Error: The Geolocation service failed." :
                "Error: Your browser doesn't support geolocation."
            );
            infoWindow.open(map);
        }
    </script>
</body>
</html>
