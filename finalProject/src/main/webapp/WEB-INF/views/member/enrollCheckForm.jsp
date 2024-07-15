<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-L25xsCO3g0t2z8C2qQSTsUk6/soHd+aRkE26HYPOYyZqJ3aJNSjQsZ7u0DSK5nXe" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400&display=swap');
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap');

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
            
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding-top: 80px; /* 헤더 높이만큼 패딩 추가 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
        background-color: #f8f9fa;
            width: 100%;
            max-width: 800px;
            
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px;
        }
        .content {
            padding: 20px;
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            
        }
        .content textarea {
            width: 100%;
            height: 150px; /* 높이 조정 */
            padding: 15px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            resize: none;
            font-size: 14px;
            background-color: #f1f1f1;
            color: #495057;
        }
        .content label {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: #495057;
        }
        .content label input {
            margin-right: 10px;
        }
        .content .checkbox-label {
            display: flex;
            align-items: center;
            font-size: 14px;
            color: #495057;
        }
        .content .checkbox-label input {
            margin-right: 10px;
        }
        .content .full-agree {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            font-size: 14px;
            color: #495057;
        }
        .content .full-agree input {
            margin-right: 10px;
        }
        .footer {
            text-align: center;
            margin-top: 20px;
        }
        .footer button {
            padding: 12px 24px;
           
            color: black;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s ease;
        }
        .footer button:hover {
            background-color: black;
            color : white;
        }
        .footer button a {
            color: white;
            text-decoration: none;
        }
        footer {
            background-color: #003366;
            color: white;
            text-align: center;
            padding: 10px 0;
            width: 100%;
        }
        header {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
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
        a:hover {
            color: #0056b3;
            text-decoration: none;
        }
    </style>
    <script>
        function checkAllAgreements() {
            var agreeTerms = document.getElementById("agreeTerms");
            var agreePrivacy = document.getElementById("agreePrivacy");
            var fullAgree = document.getElementById("fullAgree");

            agreeTerms.checked = fullAgree.checked;
            agreePrivacy.checked = fullAgree.checked;
        }

        function validateForm() {
            var agreeTerms = document.getElementById("agreeTerms").checked;
            var agreePrivacy = document.getElementById("agreePrivacy").checked;

            if (!agreeTerms || !agreePrivacy) {
                alert("약관에 동의하셔야합니다.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <div class="content">
            <h2><strong>회원가입약관</strong></h2>
            <textarea readonly>
여러분을 환영합니다.
다양한 참지마요 서비스를 즐겨보세요.
회원으로 가입하시면 참지마요 서비스를 보다 편리하게 이용할 수 있습니다.
여러분이 제공한 콘텐츠를 소중히 다룰 것입니다.
여러분의 개인정보를 소중히 보호합니다.
타인의 권리를 존중해 주세요.
참지마요 서비스 이용과 관련하여 몇 가지 주의사항이 있습니다.
참지마요에서 제공하는 다양한 포인트를 요긴하게 활용해 보세요.
부득이 서비스 이용을 제한할 경우 합리적인 절차를 준수합니다.
참지마요의 잘못은 참지마요가 책임집니다.
일부 참지마요 서비스에는 광고가 포함되어 있습니다.
언제든지 참지마요 서비스 이용계약을 해지하실 수 있습니다.
서비스 중단 또는 변경 시 꼭 알려드리겠습니다.
주요 사항을 잘 안내하고 여러분의 소중한 의견에 귀 기울이겠습니다.
여러분이 쉽게 알 수 있도록 약관 및 운영정책을 게시하며 사전 공지 후 개정합니다.
            </textarea>
           
            <label>
                <input type="checkbox" id="agreeTerms" style="width: 20px; height: 20px;">
                회원가입약관의 내용에 동의합니다.
            </label>
             
            <h2><strong>개인정보처리방침</strong></h2>
            <textarea readonly>
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 참지마요가 이용자로부터 수집하는 개인정보는 아래와 같습니다.

- 회원 가입 시 필수항목으로 아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호를, 선택항목으로 이메일주소를 수집합니다. 실명 인증된 아이디로 가입 시, 암호화된 동일인 식별정보(CI), 중복가입 확인정보(DI), 내외국인 정보를 함께 수집합니다. 만 14세 미만 아동의 경우, 법정대리인 정보(법정대리인의 이름, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.
- 비밀번호 없이 회원 가입 시에는 필수항목으로 아이디, 이름, 생년월일, 휴대전화번호를, 선택항목으로 비밀번호를 수집합니다.
- 단체 회원가입 시 필수 항목으로 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를, 선택항목으로 단체 대표자명을 수집합니다.
            </textarea>
            <label class="checkbox-label">
                <input type="checkbox" id="agreePrivacy" style="width: 20px; height: 20px;"/>
                개인정보처리방침안내 내용에 동의합니다.
            </label>
            <div class="full-agree">
                <input type="checkbox" id="fullAgree" onclick="checkAllAgreements()" style="width: 20px; height: 20px;" />
                <label id="agreePrivacy" style="height: 20px;">전체 동의하기</label>
            </div>
        </div>
        <div class="footer">
            <button type="button" onclick="if(validateForm()) { location.href='http://localhost:8888/springProject/insert.me'; }">다음</button>
        </div>
    </div>
</body>
</html>