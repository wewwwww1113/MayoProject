<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>랭킹 페이지</title>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="style.css">

<style>

/* 제목 스타일 */
h1 {
  position: relative;
  padding: 0;
  margin: 0;
  font-family: "Raleway", sans-serif;
  font-weight: 300;
  font-size: 40px;
  color: #080808;
  -webkit-transition: all 0.4s ease 0s;
  -o-transition: all 0.4s ease 0s;
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
  text-align:center; font-size:50px; text-transform:uppercase; color:#222; letter-spacing:1px;
  font-family:"Playfair Display", serif; font-weight:400;
}
.nine h1 span {
  margin-top: 5px;
    font-size:15px; color:#444; word-spacing:1px; font-weight:normal; letter-spacing:2px;
    text-transform: uppercase; font-family:"Raleway", sans-serif; font-weight:500;

    display: grid;
    grid-template-columns: 1fr max-content 1fr;
    grid-template-rows: 27px 0;
    grid-gap: 20px;
    align-items: center;
}

.nine h1 span:after,.nine h1 span:before {
    content: " ";
    display: block;
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #ccc;
    height: 5px;
  background-color:#f8f8f8;
}

    .top3-container {
        display: flex;
        justify-content: space-around;
        margin-bottom: 20px;
    }
 .top3-box {
    position: relative;
    overflow: hidden;
    border-radius: 10px;
    background-color: #f9f9f9;
    width: 30%;
    text-align: center;
    margin: 10px;
    padding: 20px;
    border: 1px solid gold; /* 테두리를 금색으로 설정 */
    animation: pulse-border 2s linear infinite, glow-shadow 2s linear infinite;
    box-shadow: 0 0 5px silver, 0 0 10px silver, 0 0 15px silver; /* 후광 효과를 은색으로 설정 */
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


    .toilet-name {
        font-weight: bold;
        font-size: 1.5em; /* Larger font size */
        margin-bottom: 10px;
    }
    .toilet-rating {
        color: #888;
        margin-top: 10px;
    }
    .gold-crown::before {
        content: "🥇"; /* Gold crown emoji */
        color: gold;
        font-size: 48px; 
	    width: 48px; 
	    height: 48px; 
    }
    .silver-crown::before {
        content: "🥈"; /* Silver crown emoji */
        color: silver;
        font-size: 48px; 
	    width: 48px; 
	    height: 48px; 
    }
    .bronze-crown::before {
        content: "🥉"; /* Bronze crown emoji */
        color: #cd7f32; /* Bronze color */
        font-size: 48px; 
	    width: 48px; 
	    height: 48px; 

    }
    
    /*4위~*/
    .rank-list {
        margin: 20px auto;
        width: 80%;
        max-width: 800px;
    }
    .rank-item {
        display: flex;
        align-items: center;
        border: 1px solid #ccc;
        padding: 10px;
        margin: 10px 0;
        border-radius: 5px;
        background-color: #f9f9f9;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .rank-item .rank {
        width: 20%;
        text-align: center;
        font-weight: bold;
    }
    .rank-item .toilet-name {
        flex: 1;
        padding: 0 10px;
        color: #333;
    }
    .rank-item .toilet-rating {
        width: 20%;
        text-align: center;
        color: #888;
    }
    

</style>

<script>
    // JavaScript function to scale emoji icons
    document.addEventListener('DOMContentLoaded', function() {
        const crownIcons = document.querySelectorAll('.crown-icon');
        crownIcons.forEach(icon => {
            icon.style.transform = 'scale(1.5)'; 
        });
    });
</script>
    
    <script>
       
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
        } else if (rating == 5.0) {
            return '★★★★★ (' + rating.toFixed(1) + ')';
        } else {
            return '평가 없음';
        }
    }
    </script>

</head>
<body style="text-align: center;">
	
	<%@include file="../common/header.jsp" %>
	
	<br><br>

	<div class="nine">
		<h1>
			Ranking <span> 화장실 순위</span>
		</h1>
	</div>
	
	<br>


	<div class="top3-container">
    <c:forEach var="rank" items="${avg}" varStatus="status">
        <c:if test="${status.index < 3}">
            <c:set var="toiletName" value="" />
            <c:forEach var="toilet" items="${t}">
                <c:if test="${rank.toiletNo == toilet.toiletNo}">
                    <c:set var="toiletName" value="${toilet.toiletName}" />
                </c:if>
            </c:forEach>
            <div class="top3-box ${status.index == 0 ? 'gold-crown' : (status.index == 1 ? 'silver-crown' : 'bronze-crown')}">
                <div class="toilet-name">${status.index + 1}위 <br> ${toiletName}</div>
                <div class="toilet-rating"> <script>document.write(convertToStarRating(${rank.starAvg}))</script></div>
                <div class="crown-icon"></div>
            </div>
        </c:if>
    </c:forEach>
</div>

<div class="rank-list">
    <c:forEach var="rank" items="${avg}" varStatus="status">
        <c:if test="${status.index >= 3}">
            <c:set var="toiletName" value="" />
            <c:set var="toiletNo" value="" />
            <c:forEach var="toilet" items="${t}">
                <c:if test="${rank.toiletNo == toilet.toiletNo}">
                    <c:set var="toiletName" value="${toilet.toiletName}" />
                    <c:set var="toiletNo" value="${toilet.toiletNo}" />
                </c:if>
            </c:forEach>
            <div class="rank-item" onclick="openRankingModal()">
                <div class="rank">${status.index + 1}위</div>
                <div class="toilet-name">${toiletName}</div>
                <div class="toilet-rating">
                    <script>document.write(convertToStarRating(${rank.starAvg}))</script>
                </div>
            </div>
        </c:if>
    </c:forEach>
</div>




	<jsp:include page="../common/footer.jsp" />

</body>



<script>
	function openRankingModal() {
		
		
		
	}


</script>




</html>