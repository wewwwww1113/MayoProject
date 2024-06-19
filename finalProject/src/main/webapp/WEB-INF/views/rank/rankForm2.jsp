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
    body {
    font-family: sans-serif;
    margin: 0;
    padding: 0;
    }

    header {
        background-color: #f0f0f0;
        padding: 20px;
        text-align: center;
    }

    h1 {
        font-size: 24px;
    }

    .ranking-stage {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 20px;
    }

    .ranking-item {
        width: 30%;
        border: 1px solid #ccc;
        padding: 20px;
        text-align: center;
    }

    .ranking-item img {
        width: 100%;
        height: auto;
        margin-bottom: 10px;
    }

    .ranking-item h3 {
        font-size: 18px;
        margin-bottom: 5px;
    }

    .ranking-item p {
        line-height: 1.5;
    }

    .ranking-item .recommendation-count {
        font-weight: bold;
        margin-top: 10px;
    }

    .ranking-1st {
        background-color: #fff4f4;
        border-color: #ffffff;
    }

    .ranking-2nd {
        background-color: #fff4f4;
        border-color: #ffffff;
    }

    .ranking-3rd {
        background-color: #fff4f4;
        border-color: #ffffff;
    }

    .ranking-list {
        margin-top: 20px;
    }

    .ranking-list h2 {
        font-size: 20px;
        margin-bottom: 10px;
    }

    .ranking-list ul {
        list-style: none;
        padding: 0;
    }

    .ranking-list li {
        margin-bottom: 10px;
    }

    
    </style>
</head>
<body>
	
	<%@include file="../common/header.jsp" %>

    <header>
      
    </header>
    	<br><br>
      <h1 align="center">랭킹 페이지</h1>
    <section class="ranking-stage">
        <div class="ranking-item ranking-1st">
            <img src="image1.jpg" alt="1위 게시글 이미지">
            <h3>게시글 제목 1</h3>
            <p>게시글 내용 요약...</p>
            <span class="recommendation-count">추천수: 100</span>
        </div>
        <div class="ranking-item ranking-2nd">
            <img src="image2.jpg" alt="2위 게시글 이미지">
            <h3>게시글 제목 2</h3>
            <p>게시글 내용 요약...</p>
            <span class="recommendation-count">추천수: 80</span>
        </div>
        <div class="ranking-item ranking-3rd">
            <img src="image3.jpg" alt="3위 게시글 이미지">
            <h3>게시글 제목 3</h3>
            <p>게시글 내용 요약...</p>
            <span class="recommendation-count">추천수: 60</span>
        </div>
    </section>
    <section class="ranking-list" align="center">
        <h2>나머지 순위</h2>
        <ul>
            <li>
                <a href="#">게시글 제목 4 (추천수: 50)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            <li>
                <a href="#">게시글 제목 5 (추천수: 40)</a>
            </li>
            </ul>
    </section>
    <script src="script.js"></script>

	<jsp:include page="../common/footer.jsp" />

</body>
</html>