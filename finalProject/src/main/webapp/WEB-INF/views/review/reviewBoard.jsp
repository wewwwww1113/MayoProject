<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  
    
	
	<style>
	
	
	.like-icon {
        cursor: pointer;
        font-size: 50px; /* 원하는 크기로 조정 */
        /* float: right; */ /* float을 사용할 경우 */
        /* margin-left: auto; */ /* flexbox를 사용할 경우 */
    }
	
	.modal-footer {
        display: flex;
        justify-content: space-between; /* 좋아요 아이콘과 다른 요소 사이의 간격을 유지하기 위해 */
        align-items: center; /* 세로 중앙 정렬 */
    }
	
        body {
            font-family: Arial, sans-serif;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            text-align: center;
        }

        .search-bar {
            margin: 20px 0;
        }

        .search-bar input,
        .search-bar select,
        .search-bar button {
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
	<%@include file="../common/header.jsp" %>

	
    <div class="container">
        <br><br>
        <h1>화장실 게시판</h1>
        <div class="search-bar">
            <input type="text" placeholder="Search">
            <select id="location" name="location" required>
                <option value="" disabled selected>지역을 선택하세요</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="광주">광주</option>
            </select>
            <button type="button">조회</button>
        </div>
        
        <h5>test</h5>
        안녕?  ${loginUser.memberNo} 이거야 
        <br>
        <br>
        
        <button name="${count}" id="myButton">카운터</button>
        
        <br>
        
        <script>
        const button = document.getElementById('myButton');
        button.addEventListener('click', function() {
            // Log the button's name attribute value to the console
            console.log(button.getAttribute('name'));
        });
    </script>
     
        
        
        <div class="posts" id="postContainer">
            <!-- 화장실 정보를 반복적으로 출력 -->
            <c:forEach var="t" items="${t}" >
                <div class="post" data-name="${t.toiletName}" data-address="${t.toiletAddress}" data-open="${t.toiletOpen }">
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

    <!-- 1. 모달 메인페이지  -->
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
					<span class="star" onclick="rateStar(1)">☆</span> <span
						class="star" onclick="rateStar(2)">☆</span> <span class="star"
						onclick="rateStar(3)">☆</span> <span class="star"
						onclick="rateStar(4)">☆</span> <span class="star"
						onclick="rateStar(5)">☆</span>
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
					<input type="file" id="uploadInput" accept="image/*"
						onchange="previewImage(event)">
				</div>
				<div align="center">
					<br> <img id="uploadPreview" src="#" alt="이미지 미리보기"
						style="max-width: 100%; display: none;"> <br>
					<br>
					<button onclick="saveImage()">저장</button>
				</div>
			</div>
		</div>
	</div>


	<script>
		//댓글 목록
		function replyList(){
			$.ajax({
				url : "replyList.bo",
				data : {
					toiletNo : ${t.toiletNo}	
				},
				success : function(result){
					console.log(result);
				},
				error : function(){
					consol.log("통신 오류");
				}
			});
		}
	</script>



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
				<textarea id="commentText" rows="3" placeholder="댓글을 작성하세요"
					style="width: 100%;"></textarea>
				<button onclick="submitComment()">댓글 작성</button>
			</div>
		</div>
	</div>

	<script>
		// 모달 메인창
		function openModal(name, address, open) {
			var modal = document.getElementById("modal");
			var modalBody = document.getElementById("modalBody");

			
			modalBody.innerHTML = "<div class='modal-header'>" +
           // "<span class='scrap-icon' onclick='toggleScrap()'>⭐</span>" +
            "<h2>" + name + "</h2>" +
            "</div>" +
           "<br>"+
            "<p>위치: " + address + "</p>" +
            "<p>개방 시간: " + open + "</p><br>" +
            "<button class='btn btn-primary' onclick=\"openRatingModal()\">평점 남기기</button>" +
            "<button class='btn btn-secondary' onclick=\"openUploadModal()\">이미지 업로드</button>" +
            "<button class='btn btn-info' onclick=\"openReviewModal(${postId})\">리뷰 작성 </button> <span class='like-icon' onclick='toggleLike()'>❤️</span> (0)";
            
            

			
			
			
			
			modal.style.display = "block";
		}

		function closeModal() {
			var modal = document.getElementById("modal");
			modal.style.display = "none";
		}

		document.getElementById('postContainer').addEventListener('click',
				function(event) {
					var post = event.target.closest('.post');
					if (post) {
						var name = post.getAttribute('data-name');
						var address = post.getAttribute('data-address');
						var open = post.getAttribute('data-open');
						openModal(name, address, open);
					}
				});

		//평점 모달

		function openRatingModal() {
        // 평점 남기기 모달 보이기
        var ratingModal = document.getElementById('ratingModal');
        ratingModal.style.display = 'block';

        // 초기화 - 모든 별을 ☆로 설정
        var stars = document.getElementsByClassName('star');
        for (var i = 0; i < stars.length; i++) {
            stars[i].textContent = '☆';
        }

        // 입력 폼 초기화 - 값 0으로 설정
        var ratingInput = document.getElementById('ratingInput');
        ratingInput.value = '0';
    }

    function closeRatingModal() {
        // 평점 남기기 모달 닫기
        var ratingModal = document.getElementById('ratingModal');
        ratingModal.style.display = 'none';
    }

    function rateStar(value) {
        // 모든 별 초기화 (☆로 설정)
        var stars = document.getElementsByClassName('star');
        for (var i = 0; i < stars.length; i++) {
            stars[i].textContent = '☆';
        }

        // 클릭한 별까지 채워지도록 변경 (★로 설정)
        for (var i = 0; i < value; i++) {
            stars[i].textContent = '★';
        }

        // 입력 폼에 값 설정
        var ratingInput = document.getElementById('ratingInput');
        ratingInput.value = value;
    }

    function saveRating() {
        // 여기서 평점을 저장하는 로직을 추가할 수 있습니다.
        var rating = document.getElementById('ratingInput').value;
        alert('평점 ' + rating + '점이 저장되었습니다.');
        closeRatingModal();
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
			// 이미지 저장 로직을 구현할 수 있음
			var preview = document.getElementById('uploadPreview');
			var imageSrc = preview.src;
			alert("이미지를 저장합니다!");

			// 이미지 저장 후 모달 닫기
			closeUploadModal();
		}

		//댓글 

		function openReviewModal(postId) {
			var reviewModal = document.getElementById("reviewModal");
			reviewModal.style.display = "block";

			// 여기서 postId를 사용하여 해당 게시물의 댓글을 로드하는 로직을 추가할 수 있음
			loadComments(postId);
		}

		function closeReviewModal() {
			var reviewModal = document.getElementById("reviewModal");
			reviewModal.style.display = "none";
		}

		function loadComments(postId) {
			// postId를 기반으로 해당 게시물의 댓글을 로드하는 로직을 구현할 수 있음
			var commentsList = document.getElementById('commentsList');
			commentsList.innerHTML = "<p>댓글을 로드하는 중입니다...</p>";
			// 예시로 간단히 댓글 목록을 가져와서 출력하는 코드
			// 이 부분은 서버에서 데이터를 가져와야 하므로 실제 서버에서 데이터를 가져오는 방식으로 구현 필요
			setTimeout(function() {
				commentsList.innerHTML = "<p>댓글 1</p><p>댓글 2</p><p>댓글 3</p>"; // 예시로 댓글을 추가하는 부분
			}, 1000); // 1초 후에 댓글을 추가하는 예시 코드
		}

		function submitComment() {
			var commentText = document.getElementById('commentText').value;
			var commentsList = document.getElementById('commentsList');

			// 여기서 commentText를 서버에 전송하여 댓글을 저장하는 로직을 추가할 수 있음
			// 실제 서버와의 통신이 필요한 부분이므로 예시로 경고창을 띄우는 코드를 추가
			alert("댓글작성 완료! ");

			// 댓글 제출 후 화면에서 추가
			commentsList.innerHTML += "<p>" + commentText + "</p>";

		}
		
		
		
		// 좋아요 기능
		function toggleLike(boardId) {
        $.ajax({
            type: "POST",
            url: "/review/like/" + boardId,
            success: function(response) {
                if (response === "liked") {
                    alert('좋아요!');
                    // 좋아요 처리 후 UI 갱신 코드 작성
                } else if (response === "unliked") {
                    alert('좋아요 취소!');
                    // 좋아요 취소 처리 후 UI 갱신 코드 작성
                }
            },
            error: function() {
                alert('서버 오류가 발생했습니다.');
            }
        });
    }

		// 스크랩 기능
		function toggleScrap(postId) {
		    var scrapIcon = event.target;
		    var isScrapped = scrapIcon.classList.contains('scrapped');
		    
		    // 이미 스크랩했으면 취소하고, 아니면 스크랩 처리
		    if (isScrapped) {
		        scrapIcon.classList.remove('scrapped');
		        alert('스크랩 취소!');
		        // 스크랩 취소 처리를 서버로 전송할 수 있음
		    } else {
		        scrapIcon.classList.add('scrapped');
		        alert('스크랩!');
		        // 스크랩 추가 처리를 서버로 전송할 수 있음
		    }
		}
		
		
		
		
		
	</script>

	<%@include file="../common/footer.jsp" %>
</body>
</html>