<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>참지마요 회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-L25xsCO3g0t2z8C2qQSTsUk6/soHd+aRkE26HYPOYyZqJ3aJNSjQsZ7u0DSK5nXe" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
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

        body {
            font-family: Arial, sans-serif;
            background-color: #e0f7fa;
            margin: 0;
            padding-top: 60px; /* 헤더 높이만큼 패딩 추가 */
        }
        .header {
            position: fixed;
            top: 0;
            width: 100%;
            background-color: #003366;
            color: white;
            padding: 10px 0;
            text-align: center;
            z-index: 1000;
        }
        .header a {
            color: white;
            margin: 0 20px;
            text-decoration: none;
        }
        .container {
            background-color: #f5f5f5; /* 부드러운 회색 배경 */
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 550px;
            
            margin: 100px auto 0;
        }
        .container h2 {
            text-align: center;
            color: #333;
            font-size: 50px; /* 헤더 크기 추가 */
        }
        .container form {
            display: flex;
            flex-direction: column;
        }
        .container form label {
            margin: 10px 0 5px;
            font-size: 14px;
            color: #555;
            text-align: left;
        }
        .container form input, 
        .container form select {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .container form .button-container {
            display: flex;
            justify-content: center; /* 가운데 정렬 추가 */
            margin-top: 20px;
        }
        .container form .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }
        .container form .button-container .join-button {
            background-color: black; /* 버튼 색상 검정색으로 변경 */
            color: white;
            margin-right: 10px; /* 가입하기 버튼과의 간격 추가 */
        }
        .container form .button-container .cancel-button {
            background-color: #ffc107;
            color: white;
            margin-left: 10px; /* 가입취소 버튼과의 간격 추가 */
        }
        .check-availability {
            display: flex;
            align-items: center;
        }
        .check-availability button {
            margin-left: 10px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: blue;
            color: white;
            font-size: 14px;
            cursor: pointer;
        }
        .email-input {
            display: flex;
            align-items: center;
        }
        .email-input input {
            margin: 0 5px;
            flex: 1;
        }
        .email-input select {
            margin-left: 5px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        #username-message {
            color: red;
            font-size: 12px; 
            margin-top: 5px;
        }
        
        #check-username {
        background-color: black; /* 버튼 색상 검정색으로 변경 */
        }
        
        
          body, ul, li, h1 {
        margin: 0;
        padding: 0;
        list-style: none;
    }
    
   
    
     body {
        background: rgb(255, 255, 255);
        font-family: Arial, sans-serif;
        
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
    }
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#check-username').click(function() {
                var username = $('#username').val().trim();
                var messageDiv = $('#username-message');
                if (username !== '') {
                    $.ajax({
                        type: 'POST',
                        url: 'checkUsername',
                        data: { username: username },
                        success: function(response) {
                            if (response.trim() === 'available') {
                                messageDiv.text('사용 가능한 아이디입니다.');
                                messageDiv.css('color', 'green');
                            } else {
                                messageDiv.text('이미 사용 중인 아이디입니다.');
                                messageDiv.css('color', 'red');
                            }
                        },
                        error: function() {
                            messageDiv.text('서버 오류가 발생했습니다.');
                            messageDiv.css('color', 'red');
                        }
                    });
                } else {
                    messageDiv.text('아이디를 입력해주세요.');
                    messageDiv.css('color', 'red');
                }
            });

            var yearSelect = $('#year');
            var currentYear = new Date().getFullYear();
            for (var year = currentYear; year >= 1900; year--) {
                yearSelect.append($('<option>', { value: year, text: year }));
            }

            var monthSelect = $('#month');
            for (var month = 1; month <= 12; month++) {
                monthSelect.append($('<option>', { value: month, text: month }));
            }

            var daySelect = $('#day');
            for (var day = 1; day <= 31; day++) {
                daySelect.append($('<option>', { value: day, text: day }));
            }

            $('form').on('submit', function(e) {
                var password = $('#password').val();
                var confirmPassword = $('#confirm-password').val();
                var passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,10}$/;

                if (!passwordPattern.test(password)) {
                    alert('비밀번호는 영문과 숫자를 포함하여 4~10글자이어야 합니다.');
                    e.preventDefault();
                } else if (password !== confirmPassword) {
                    alert('비밀번호가 일치하지 않습니다.');
                    e.preventDefault();
                }

                var year = $('#year').val();
                var month = $('#month').val();
                var day = $('#day').val();
                var birthDate = year + ('0' + month).slice(-2) + ('0' + day).slice(-2);
                $('#birthDate').val(birthDate);

                var email = $('#email').val();
                var emailDomain = $('#email-domain').val();
                $('#fullEmail').val(email + '@' + emailDomain);
            });
        });
    </script>
</head>
<body>
    <div class="container">
        <c:choose>
            <c:when test="${not empty loginUser}">
                <p>이미 로그인된 상태입니다. 로그아웃 후 다시 시도해주세요.</p>
                <button onclick="location.href='logout.me'">로그아웃</button>
            </c:when>
            <c:otherwise>
                <h1 align="center">회원가입</h1>
                <form action="insert.me" method="post">
                    <label for="username">아이디</label>
                    <div class="check-availability">
                        <input type="text" id="username" name="memberId" placeholder="아이디 (영문 6~20자)" required>
                        <button type="button" id="check-username">중복 확인</button>
                    </div>
                    <div id="username-message"></div>
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="memberPwd" placeholder="영문, 숫자  4~10글자" required>
                    <label for="confirm-password">비밀번호 확인</label>
                    <input type="password" id="confirm-password" name="confirm-password" placeholder="비밀번호 재입력" required>
                    <label for="name">닉네임</label>
                    <input type="text" id="name" name="memberNick" placeholder="닉네임을 입력해주세요" required>
                    <label for="gender">성별</label>
                    <select id="gender" name="gender" required>
                        <option value="">성별을 선택하세요</option>
                        <option value="male">남성</option>
                        <option value="female">여성</option>
                    </select>
                    <label for="email">이메일 주소</label>
                    <div class="email-input">
                        <input type="text" id="email" name="email" placeholder="이메일 주소" required>
                        <span>@</span>
                        <select id="email-domain" name="email-domain" required>
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="outlook.com">outlook.com</option>
                            <option value="nate.com">nate.com</option>
                        </select>
                    </div>
                    <label for="birthdate">생년월일</label>
                    <div>
                        <select id="year" name="year" required>
                            <option value="">년도</option>
                        </select>
                        <select id="month" name="month" required>
                            <option value="">월</option>
                        </select>
                        <select id="day" name="day" required>
                            <option value="">일</option>
                        </select>
                    </div>
                    <input type="hidden" id="birthDate" name="birthDate">
                    <input type="hidden" id="fullEmail" name="fullEmail">
                    <div class="button-container">
                        <button type="submit" class="join-button">가입하기</button>
                        <button type="button" class="cancel-button" onclick="location.href='loginForm.me'">가입취소</button>
                    </div>
                </form>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>