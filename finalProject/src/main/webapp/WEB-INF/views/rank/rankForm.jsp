<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .content {
            background-color:rgb(247, 245, 245);
            width:80%;
            margin:auto;
        }
        .innerOuter {
            border:1px solid lightgray;
            width:80%;
            margin:auto;
            padding:5% 10%;
            background-color:white;
        }

        #boardList {text-align:center;}
        #boardList>tbody>tr:hover {cursor:pointer;}

        #pagingArea {width:fit-content; margin:auto;}
        
        #searchForm {
            width:80%;
            margin:auto;
        }
        #searchForm>* {
            float:left;
            margin:5px;
        }
        .select {width:20%;}
        .text {width:53%;}
        .searchBtn {width:20%;}
    </style>
</head>
<body>
    
    <%@include file="../common/header.jsp" %>

    <div class="content">
        <br><br>
        <div class="innerOuter" style="padding:5% 10%;">
            <h2 align="center">랭킹 게시판</h2>
           <table id="boardList" class="table table-hover" align="center">
            <thead>
            	<tr>
            		<th><img src="data:image/png;base64,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" width="30" height="30"></th>
            		<th><img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmoeR9XiBCyvE5LzKZ56Qz5RddDW2jKnX96g&s" width="30" height="30"></th>
            		<th><img src="data:image/png;base64,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" width="30" height="30"></th>
            	</tr>
            </thead>
            <tbody>
            	<tr>
					<th>내용</th>
					<th>내용</th>
					<th>내용</th>
            	</tr>
            </tbody>
            </table>
            
        </div>
        <br><br>

    </div>
    
    
            
            
            

    <jsp:include page="../common/footer.jsp" />

</body>
</html>