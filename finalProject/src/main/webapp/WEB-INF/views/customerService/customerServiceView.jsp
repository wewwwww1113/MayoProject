<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
/* cs_menu와 contentDiv를 적절히 스타일링합니다. */
.cs_menu {
	display: flex;
	justify-content: center; /* 중앙 정렬 */
	list-style-type: none;
	padding: 0;
	margin: 20px 0; /* 상단과 하단 마진을 추가하여 간격을 조절합니다. */
	background-color: #f8f9fa; /* 배경색 */
	border: 1px solid #ced4da;
	border-radius: 8px;
	overflow: hidden; /* 넘칠 경우 스크롤바가 생기지 않도록 처리합니다. */
}

.cs_menu li {
	float: left; /* 리스트를 왼쪽으로 정렬합니다. */
}

.cs_menu button {
	background-color: #0275d8;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 4px;
	cursor: pointer;
	transition: background-color 0.3s;
	font-size: 16px;
}

.cs_menu button:hover {
	background-color: #025aa5;
}

.cs_menu .on button {
	background-color: #025aa5;
}

#contentDiv {
	margin-top: 20px; /* 콘텐츠 영역과의 간격을 조절합니다. */
}

.content {
	margin-top: 10px;
	padding: 10px;
	background-color: #fff; /* 콘텐츠 배경색 */
	border: 1px solid #ccc;
	border-radius: 4px;
}

.content p {
	margin: 0; /* 문단의 상단과 하단 마진을 제거하여 간격을 좁힙니다. */
	font-size: 14px;
	line-height: 1.5; /* 줄 간격을 늘립니다. */
}
</style>

 

</head>
<body>

	<%@include file="../common/header.jsp"%>

    <li><a href="#" id="oneToOneInquiry">1:1 문의</a></li>
	<div id="content">
		<ul class="cs_menu">
			<li class="on"><button id="cs">문의</button></li>
			<li><button>교환</button></li>
			<li><button>요청</button></li>
		</ul>
	</div>
	<div id="contentDiv"></div>

	<script>
	 document.getElementById('oneToOneInquiry').addEventListener('click', function(event) {
         event.preventDefault(); // 링크의 기본 동작을 막음

         var ws = new WebSocket("ws://localhost:8888/springProject/customerService/member");

         ws.onopen = function() {
             console.log("WebSocket connection opened");
             // 연결이 열리면 서버로 메시지 보내기
             ws.send("Hello, Server!");
         };

         ws.onmessage = function(event) {
             console.log("Message from server: " + event.data);
             // 서버로부터 메시지를 받으면 처리
         };

         ws.onclose = function() {
             console.log("WebSocket connection closed");
         };

         ws.onerror = function(error) {
             console.log("WebSocket error: " + error);
         };
     });
		/* 비동기 통신으로 카테고리별 숙소 정보 조회해오는 비동기 통신 Script */
		$(function() {
			$("#cs").click();
		});

		$('.cs_menu li button').on(
				'click',
				function() {
					$(this).parent('li').addClass('on');
					$(this).parent('li').siblings().removeClass('on');
					//console.log($(this).text());
					$.ajax({
						url : "selectList.cs",
						type : 'GET',
						data : {
							category : $(this).text()
						},
						dataType : 'json',
						success : function(list) {
							var html = "";
							for (var i = 0; i < list.length; i++) {
								html += '<div class="content">';
								html += '<p class="question" style="cursor:pointer;"><strong>질문:</strong> ' + list[i].csQuestion + '</p>';
								html += '<p class="answer" style="display:none;"><strong>답변:</strong> ' + list[i].answer + '</p>';		
								html += '</div>';
							}
							$("#contentDiv").html(html);
							console.log(list)
						},
						error : function() {
							console.log("통신 실패");
						}
					});

				});
		$(document).on('click', '.question', function() {
			$('.answer').slideUp(); // 모든 답변을 숨깁니다.
			$(this).next('.answer').slideToggle();
		});
	      
	</script>




</body>
</html>