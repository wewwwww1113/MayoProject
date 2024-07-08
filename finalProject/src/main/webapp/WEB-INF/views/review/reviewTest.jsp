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
        body {
            font-family: Arial, sans-serif;
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

        .search-bar {
            margin: 20px 0;
        }

        .search-bar input, .search-bar button {
            padding: 10px;
            margin-right: 10px;
            font-size: 16px;
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
            cursor: pointer;
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

        .load-more {
            margin: 20px 0;
        }

        .load-more button {
            padding: 10px 20px;
            font-size: 16px;
        }

        /* 상세보기 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 10% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 500px;
            border-radius: 10px;
        }

        .modal-close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .star {
            font-size: 30px; /* 별의 크기 조정 */
            cursor: pointer;
            transition: color 0.3s; /* 색상 변화 애니메이션 */
        }

        .star:hover {
            color: gold; /* 마우스 호버 시 색상 변경 */
        }
    </style>
</head>
<body>
    <div class="container">
        <br><br>
        <h1>화장실 게시판</h1>
        
        <div>
            <p>누적 좋아요 횟수: ${result}</p>
            <p>유저가 누른 개인 좋아요 횟수: ${person}</p>
        </div>

        <div class="search-bar">
            <input type="text" id="searchInput" placeholder="Search (예: 강남구 길동주유소)">
            <button type="button" onclick="filterPosts()">조회</button>
        </div>

        <div class="posts" id="postContainer">
            <!-- 화장실 정보를 반복적으로 출력 -->
            <c:forEach var="t" items="${t}">
                <c:set var="district" value="${fn:substringBefore(t.toiletAddress, ' ')}" />
                <div class="post" data-name="${t.toiletName}" data-address="${t.toiletAddress}" data-district="${district}" data-no="${t.toiletNo}" data-open="${t.toiletOpen}">
                    <!-- 이미지와 화장실 정보 등 필요한 정보들을 출력 -->
                    <div class="post-title">${t.toiletName}</div>
                    <div class="post-content">${t.toiletAddress}</div>
                </div>
            </c:forEach>
        </div>

        <div class="load-more">
            <button type="button" onclick="loadMorePosts()">더보기</button>
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
                    <button onclick="saveRating()">평점 남기기</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 3. 이미지 업로드 모달 -->
    <div id="uploadModal" class="modal">
        <div class="modal-content">
            <span class="modal-close" onclick="closeUploadModal()">&times;</span>
            <div id="uploadModalBody">
                <h4 align="center">이미지 업로드</h4>
                <div align="center">
                    <input type="file" id="uploadInput" accept="image/*" onchange="previewImage(event)">
                </div>
                <div align="center">
                    <br>
                    <img id="uploadPreview" src="#" alt="이미지 미리보기" style="max-width: 100%; display: none;">
                    <br>
                    <br>
                    <button onclick="saveImage()">저장</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 4. 리뷰 작성 모달 -->
    <div id="reviewModal" class="modal">
        <div class="modal-content">
            <span class="modal-close" onclick="closeReviewModal()">&times;</span>
            <div id="reviewModalBody">
                <h4 align="center">댓글 목록</h4>
                <div id="commentsList">
                    <!-- 댓글 목록이 여기에 표시됩니다 -->
                </div>
                
                <hr>
                <h4 align="center">댓글 작성</h4>
                닉네임: ${loginUser.memberId }
                <textarea id="commentText" rows="3" placeholder="댓글을 작성하세요" style="width: 100%;"></textarea>
                <button onclick="submitComment()">댓글 작성</button>
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

            modalBody.innerHTML 
                = "<h2>" + name + "</h2><p>위치: " + address + "</p><p>개방 시간: " + openTime 
                + "</p><br><button class='btn btn-primary' onclick=\"openRatingModal(" + toiletNo + ")\">평점 남기기</button>"
                + " <button class='btn btn-info' onclick=\"openReviewModal(" + toiletNo + ")\">리뷰 작성</button>"
                + "<span class='like-icon' onclick='toggleLike()'>🤍</span>"
                + " <span class='star' onclick='scrap(" + toiletNo + ");'>☆</span>";
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
                }
            });

            setTimeout(function() {
                var commentsHtml = "";

                res.forEach(function(comment) {
                    commentsHtml += "<p>작성자 " + comment.userNickName + "</p><p>" + comment.content + "</p>";
                });
                document.getElementById('commentsList').innerHTML = commentsHtml;
            }, 10);
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
                    if (isLiked) {
                        alert('이미 좋아요를 누르셨습니다.');
                    } else {
                        likeIcon.classList.add('liked');
                        likeIcon.innerHTML = '❤️';
                        alert('좋아요가 등록되었습니다.');
                        likeIcon.style.pointerEvents = 'none';
                    }
                    isLiked = !isLiked;
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
