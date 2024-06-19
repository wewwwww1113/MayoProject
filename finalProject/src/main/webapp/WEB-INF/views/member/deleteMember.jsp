<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원 탈퇴</title>
    <style>
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
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin: 100px auto 0;
        }
        .container h2 {
            text-align: center;
            color: #333;
        }
        .container form {
            display: flex;
            flex-direction: column;
        }
        .container form label {
            margin: 10px 0 5px;
            font-size: 14px;
            color: #555;
        }
        .container form input {
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .container form .button-container {
            display: flex;
            justify-content: space-between;
        }
        .container form .button-container button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
        }
        .container form .button-container .submit-button {
            background-color: red;
            color: white;
        }
        .container form .button-container .cancel-button {
            background-color: #ffc107;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>회원 탈퇴</h2>
        <c:if test="${not empty error}">
            <p style="color:red;">${error}</p>
        </c:if>
        <form id="deleteForm" action="${pageContext.request.contextPath}/deleteAccount.me" method="post">
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="memberPwd" placeholder="비밀번호를 입력하세요" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
            </div>
            <div class="button-container">
                <button type="button" class="submit-button" onclick="confirmDelete()">회원 탈퇴</button>
                <button type="button" class="cancel-button" onclick="location.href='cancel.page'">취소</button>
            </div>
        </form>
    </div>

    <script>
        function confirmDelete() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            
            if (password === confirmPassword) {
                if (confirm("정말 삭제하시겠습니까?")) {
                    document.getElementById("deleteForm").submit();
                }
            } else {
                alert("비밀번호가 일치하지 않습니다.");
            }
        }
    </script>
</body>
</html>
