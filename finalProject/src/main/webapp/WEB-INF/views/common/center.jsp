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
        
        a {
        color: #FFFFFF; /* 기본 글자 색상 흰색 */
        text-decoration: none; /* 모든 a 태그에 밑줄 없애기 */
        transition: color 0.3s ease, background-color 0.3s ease; /* 부드러운 전환 효과 */
    }

    /* 글자 호버 */
    a:hover {
        color: black; 
        text-decoration: none; /* hover 상태에서도 밑줄 없애기 */
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

#first {
        font-size: 40px;
        font-weight: bold;
        margin-top: 20px;
        animation: shine 2s infinite alternate;
    }

    @keyframes shine {
        from {
            color: #333;
            text-shadow: none;
        }
        to {
            color: #fff;
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.8),
                         0 0 20px rgba(255, 255, 255, 0.5),
                         0 0 30px rgba(255, 255, 255, 0.3);
        }
    }

 /* 제목 스타일 */
        h1 {
            position: relative;
            padding: 0;
            margin: 0;
            font-family: "Raleway", sans-serif;
            font-weight: 300;
            font-size: 40px;
            color: #080808;
            transition: all 0.4s ease 0s;
        }
        h1 span {
            display: block;
            font-size: 0.5em;
            line-height: 1.3;
        }
        h1 em {
            font-style: normal;
            font-weight: 600;
        }

        .nine h1 {
            text-align: center;
            font-size: 50px;
            text-transform: uppercase;
            color: #222;
            letter-spacing: 1px;
            font-family: "Playfair Display", serif;
            font-weight: 400;
        }
        .nine h1 span {
            margin-top: 5px;
            font-size: 15px;
            color: #444;
            word-spacing: 1px;
            font-weight: normal;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-family: "Raleway", sans-serif;
            font-weight: 500;
            display: grid;
            grid-template-columns: 1fr max-content 1fr;
            grid-template-rows: 27px 0;
            grid-gap: 20px;
            align-items: center;
        }
        .nine h1 span:after, .nine h1 span:before {
            content: " ";
            display: block;
            border-bottom: 1px solid #ccc;
            border-top: 1px solid #ccc;
            height: 5px;
            background-color: #f8f8f8;
        }
        
        /**/
        /* 전체 컨테이너 */
    .comments-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }

    /* 댓글 컨테이너 */
    .comment {
        margin-bottom: 20px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        transition: box-shadow 0.3s ease-in-out;
    }

    .comment:hover {
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    /* 댓글 헤더 */
    .comment-header {
        padding: 16px;
        background-color: #f8f8f8;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #eee;
    }

    /* 작성자 이름 */
    .comment-author {
        padding: 16px;
        font-weight: bold;
        font-size: 18px;
        color: #333;
        margin-bottom: 1px; /* 이름과 내용 사이 간격 */
    }

    /* 작성일 */
    .comment-date {
        font-size: 14px;
        color: #888;
    }

    /* 댓글 본문 */
    .comment-content {
        padding: 16px;
        color: #555;
        line-height: 1.6;
    }
        

         body, ul, li, h1 {
        margin: 0;
        padding: 0;
        list-style: none;
    }
    
     a {
        color: #FFFFFF; /* 기본 글자 색상 흰색 */
        text-decoration: none; /* 모든 a 태그에 밑줄 없애기 */
        transition: color 0.3s ease, background-color 0.3s ease; /* 부드러운 전환 효과 */
    }

    /* 글자 호버 */
    a:hover {
        color: black; 
        text-decoration: none; /* hover 상태에서도 밑줄 없애기 */
    }
    
     body {
        background: rgb(255, 255, 255);
        font-family: Arial, sans-serif;
    }

        .like-icon {
            font-size: 36px; /* Increase the size as desired */
            cursor: pointer;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }

    

        .posts {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .post {
            width: 23%;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-bottom: 20px;
            padding: 10px;
            text-align: left;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .post:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .post img {
            width: 100%;
            height: auto;
            border-radius: 10px 10px 0 0;
        }

        .post-title {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }

        .post-content {
            font-size: 14px;
            margin-bottom: 10px;
        }


        /* 상세보기 모달 스타일 */
        .modal {
        display: none; /* 초기에 숨겨진 상태 */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

        .modal-content {
        background-color: #fefefe;
        margin: 10% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 800px;
        border-radius: 8px;
        position: relative;
    }

    .modal-close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    .modal-close:hover,
    .modal-close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    /* 댓글 섹션 레이아웃 */
    .comment-section {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }

    /* 댓글 목록 컨테이너 */
    .comments-list-container {
        flex: 1;
        margin-right: 20px;
    }

    .comments-list {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 10px;
        max-height: 200px; /* 필요에 따라 댓글 목록의 최대 높이 조정 */
        overflow-y: auto;
    }

    /* 댓글 작성 폼 컨테이너 */
    .comment-form-container {
        flex: 0.7;
    }

    /* 댓글 작성 폼 스타일 */
    .comment-form-container textarea {
        margin-top: 10px;
       }
    
    
    
    
    

        .star {
            font-size: 30px; /* 별의 크기 조정 */
            cursor: pointer;
            transition: color 0.3s; /* 색상 변화 애니메이션 */
        }

        .star:hover {
            color: gold; /* 마우스 호버 시 색상 변경 */
        }

        @media (max-width: 768px) {
            .post {
                width: 48%;
                margin-bottom: 20px;
            }
        }

        @media (max-width: 576px) {
            .post {
                width: 98%;
                margin-bottom: 20px;
            }

            .search-bar input {
                width: 70%;
                margin-bottom: 10px;
            }

            .search-bar button {
                width: 25%;
            }
        }
        
        /*검색창*/
        
.search-bar {
    display: flex;
    align-items: center;
    justify-content: center; /* 수평 중앙 정렬 */
    background-color: #f0f0f0;
    padding: 4px 8px; /* 위아래 여백 조정 */
    border-radius: 20px;
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    width: 700px; /* 원하는 너비로 조정 */
    margin: 0 auto; /* 가운데 정렬을 위한 왼쪽/오른쪽 자동 마진 설정 */
}

#searchInput {
    flex: 1;
    border: none;
    padding: 8px;
    font-size: 16px;
    outline: none;
    background: none;
}

button {
        padding: 8px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        font-size: 16px;
        margin-left: 10px;
        transition: background-color 0.3s ease;
        width: 80px; /* 원하는 너비로 조정 */
    }

    button:hover {
        background-color: #0056b3;
    }

.btn-rounded {
        border-radius: 20px; /* 원하는 정도로 조정 */
    }
    
    /*별 크기*/
     .starReview {
        font-size: 36px; /* 원하는 크기로 조정 */
        cursor: pointer;
        transition: color 0.3s; /* 색상 변화 애니메이션 */
    }

    .starReview:hover {
        color: gold; /* 마우스 호버 시 색상 변경 */
    }
    </style>
</head>
<body>

<br>

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
<hr>

<div id="first">
 　　　　　　　ＣＡＲＯＵＳＥＬ
</div>
<hr>
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
        
        <br><br>
        <hr>
<div id="first">
 　　　　　　　ＴＯＰ ３ ＴＯＩＬＥＴ ＲＡＮＫＩＮＧ
</div>
<hr>
        
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
<br><br><br><br><br><br><br><br><br><br>
</body>
</html>