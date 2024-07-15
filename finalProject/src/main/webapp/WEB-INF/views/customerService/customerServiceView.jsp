<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>고객 센터</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f0f0f0;
    margin: 0;
    padding: 0;
}

ul {
    list-style-type: none;
    padding: 0;
}
#oneToOneInquiryLink {
    display: block; /* 링크를 블록 요소로 변경하여 전체 영역을 클릭 가능하도록 함 */
    padding: 10px; /* 링크 주변에 패딩 추가 */
    background-color: gray; /* 링크 배경색 설정 */
    width:150px;
    margin-left:100px;
    color: #ffffff; /* 링크 텍스트 색상 설정 */
    border-radius: 5px; /* 링크 모서리를 둥글게 만듦 */
    text-align: center; /* 텍스트 가운데 정렬 */
    text-decoration: none; /* 링크 밑줄 제거 */
    transition: background-color 0.3s ease; /* 배경색 변경 시 부드러운 전환 효과 */
}

#oneToOneInquiryLink:hover {
    background-color: #0056b3; /* 링크에 마우스를 올렸을 때 배경색 변경 */
}

/* 고객 센터 기본 영역 */
#features {
    background-color: #ffffff;
    padding: 16px;
    margin-top: 220px;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    max-width: 260px;
    margin-left: 20px;
    border: 1px solid #cccccc;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

#features h2 {
    font-size: 18px;
    font-weight: bold;
    color: #333333;
    margin-bottom: 12px;
}

/* 메뉴 스타일링 */
.cs_menu {
    display: flex;
    justify-content: center;
    margin-top: -500px; /* 위로 이동 */
    margin-left: 0px; /* 오른쪽으로 이동 */
}
.cs_menu li {
    
    margin: 0 80px;
}

.cs_menu li button {
    padding: 10px 20px;
    background-color: gray;
    color: #ffffff;
    border: none;
    cursor: pointer;
    outline: none;
    transition: background-color 0.3s;
}

.cs_menu li button:hover {
    background-color: #0056b3;
}

/* 콘텐츠 영역 */
#contentDiv {
    max-width: 800px;
    margin: 20px auto;
}

.content {
    background-color: #ffffff;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

/* 질문과 답변 스타일링 */
.question {
    font-weight: bold;
    cursor: pointer;
    border: 1px solid #ccc;
    padding: 8px;
    border-radius: 5px;
    display: flex; /* Flexbox를 사용하여 내부 요소를 정렬 */
    align-items: center; /* 내부 요소를 수직으로 가운데 정렬 */
    width: 100%;
}

.question:hover {
    background-color: #f5f5f5; /* 호버 효과 추가 */
}

.question .count {
    padding-left: 500px; /* 조회수와 질문 사이의 간격 조정 */
}
.answer {
      font-weight: bold;
    cursor: pointer;
    border: 1px solid #ccc;
    padding: 8px;
    border-radius: 5px;
    display: flex; /* Flexbox를 사용하여 내부 요소를 정렬 */
    align-items: center; /* 내부 요소를 수직으로 가운데 정렬 */
    magin-top : -10px;
    margin-bottom: 8px;
    width: 100%;
    
}
#chatContainer {
    display: none;
    position: fixed;
    bottom: 20px;
    right: 20px;
    width: 300px;
    height: 600px;
    background-color: #fff;
    border: 1px solid #ccc;
    overflow-y: scroll;
}

#chatMessages {
    padding: 10px;
    height: 80%;
    overflow-y: scroll;
    border-bottom: 1px solid #ccc;
}

#messageInput {
    width: calc(100% - 80px);
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-right: 10px;
    resize: none;
}

#sendMessageBtn {
    padding: 10px 20px;
    background-color: #007bff;
    color: #ffffff;
    border: none;
    cursor: pointer;
    outline: none;
    border-radius: 5px;
    transition: background-color 0.3s;
}

