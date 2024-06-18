<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
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
            background-color: blue;
            color: white;
        }
        .container form .button-container .cancel-button {
            background-color: #ffc107;
            color: white;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            var yearSelect = $('#year');
            var currentYear = new Date().getFullYear();
            for (var year = currentYear; year >= 1900; year--) {
                yearSelect.append($('<option>', { value: year, text: year }));
            }

            var monthSelect = $('#month');
            for (var month = 1; month <= 12; month++) {
                monthSelect.append($('<option>', { value: ('0' + month).slice(-2), text: month }));
            }

            var daySelect = $('#day');
            for (var day = 1; day <= 31; day++) {
                daySelect.append($('<option>', { value: ('0' + day).slice(-2), text: day }));
            }

            $('form').on('submit', function(e) {
                var year = $('#year').val();
                var month = $('#month').val();
                var day = $('#day').val();
                var birthDate = year + month + day;
                $('#birthDate').val(birthDate);
            });
        });
    </script>
</head>
<body>
  <div class="container">
        <h2>아이디 찾기</h2>
        <form action="${pageContext.request.contextPath}/findId.me" method="post">
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="memberNick" placeholder="이름을 입력하세요" required>
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
            <div class="button-container">
                <button type="submit" class="submit-button">아이디 찾기</button>
                <button type="button" class="cancel-button" onclick="location.href='cancel.page'">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
