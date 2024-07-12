<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Center Content</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Hi+Melody&family=Kirang+Haerang&display=swap" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        .center-content {
            max-width: 960px;
            margin: 50px auto;
            text-align: center;
        }

        .center-title {
            font-size: 25px;
            font-weight: bold;
            color: #333;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
            margin-bottom: 20px;
        }

        .center-description {
            font-size: 24px;
            line-height: 1.6;
            color: #666;
            margin-bottom: 40px;
        }

        .image-container {
            width: 200%; /* 이미지 컨테이너의 너비를 조정 */
            max-width: 1600px; /*기억*/
            margin: 0 auto;
            box-sizing: border-box; /* border 속성의 두께가 요소의 크기에 포함되도록 설정 */
        }

        .image-container img {
            width: 100%; /* 이미지 너비를 부모 요소에 맞게 설정 */
            
            
        }

        .signup-button {
            display: inline-block;
            padding: 30px 60px;
            font-size: 36px;
            font-weight: bold;
            color: #fff;
            background-color: #808080;
            border: none;
            border-radius: 50%; /* 네모에서 동그라미로 변경 */
            text-decoration: none;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease, color 0.3s ease, box-shadow 0.3s ease;
            position: relative;
            overflow: hidden;
            width: 250px; /* 원의 크기 설정 */
            height: 250px; /* 원의 크기 설정 */
            line-height: 250px; /* 버튼 내부 텍스트의 높이를 원의 반지름에 맞추기 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }

        .signup-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(45deg, rgba(255, 255, 255, 0.5) 20%, transparent 50%, rgba(255, 255, 255, 0.5) 80%);
            background-size: 200% 200%;
            transition: background-position 0.5s ease;
            border-radius: 50%; /* 네모에서 동그라미로 변경 */
            z-index: 0;
        }

        .signup-button:hover::before {
            background-position: right bottom;
        }

        .signup-button:hover {
            background-color: #333;
            color: #fff;
            box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.5);
        }

        .signup-button span {
            position: relative;
            z-index: 1;
        }

        #cham {
            font-family: "Hi Melody", sans-serif;
            font-size: 120px;
        }
    </style>
</head>
<body>

<br><br><br><br><br>

<c:choose>
    <c:when test="${empty loginUser }">


        <div class="center-content">
            <div class="center-title">
                화장실 정보 공유 플랫폼,
                <div id="cham">참지마요</div>
            </div>

            <br> <a href="login.me" class="signup-button"><span>SIGN-UP</span></a>

        </div>

    </c:when>
    <c:otherwise>


        <div class="image-container">
            <div>
                <img src="resources/uploadFiles/plan1.png" alt="이미지1">
            </div>
            <div>
                <img src="resources/uploadFiles/plan2.png" alt="이미지1">
            </div>
            <div>
                <img src="resources/uploadFiles/plan3.png" alt="이미지1">
            </div>
            
        </div>

		${t}


    </c:otherwise>
</c:choose>



</body>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('.image-container').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 2200, /*1578X520 속도*/
            dots: false, // 네비게이션 동그라미 버튼 없애기
            arrows: false
        });
     
	
	
	});
</script>

</html>