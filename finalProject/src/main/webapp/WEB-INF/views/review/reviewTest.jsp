<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../common/header.jsp" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>화장실 게시판</title>
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
        
        /**/
        /* 전체 컨테이너 */
    .comments-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
    }

    /* 댓글 컨테이너 */
    .comment {
        margin-bottom: 20px;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        background-color: #fff;
        transition: box-shadow 0.3s ease-in-out;
    }

    .comment:hover {
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
    }

    /* 댓글 헤더 */
    .comment-header {
        padding: 16px;
        background-color: #f8f8f8;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #eee;
    }

    /* 작성자 이름 */
    .comment-author {
        padding: 16px;
        font-weight: bold;
        font-size: 18px;
        color: #333;
        margin-bottom: 1px; /* 이름과 내용 사이 간격 */
    }

    /* 작성일 */
    .comment-date {
        font-size: 14px;
        color: #888;
    }

    /* 댓글 본문 */
    .comment-content {
        padding: 16px;
        color: #555;
        line-height: 1.6;
    }
        

        body {
            font-family: Arial, sans-serif;
            
            margin: 0;
            padding: 0;
        }

        .like-icon {
            font-size: 36px; /* Increase the size as desired */
            cursor: pointer;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }

    

        .posts {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .post {
            width: 23%;
            border: 1px solid #ccc;
            border-radius: 10px;
            margin-bottom: 20px;
            padding: 10px;
            text-align: left;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }

        .post:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .post img {
            width: 100%;
            height: auto;
            border-radius: 10px 10px 0 0;
        }

        .post-title {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0;
        }

        .post-content {
            font-size: 14px;
            margin-bottom: 10px;
        }


        /* 상세보기 모달 스타일 */
        .modal {
        display: none; /* 초기에 숨겨진 상태 */
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

        .modal-content {
        background-color: #fefefe;
        margin: 10% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 800px;
        border-radius: 8px;
        position: relative;
    }

    .modal-close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
    }
    .modal-close:hover,
    .modal-close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    /* 댓글 섹션 레이아웃 */
    .comment-section {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
    }

    /* 댓글 목록 컨테이너 */
    .comments-list-container {
        flex: 1;
        margin-right: 20px;
    }

    .comments-list {
        border: 1px solid #ccc;
        border-radius: 8px;
        padding: 10px;
        max-height: 200px; /* 필요에 따라 댓글 목록의 최대 높이 조정 */
        overflow-y: auto;
    }

    /* 댓글 작성 폼 컨테이너 */
    .comment-form-container {
        flex: 0.7;
    }

    /* 댓글 작성 폼 스타일 */
    .comment-form-container textarea {
        margin-top: 10px;
       }
    
    
    
    
    

        .star {
            font-size: 30px; /* 별의 크기 조정 */
            cursor: pointer;
            transition: color 0.3s; /* 색상 변화 애니메이션 */
        }

        .star:hover {
            color: gold; /* 마우스 호버 시 색상 변경 */
        }

        @media (max-width: 768px) {
            .post {
                width: 48%;
                margin-bottom: 20px;
            }
        }

        @media (max-width: 576px) {
            .post {
                width: 98%;
                margin-bottom: 20px;
            }

            .search-bar input {
                width: 70%;
                margin-bottom: 10px;
            }

            .search-bar button {
                width: 25%;
            }
        }
        
        /*검색창*/
        
.search-bar {
    display: flex;
    align-items: center;
    justify-content: center; /* 수평 중앙 정렬 */
    background-color: #f0f0f0;
    padding: 4px 8px; /* 위아래 여백 조정 */
    border-radius: 20px;
    box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
    width: 700px; /* 원하는 너비로 조정 */
    margin: 0 auto; /* 가운데 정렬을 위한 왼쪽/오른쪽 자동 마진 설정 */
}

#searchInput {
    flex: 1;
    border: none;
    padding: 8px;
    font-size: 16px;
    outline: none;
    background: none;
}

button {
        padding: 8px 15px;
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        font-size: 16px;
        margin-left: 10px;
        transition: background-color 0.3s ease;
        width: 80px; /* 원하는 너비로 조정 */
    }

    button:hover {
        background-color: #0056b3;
    }