#sendMessageBtn:hover {
    background-color: #0056b3;
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
</style>
</head>
<body>

	<%@ include file="../common/header.jsp"%>

	
	<div class="nine">
		<h1>
			Service <span> 고객 센터</span>
		</h1>
	</div>
		<ul>
		<!-- "실시간 문의" 링크 -->
		<li><a href="#" id="oneToOneInquiryLink">1:1 실시간 문의</a></li>
	</ul>

	<section id="features">
		<div class="container">
			<div class ="he">
				<h2>자주 묻는 질문 TOP 5</h5>
			</div>
			<div class="cs-list"></div>
			<!-- cs-list를 세로로 나열할 곳 -->
		</div>
	</section>

	<div id="content">
		<ul class="cs_menu">
			<li class="on"><button id="cs">문의</button></li>
			<li><button>교환</button></li>
			<li><button>요청</button></li>
		</ul>
	</div>
	<div id="contentDiv"></div>

	<div id="chatContainer">
		<div id="chatMessages"></div>
		<textarea id="messageInput" placeholder="메시지를 입력하세요..."></textarea>
		<button id="sendMessageBtn">전송</button>
	</div>



	<script>
   
	   var username = "<%=((com.kh.springProject.member.model.vo.Member) session.getAttribute("loginUser")).getMemberNick()%>"; // 세션에서 닉네임을 가져옵니다.
		var webSocket;

		console.log("User nickname: " + username); // 사용자 닉네임 로그 확인

		$("#oneToOneInquiryLink").on('click', function(e) {
			e.preventDefault();
			connectWebSocket();
		});

		function connectWebSocket() {
			webSocket = new WebSocket("ws://localhost:8888/springProject/chat");

			webSocket.onopen = function(event) {
				console.log("WebSocket 연결 성공");
				$("#chatContainer").show();
			};

			webSocket.onmessage = function(event) {
				var message = JSON.parse(event.data);
				if (message.sender === "System") {
					alert(message.content);
					if (message.content === "최대 접속 인원이 초과되었습니다. 잠시만 기다려 주세요.") {
						webSocket.close();
					}
				} else {
					var senderName = message.sender === username ? username
							: message.sender;
					var messageClass = message.sender === username ? "right"
							: "left";

					var chatBubble = '<div class="chat-message ' + messageClass + '">';
					chatBubble += '<div class="chat-bubble ' + messageClass + '">';
					chatBubble += '<p><strong>' + senderName + ':</strong> '
							+ message.content + '</p>';
					chatBubble += '</div>';
					chatBubble += '</div>';

					$("#chatMessages").append(chatBubble);

					var chatMessages = document.getElementById("chatMessages");
					chatMessages.scrollTop = chatMessages.scrollHeight;
				}
			};

			webSocket.onclose = function(event) {
				console.log("WebSocket 연결 종료");
				$("#chatContainer").hide();
			};

			$("#sendMessageBtn").on('click', function() {
				var messageContent = $("#messageInput").val();
				if (messageContent.trim() !== '') {
					var message = {
						sender : username,
						content : messageContent
					};
					webSocket.send(JSON.stringify(message));
					$("#messageInput").val('');
					var chatMessages = document.getElementById("chatMessages");
					chatMessages.scrollTop = chatMessages.scrollHeight;
				}
			});

		}

		// 기존 AJAX 통신 코드
		$(function() {
			$("#cs").click();
		});

		$('.cs_menu li button')
				.on(
						'click',
						function() {
							$(this).parent('li').addClass('on');
							$(this).parent('li').siblings().removeClass('on');

							$
									.ajax({
										url : "selectList.cs",
										type : 'GET',
										data : {
											category : $(this).text()
										},
										dataType : 'json',
										success : function(list) {
											var html = "";
											for (var i = 0; i < list.length; i++) {
												console.log(list[i].csNo); // csNo를 콘솔에 출력
												html += '<div class="content">';
												html += '<p class="question" data-csNo="' + list[i].csNo + '" style="cursor:pointer;">';
												html += '<strong>질문:</strong> ' + list[i].csQuestion;
												html += '<span class="count" style="padding-left: 150px;"> 조회수: ' + list[i].count + '</span>';
												html += '</p>';
												html += '<p class="answer" style="display:none;"><strong>답변:</strong> '
														+ list[i].answer
														+ '</p>';
												html += '</div>';
											}
											$("#contentDiv").html(html);

										},
										error : function() {
											console.log("통신 실패");
										}
									});
						});

		/*data-csNo="' + list[i].csNo + '  csNo저장 */
		$(document).on('click', '.question', function() {
			var csNo = $(this).data('csno'); // 질문의 csNo를 가져옴
			/*   console.log($(this).data());  */
			$.ajax({
				url : "incrementViewCount",
				type : 'POST',
				data : {
					csNo : csNo
				},
				success : function(response) {
					console.log(data);
					// 여기서 추가적인 작업을 할 수 있음
				},
				error : function() {
					// 실패 시 추가적인 작업을 할 수 있음
				}
			});

			$('.answer').slideUp(); // 모든 답변을 숨깁니다.
			$(this).next('.answer').slideToggle();
		});

		// 자주 묻는 질문 목록 불러오기
		$.ajax({
			url : "list.cs",
			success : function(list) {
				var csList = "";
				for (var i = 0; i < list.length; i++) {
					csList += "<div class='cs-item'>" // 각 질문을 감싸는 div 추가
							+ "<a href='list.cs'></a>" + "<h3>" + (i + 1)
							+ ". " + list[i].csQuestion + "</h3>" + "</div>"
				}

				$('.cs-list').html(csList);
				console.log('데이터 불러오기 성공!!');
			},
			error : function() {
				console.log('데이터 불러오기 실패');
			}
		});
	</script>

</body>
</html>
