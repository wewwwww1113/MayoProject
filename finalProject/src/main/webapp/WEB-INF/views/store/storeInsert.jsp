
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 추가</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 90%;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-group textarea {
            resize: vertical;
            height: 100px;
        }

        .form-actions {
            text-align: center;
            margin-top: 20px;
        }

        .form-actions button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #28a745;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-actions button:hover {
            background-color: #218838;
        }

        .form-actions button:active {
            background-color: #218838;
            transform: translateY(1px);
        }
    </style>
</head>
<body>
<%@include file="/WEB-INF/views/common/header.jsp" %>
    <div class="container">
        <h2>상품 추가</h2>
        <form action="insert.st" method="post">
            <div class="form-group">
                <label for="pdName">상품명</label>
                <input type="text" id="pdName" name="pdName" required>
            </div>
            <div class="form-group">
                <label for="pdDescription">상품 설명</label>
                <textarea id="pdDescription" name="pdDescription" required></textarea>
            </div>
            <div class="form-group">
                <label for="pdImage">상품 이미지 URL</label>
                <input type="url" id="pdImage" name="pdImage" required>
            </div>
            <div class="form-group">
                <label for="price">가격</label>
                <input type="number" id="price" name="price" required>
            </div>
            <div class="form-actions">
                <button type="submit">추가</button>
                <button type="button" class="cancel-button" onclick="location.href='list.st'">취소</button>
            </div>
        </form>
    </div>
</body>
</html>
