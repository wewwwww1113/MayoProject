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
      
      <%-- ${star} 변수를 이용하여 각 게시글의 평점을 출력 --%>
	<c:forEach var="s" items="${star}" varStatus="loop">
		<section class="ranking-stage">
			<div class="ranking-item ranking-1st">
				
				<p>화장실 이름: ${t[loop.index].toiletName}</p>

				<p>평균 별점: ${avgStar}</p>
			
			</div>
		
		</section>
	</c:forEach>
	




	<jsp:include page="../common/footer.jsp" />

</body>
</html>