.btn-rounded {
        border-radius: 20px; /* 원하는 정도로 조정 */
    }
    
    /*별 크기*/
     .starReview {
        font-size: 36px; /* 원하는 크기로 조정 */
        cursor: pointer;
        transition: color 0.3s; /* 색상 변화 애니메이션 */
    }

    .starReview:hover {
        color: gold; /* 마우스 호버 시 색상 변경 */
    }
        
    </style>
</head>
<body>
		
	 <br><br>
	 
	 
	<div class="container">
		<div class="nine">
			<h1>
				Review <span> 리뷰 게시판</span>
			</h1>
		</div>



		<div class="search-bar">
    <input type="text" id="searchInput" placeholder="검색어를 입력해 주세요." style="width: 700px;">
    <button class="btn btn-dark text-light btn-rounded btn-block" type="button" onclick="filterPosts()">검색</button>
</div>
		<br>

		<div class="posts" id="postContainer">
			<!-- 화장실 정보를 반복적으로 출력 -->
			<c:forEach var="t" items="${t}">
				<c:set var="district"
					value="${fn:substringBefore(t.toiletAddress, ' ')}" />
				<div class="post" data-name="${t.toiletName}"
					data-address="${t.toiletAddress}" data-district="${district}"
					data-no="${t.toiletNo}" data-open="${t.toiletOpen}">
					<!-- 이미지와 화장실 정보 등 필요한 정보들을 출력 -->
					<div class="post-title">${t.toiletName}</div>
					<div class="post-content">${t.toiletAddress}</div>
				</div>
			</c:forEach>
		</div>

	</div>

	<!-- 1. 모달 메인페이지 -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="modal-close" onclick="closeModal()">&times;</span>
            <div id="modalBody">
                <!-- 상세보기 내용이 여기 들어갑니다. -->
            </div>
        </div>
    </div>

    <!-- 2. 평점 별점 모달 -->
    <div id="ratingModal" class="modal">
        <div class="modal-content">
            <span class="modal-close" onclick="closeRatingModal()">&times;</span>
            <div id="ratingModalBody">
                <!-- 평점 입력 폼 -->
                <h4 align="center">평점 남기기</h4>
                <div id="ratingStars" align="center">
                    <span class="starReview" onclick="rateStar(1)">☆</span>
                    <span class="starReview" onclick="rateStar(2)">☆</span>
                    <span class="starReview" onclick="rateStar(3)">☆</span>
                    <span class="starReview" onclick="rateStar(4)">☆</span>
                    <span class="starReview" onclick="rateStar(5)">☆</span>
                </div>
                <input type="hidden" id="ratingInput" value="0">
                <div align="center">
                    <br>
                    <button class='btn btn-dark text-light'  onclick="saveRating()" style='width: 150px; height : 50px;'>평점 남기기</button>
                </div>
            </div>
        </div>
    </div>

   

    <!-- 3. 리뷰 작성 모달 -->
    <div id="reviewModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeReviewModal()">&times;</span>
        <div id="reviewModalBody" class="modal-body">
            <div class="comment-section">
                <div class="comments-list-container">
                    <h4 align="center"><strong>댓글 목록</strong></h4>
                    <div id="commentsList" class="comments-list">
                        <!-- 댓글 목록이 여기에 표시됩니다 -->
                    </div>
                </div>

                <div class="comment-form-container">
                    <h4 align="center"><strong>댓글 작성</strong></h4>
                    <hr>
                    <strong>${loginUser.memberNick }</strong>
                    <textarea id="commentText" rows="3" placeholder="댓글을 작성하세요" style="width: 100%;"></textarea>
                    <button class='btn btn-dark text-light' onclick="submitComment()" style='width: 150px; height : 50px;'>댓글 작성</button>
                </div>
            </div>
        </div>
    </div>
