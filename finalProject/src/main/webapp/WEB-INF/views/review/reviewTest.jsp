<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-L25xsCO3g0t2z8C2qQSTsUk6/soHd+aRkE26HYPOYyZqJ3aJNSjQsZ7u0DSK5nXe" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    
	<style>
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
        
        
        <div class="posts" id="postContainer">
        
            <div class="post" data-id="1" onclick="openModal(this)">
                <img src="image_url" alt="이미지">
                <div class="post-title">서울 관악구 낙성대 롯데리아</div>
                <div class="post-content">서울 관악구 낙성대 롯데리아</div>
                <div>❤️ ⭐</div>
            </div>
            
            
            <div class="post" data-id="2">
                <img src="image_url" alt="이미지">
                <div class="post-title">서울 당산 에레메팅 1F</div>
                <div class="post-content">서울 당산 에레메팅 1F</div>
                <div>❤️ ⭐</div>
            </div>
            <div class="post" data-id="3">
                <img src="image_url" alt="이미지">
                <div class="post-title">서울역 1번출구 앞</div>
                <div class="post-content">서울역 1번출구 앞</div>
                <div>❤️ ⭐</div>
            </div>
            <div class="post" data-id="4">
                <img src="image_url" alt="이미지">
                <div class="post-title">종로3가 화장실</div>
                <div class="post-content">종로3가 화장실</div>
                <div>❤️ ⭐</div>
            </div>
        </div>
        <div class="load-more">
            <button type="button" onclick="loadMorePosts()">더보기</button>
        </div>
    </div>

    <!-- 상세보기 모달 -->
    <div id="modal" class="modal">
        <div class="modal-content">
            <span class="modal-close" onclick="closeModal()">&times;</span>
            <div id="modalBody">
                <!-- 상세보기 내용이 여기 들어갑니다. -->
            </div>
        </div>
    </div>
    
    
    <!-- 평점 남기기 모달 -->
<div id="ratingModal" class="modal">
    <div class="modal-content">
        <span class="modal-close" onclick="closeRatingModal()">&times;</span>
        <div id="ratingModalBody">
            <!-- 평점 입력 폼 -->
            <h4 align="center">평점 남기기</h4>
            <div id="ratingStars" align="center">
                <span class="star" onclick="rateStar(1)">☆</span>
                <span class="star" onclick="rateStar(2)">☆</span>
                <span class="star" onclick="rateStar(3)">☆</span>
                <span class="star" onclick="rateStar(4)">☆</span>
                <span class="star" onclick="rateStar(5)">☆</span>
            </div>
            <input type="hidden" id="ratingInput" value="0">
            <button onclick="saveRating()">저장</button>
        </div>
    </div>
</div>
	
	
	
	
	<jsp:include page="../common/footer.jsp" />
	
	
	
	<script>
	<!-- 별 색상 -->
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
		
	</script>
	
	
	
	
	
	
	
	<script>
	function openModal(postElement) {
        // 클릭한 포스트 요소에서 데이터 가져오기
        var postId = postElement.getAttribute('data-id');
        var postTitle = postElement.querySelector('.post-title').textContent;
        var postContent = postElement.querySelector('.post-content').textContent;

        var imageUrl = 'WEB-INF/views/review/img/1.jpg';
        
        
        // 모달에 데이터 채우기
        var modalBody = document.getElementById('modalBody');
        modalBody.innerHTML = `
            <div align="center">
	        	<h4 align="center">화장실 이름</h4>
	            <img src="${imageUrl}" alt="리뷰 이미지">
	        </div>
	            <p>이름 : ${postTitle}</p>
	            <p>개방시간 : 09:00 - 18:00</p>
	            <p>상세정보 : ${postContent}</p>
	            <p>평점 : ${postContent}</p>
	            <button>이미지 업로드</button>
	            <button>리뷰작성</button>
	            <button>평점 남기기</button>
	          `;

        // 모달 보이기
        var modal = document.getElementById('modal');
        modal.style.display = 'block';
    }

    function closeModal() {
        // 모달 닫기
        var modal = document.getElementById('modal');
        modal.style.display = 'none';
    }
		
	
	</script>

	<!--  평점남기기 페이지  -->
	<script>
    function openModal(postElement) {
        // 클릭한 포스트 요소에서 데이터 가져오기
        var postId = postElement.getAttribute('data-id');
        var postTitle = postElement.querySelector('.post-title').textContent;
        var postContent = postElement.querySelector('.post-content').textContent;
        var imageUrl = 'WEB-INF/views/review/img/1.jpg'; // 이미지 경로

        // 모달에 데이터 채우기
        var modalBody = document.getElementById('modalBody');
        modalBody.innerHTML = `
            <div align="center">
                <h4 align="center">${postTitle}</h4>
                <img src="${imageUrl}" alt="리뷰 이미지">
            </div>
            <p>이름 : ${postTitle}</p>
            <p>개방시간 : 09:00 - 18:00</p>
            <p>상세정보 : ${postContent}</p>
            <p>평점 : ${postContent}</p>
            <button onclick="openRatingModal()">평점 남기기</button>
            <button>이미지 업로드</button>
            <button>리뷰 작성</button>
        `;

        // 모달 보이기
        var modal = document.getElementById('modal');
        modal.style.display = 'block';
    }
    
    
    
    

    function closeModal() {
        // 모달 닫기
        var modal = document.getElementById('modal');
        modal.style.display = 'none';
    }

    function openRatingModal() {
        // 평점 남기기 모달 보이기
        var ratingModal = document.getElementById('ratingModal');
        ratingModal.style.display = 'block';
    }

    function closeRatingModal() {
        // 평점 남기기 모달 닫기
        var ratingModal = document.getElementById('ratingModal');
        ratingModal.style.display = 'none';
    }

    function saveRating() {
        // 여기서 평점을 저장하는 로직을 추가할 수 있습니다.
        var rating = document.getElementById('ratingInput').value;
        alert('평점 ' + rating + '점이 저장되었습니다.');
        closeRatingModal();
    }
	</script>



	
</body>
</html>