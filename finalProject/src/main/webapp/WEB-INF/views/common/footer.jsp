<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로젝트 Footer</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style> 
        /* Footer 스타일 */
        .footer {
            background-color: gray;
            color: #fff;
            text-align: center;
            padding: 20px;
            position : fixed;
            bottom: 0;
            width: 100%;
        }
        
        .footer a {
            color: #fff;
            text-decoration: none;
        }

        .footer .social-icons a {
            color: #fff;
            font-size: 24px;
            margin: 0 10px;
        }
    </style>
</head>
<body>
    
    <!-- Footer 영역 -->
   <footer class="footer">
    <div>
        <p>All rights reserved &copy; 2024 ChamG-Mayo.</p>
        
        <p>
            <a href="#">개인정보 처리방침</a> |
            <a href="#">고객센터</a> |
            <!-- 인스타그램 아이콘 -->
            <a href="https://www.instagram.com/chamg_mayo?igsh=MXE4bzQybDBqNWR6Nw%3D%3D&utm_source=qr"><i class="fab fa-instagram"></i></a> |
            <!-- 페이스북 아이콘 -->
            <a href="https://www.facebook.com/profile.php?id=61562425906999"><i class="fab fa-facebook"></i></a>
        </p>
    </div>
</footer>
    
</body>
</html>