</div>




    <script>
        // 모달 메인창
        function openModal(name, address, open, toiletNo) {
            var modal = document.getElementById("modal");
            var modalBody = document.getElementById("modalBody");

            modal.setAttribute('data-no', toiletNo);

            var openTime = open ? open : '정보 없음';

            modalBody.innerHTML = "<h2 style='font-size: 30px; margin-bottom: 10px; text-align: center;'>" + name + "</h2>"
            + "<p style='font-size: 16px; margin-bottom: 10px; text-align: center;'> " + address + "</p>"
            + "<p style='font-size: 16px; margin-bottom: 20px; text-align: center;'> " + openTime + "</p>"
            + "<div style='display: flex; justify-content: center; align-items: center; text-align: center;'>"
            + "<button class='btn btn-dark text-light btn-rounded' style='width: 150px; height: 50px; margin-right: 10px;' onclick=\"openRatingModal(" + toiletNo + ")\">평점 남기기</button>"
            + "<button class='btn btn-dark text-light btn-rounded' style='width: 150px; height: 50px;' onclick=\"openReviewModal(" + toiletNo + ")\">리뷰 작성</button>"
            + "</div>"
            + "<div style='position: absolute; bottom: 10px; right: 10px; margin-right: 30px;'>"
            + "<span class='like-icon' style='font-size: 36px; cursor: pointer; margin-right: 10px;' onclick='toggleLike()'>&#x1F90D;</span>"
            + "<span class='star' style='font-size: 36px; cursor: pointer;' onclick='scrap(" + toiletNo + ");'>&#x2606;</span>"
            + "</div>"
            +"<br>";

            modal.style.display = "block";
        }
        
        function closeModal() {
            var modal = document.getElementById("modal");
            modal.style.display = "none";
        }

        function setPostEventListeners() {
            var posts = document.getElementsByClassName('post');
            for (var i = 0; i < posts.length; i++) {
                posts[i].addEventListener('click', function(event) {
                    var post = event.currentTarget;
                    var name = post.getAttribute('data-name');
                    var address = post.getAttribute('data-address');
                    var open = post.getAttribute('data-open');
                    var toiletNo = post.getAttribute('data-no');
                    
                    openModal(name, address, open, toiletNo);
                });
            }
        }

        // 초기 이벤트 리스너 설정
        setPostEventListeners();

        // 평점 모달
        var selectToiletNo = 0; // 선택한 화장실 Id
        function openRatingModal(toiletNo) {
            selectToiletNo = toiletNo;
            // 평점 남기기 모달 보이기
            var ratingModal = document.getElementById('ratingModal');
            ratingModal.style.display = 'block';

            // 초기화 - 모든 별을 ☆로 설정
            var stars = document.getElementsByClassName('starReview');
            for (var i = 0; i < stars.length; i++) {
                stars[i].textContent = '☆';
            }

            // 입력 폼 초기화 - 값 0으로 설정
            var ratingInput = document.getElementById('ratingInput');
            ratingInput.value = '0';
        }

        function closeRatingModal() {
            selectToiletNo = 0;
            // 평점 남기기 모달 닫기
            var ratingModal = document.getElementById('ratingModal');
            ratingModal.style.display = 'none';
        }

        function rateStar(value) {
            // 모든 별 초기화 (☆로 설정)
            var stars = $(".starReview");
            for (var i = 0; i < stars.length; i++) {
                if (i < value) {
                    stars[i].textContent = '★';
                } else {
                    stars[i].textContent = '☆';
                }
            }
            
            // 입력 폼에 값 설정
            var ratingInput = document.getElementById('ratingInput');
            ratingInput.value = value;
        }

        function saveRating() {
            var stars = $(".starReview");
            var cnt = 0;
            for (var i = 0; i < stars.length; i++) {
                if ($(".starReview")[i].textContent == "★") cnt++;
            }
            
            // 채워진 별 데이터 저장
            var sendData = {
                starCnt: cnt,
                toiletNo: selectToiletNo
            }
            $.ajax({
                url: "/springProject/updateStar",
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(sendData),
                success: function(data) {
                    alert(data.msg);
                    closeRatingModal();
                },
                error: function(error) {
                    console.log(error);
                    alert("통신 에러" + error);
                }
            });
        }

        // 이미지 모달창
        function openUploadModal() {
            var uploadModal = document.getElementById("uploadModal");
            uploadModal.style.display = "block";
        }

        function closeUploadModal() {
            var uploadModal = document.getElementById("uploadModal");
            uploadModal.style.display = "none";
        }

        function previewImage(event) {
            var preview = document.getElementById('uploadPreview');
            var file = event.target.files[0];
            var reader = new FileReader();

            reader.onloadend = function() {
                preview.src = reader.result;
                preview.style.display = "block";
            }

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = "";
            }
        }

        function saveImage() {
            var preview = document.getElementById('uploadPreview');
            var imageSrc = preview.src;
            alert("이미지를 저장합니다!");

            closeUploadModal();
        }

        // 댓글
        function openReviewModal(toiletNo) {
            var reviewModal = document.getElementById("reviewModal");
            reviewModal.style.display = "block";

            loadComments(toiletNo);
        }

        function closeReviewModal() {
            var reviewModal = document.getElementById("reviewModal");
            reviewModal.style.display = "none";
        }

        function loadComments(toiletNo) {
            var param = {
                "toiletNo": toiletNo,
            }

            var res = [];

            $.ajax({
                type: "GET",
                url: "/springProject/v1/review/reply",
                data: param,
                success: function(data) {
                    res = data;
                    
                    setTimeout(function() {
                        var commentsHtml = "";

                        res.forEach(function(comment) {
                            // 가리고자 하는 부분 처리
                            var hiddenPart = '*'.repeat(comment.userNickName.length - 1);
                            var maskedName = comment.userNickName.charAt(0) + hiddenPart;

                            commentsHtml += '<div class="comment">' +
                                                '<div class="comment-author"><strong>' + maskedName + '</strong></div>' +
                                                '<div class="comment-content">' + comment.content + '</div>' +
                                            '</div>';
                        });

                        document.getElementById('commentsList').innerHTML = commentsHtml;
                    }, 100);
                }
            });
        }
        
        
        
        function submitComment() {
            var commentText = document.getElementById('commentText').value;
            var toiletNo = document.querySelector('.modal').getAttribute('data-no');
            var userKey = ${loginUser.memberNo};

            var body = {
                "content": commentText,
                "toiletNo": toiletNo,
                "userKey": userKey
            }

            $.ajax({
                type: "POST",
                url: "/springProject/v1/review/reply",
                data: JSON.stringify(body),
                contentType: "application/json",
                success: function() {
                    loadComments(toiletNo);
                }
            });
        }

        // 좋아요 기능
        var isLiked = false;

        function toggleLike() {
            var userKey = ${loginUser.memberNo};

            if (!userKey) {
                alert("로그인 후 이용해주세요.");
                return;
            }

            var toiletNo = document.querySelector('.modal').getAttribute('data-no');
            var likeIcon = document.querySelector('.like-icon');

            var toiletKey = toiletNo;
            var toiletLikeKey = isLiked ? 0 : 1;

            var formData = new FormData();
            formData.append('toiletKey', toiletKey);
            formData.append('userKey', userKey);
            formData.append('toiletLikeKey', toiletLikeKey);

            $.ajax({
                type: "POST",
                url: "/springProject/like",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if (!isLiked) {
                        likeIcon.classList.add('liked');
                        likeIcon.innerHTML = '❤️';
                        alert('좋아요가 등록되었습니다.');
                    } else {
                        likeIcon.classList.remove('liked');
                        likeIcon.innerHTML = '🤍';
                        alert('좋아요가 취소되었습니다.');
                    }
                    isLiked = !isLiked; // 좋아요 상태 반전
                },
                error: function(error) {
                    console.error('Error:', error);
                    alert('좋아요 등록에 실패했습니다.');
                }
            });
        }

        function scrap(toiletNo) {
            var sendData = {
                toiletNo: toiletNo
            }
            $.ajax({
                url: "/springProject/scrap",
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: JSON.stringify(sendData),
                success: function(data) {
                    alert(data.msg);
                    $(".star").text(data.cnt == 0 ? "☆" : "⭐");
                },
                error: function(error) {
                    console.log(error);
                    alert("통신 에러" + error);
                }
            });
        }

        function filterPosts() {
            var searchInput = document.getElementById('searchInput').value.toLowerCase();
            var posts = document.getElementsByClassName('post');

            for (var i = 0; i < posts.length; i++) {
                var post = posts[i];
                var name = post.getAttribute('data-name').toLowerCase();
                var address = post.getAttribute('data-address').toLowerCase();
                var district = post.getAttribute('data-district').toLowerCase();

                if (name.includes(searchInput) || address.includes(searchInput) || district.includes(searchInput)) {
                    post.style.display = '';
                } else {
                    post.style.display = 'none';
                }
            }
            setPostEventListeners();
        }

        document.addEventListener('DOMContentLoaded', function() {
            setPostEventListeners();
        });
    </script>
    
    <%@ include file="../common/footer.jsp" %>
</body>
</html>
