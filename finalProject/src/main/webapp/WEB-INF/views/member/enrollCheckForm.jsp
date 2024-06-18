<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <style>
        body {
            background-color: #e0f7fa;
            font-family: Arial, sans-serif;
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
            width: 800px;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin: 100px auto 0;
            
        }
        .content {
            padding: 20px;
        }
        .content h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        .content textarea {
            width: 100%;
            height: 150px;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            resize: none;
        }
        .content label {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .content label input {
            margin-right: 10px;
        }
        .content .checkbox-label {
            display: flex;
            align-items: center;
        }
        .content .checkbox-label input {
            margin-right: 5px;
        }
        .content .full-agree {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .content .full-agree input {
            margin-right: 10px;
        }
        .footer {
            text-align: center;
        }
        .footer button {
            padding: 10px 20px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .footer button a {
            color: white;
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
            <h2>회원가입약관</h2>
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
                <input type="checkbox" id="agreeTerms" />
                회원가입약관의 내용에 동의합니다.
            </label>
            <h2>개인정보처리방침</h2>
            <textarea readonly>
이용자는 회원가입을 하지 않아도 정보 검색, 뉴스 보기 등 대부분의 네이버 서비스를 회원과 동일하게 이용할 수 있습니다. 이용자가 메일, 캘린더, 카페, 블로그 등과 같이 개인화 혹은 회원제 서비스를 이용하기 위해 회원가입을 할 경우, 네이버는 서비스 이용을 위해 필요한 최소한의 개인정보를 수집합니다.

회원가입 시점에 참지마요가 이용자로부터 수집하는 개인정보는 아래와 같습니다.

- 회원 가입 시 필수항목으로 아이디, 비밀번호, 이름, 생년월일, 성별, 휴대전화번호를, 선택항목으로 이메일주소를 수집합니다. 실명 인증된 아이디로 가입 시, 암호화된 동일인 식별정보(CI), 중복가입 확인정보(DI), 내외국인 정보를 함께 수집합니다. 만 14세 미만 아동의 경우, 법정대리인 정보(법정대리인의 이름, 중복가입확인정보(DI), 휴대전화번호)를 추가로 수집합니다.
- 비밀번호 없이 회원 가입 시에는 필수항목으로 아이디, 이름, 생년월일, 휴대전화번호를, 선택항목으로 비밀번호를 수집합니다.
- 단체 회원가입 시 필수 항목으로 단체아이디, 비밀번호, 단체이름, 이메일주소, 휴대전화번호를, 선택항목으로 단체 대표자명을 수집합니다.
            </textarea>
            <label class="checkbox-label">
                <input type="checkbox" id="agreePrivacy" />
                개인정보처리방침안내 내용에 동의합니다.
            </label>
            <div class="full-agree">
                <input type="checkbox" id="fullAgree" onclick="checkAllAgreements()" />
                <label>전체 동의하기</label>
            </div>
        </div>
        <div class="footer">
            <button type="button" onclick="if(validateForm()) { location.href='http://localhost:8888/springProject/insert.me'; }">다음</button>
        </div>
    </div>
</body>
</html>
