<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>WebSocket Chat</title>
    <script type="text/javascript">
        let socket = new WebSocket("ws://localhost:8888/chat");

        socket.onmessage = function(event) {
            let message = event.data;
            // 메시지 처리 로직 (예: 채팅창에 추가)
        };

        function sendMessage() {
            let message = document.getElementById("message").value;
            socket.send(message);
            document.getElementById("message").value = "";
        }
    </script>
</head>
<body>
    <input type="text" id="message" />
    <button onclick="sendMessage()">Send</button>
</body>
</html>