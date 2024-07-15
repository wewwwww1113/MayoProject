<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    header {
    background: gray;
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #fff;
}

header a {
    color: inherit;
    text-decoration: none;
}
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
		    text-align: center; /* 텍스트 가운데 정렬 */
		    align-items: center; /* 추가 */
		    justify-content: center; /* 추가 */
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
		    display: inline-block;
		    vertical-align: middle; /* 추가 */
		}

        #cham {
            font-family: "Hi Melody", sans-serif;
            font-size: 120px;
        }
        .top3-container {
		    display: flex;
		    justify-content: space-around;
		    margin-bottom: 20px;
		}

	.top3-box {
	    position: relative;
	    overflow: hidden;
	    border-radius: 50px;
	    background-color: #f9f9f9;
	    width: 30%;
	    text-align: center;
	    margin: 10px;
	    padding: 20px;
	    border: 1px solid transparent;
	    animation: pulse-border 2s linear infinite, glow-shadow 2s linear infinite;
	    box-shadow: 0 0 5px silver, 0 0 10px silver, 0 0 15px silver;
	}
	.gold-crown::before {
    content: "🥇"; /* 금메달 아이콘 */
    color: gold;
    font-size: 48px; 
}

.silver-crown::before {
    content: "🥈"; /* 은메달 아이콘 */
    color: silver;
    font-size: 48px; 
}

.bronze-crown::before {
    content: "🥉"; /* 동메달 아이콘 */
    color: #cd7f32;
    font-size: 48px; 
}
.rank-list {
    display: flex;
    justify-content: space-between;
    margin: 20px auto;
    width: 80%;
    max-width: 7800px;
}

	
	.toilet-name {
	    font-weight: bold;
	    font-size: 1.5em; 
	    margin-bottom: 10px;
	}
	
	.toilet-rating {
	    color: #888;
	    margin-top: 10px;
	}
	
	@keyframes pulse-border {
    0% {
        border-color: transparent; /* 처음에는 투명 */
    }
    25% {
        border-color: gold; /* 0%에서 25%까지 점진적으로 금색으로 테두리 색상 변경 */
    }
    75% {
        border-color: gold; /* 25%에서 75%까지 일정한 금색 유지 */
    }
    100% {
        border-color: transparent; /* 75%에서 100%까지 다시 투명해짐 */
    }
}

@keyframes glow-shadow {
    0% {
        box-shadow: 0 0 5px silver, 0 0 10px silver, 0 0 15px silver; /* 초기에는 후광 효과를 은색으로 설정 */
    }
    50% {
        box-shadow: 0 0 5px silver, 0 0 12px silver, 0 0 18px silver; /* 0%에서 50%까지 효과가 늘어남 */
    }
    100% {
        box-shadow: 0 0 5px silver, 0 0 10px silver, 0 0 15px silver; /* 50%에서 100%까지 다시 후광 효과를 은색으로 설정 */
    }
}
    </style>
</head>
<body>

<br><br><br><br><br>

<c:choose>
    <c:when test="${empty loginUser}">
        <div class="center-content">
            <div class="center-title">
                화장실 정보 공유 플랫폼,
                <div id="cham">참지마요</div>
            </div>
            <br><a href="login.me" class="signup-button"><span><br>SIGN-UP</span></a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="image-container">
            <div>
                <img src="resources/uploadFiles/plan1.png" alt="이미지1">
            </div>
            <div>
                <img src="resources/uploadFiles/plan2.png" alt="이미지2">
            </div>
            <div>
                <img src="resources/uploadFiles/plan3.png" alt="이미지3">
            </div>
        </div>
        <br><br><br><br><br>
        <div id="rank-list" class="rank-list">
</div>
    </c:otherwise>
</c:choose>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
        $('.image-container').slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            autoplay: true,
            autoplaySpeed: 2200,
            dots: false,
            arrows: false
        });

        // AJAX 요청
        $.ajax({
            url: 'rank2.ra', // 서버 URL 설정
            type: 'GET',
            dataType: 'json',
            success: function(response) {
                populateRankList(response);
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 오류:', error);
            }
        });
    });

    function populateRankList(data) {
        var rankListDiv = $('#rank-list');
        rankListDiv.empty();
        
        for (var i = 0; i < Math.min(3, data.avg.length); i++) {
            var toiletNo = data.avg[i].toiletNo;
            var starRating = convertToStarRating(data.avg[i].starAvg);

            var toilet = data.toilets.find(t => t.toiletNo === toiletNo);
            var toiletName = toilet ? toilet.toiletName : "이름 없음";

            var crownClass = '';
            if (i === 0) {
                crownClass = 'gold-crown';
            } else if (i === 1) {
                crownClass = 'silver-crown';
            } else if (i === 2) {
                crownClass = 'bronze-crown';
            }

            rankListDiv.append(
            	    '<div class="top3-box ' + crownClass + '">' +
            	    '<div class="toilet-name">' + (i + 1) + '위: <br>' + toiletName + '</div>' +
            	    '<div class="toilet-rating">' + starRating + '</div>' +
            	    '<div class="crown-icon"></div>' +
            	    '</div>'
            	);
        }
    }
    function convertToStarRating(starAvg) {
        let rating = parseFloat(starAvg);
        if (rating >= 0.0 && rating < 2.0) {
            return '★☆☆☆☆ (' + rating.toFixed(1) + ')';
        } else if (rating >= 2.0 && rating < 3.0) {
            return '★★☆☆☆ (' + rating.toFixed(1) + ')';
        } else if (rating >= 3.0 && rating < 4.0) {
            return '★★★☆☆ (' + rating.toFixed(1) + ')';
        } else if (rating >= 4.0 && rating < 5.0) {
            return '★★★★☆ (' + rating.toFixed(1) + ')';
        } else if (rating === 5.0) {
            return '★★★★★ (' + rating.toFixed(1) + ')';
        } else {
            return '평가 없음';
        }
    }
</script>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</body>
</html>