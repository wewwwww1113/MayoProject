package com.kh.springProject.websocket;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.springProject.csBoard.model.vo.chatFileUtil;
import com.kh.springProject.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class chatWebSocketHandler extends TextWebSocketHandler {
	private static final int MAX_SESSIONS = 3;
	// 저장소 준비
	private Set<WebSocketSession> users = new CopyOnWriteArraySet<>();

	private final ObjectMapper objectMapper = new ObjectMapper();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		log.debug("정보 : {}", session.getAttributes().get("loginUser"));
		users.add(session);

		Member loginUser = ((Member) (session.getAttributes().get("loginUser")));
		String userNickname = loginUser.getMemberNick();

		System.out.println(loginUser);
		System.out.println(userNickname);

		if (users.size() >= MAX_SESSIONS) {
			session.sendMessage(new TextMessage(
					objectMapper.writeValueAsString(new Message("System", "최대 접속 인원이 초과되었습니다. 잠시만 기다려 주세요."))));
			session.close();
			System.out.println("Session closed due to max limit: " + session.getId());
		} else {
			users.add(session);
			System.out.println("New session opened: " + session.getId() + ", User: " + userNickname);
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String payload = message.getPayload();
		Message msg = objectMapper.readValue(payload, Message.class);
		System.out.println("Received message: " + msg.getContent() + " from " + msg.getSender());

		chatFileUtil.saveMessage(msg.getSender(), msg.getContent());

		for (WebSocketSession sess : users) {
			try {
				sess.sendMessage(new TextMessage(objectMapper.writeValueAsString(msg)));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, org.springframework.web.socket.CloseStatus status)
			throws Exception {
		users.remove(session);
		System.out.println("Session closed: " + session.getId());
	}

	private static class Message {
		private String sender;
		private String content;

		public Message() {
		}

		public Message(String sender, String content) {
			this.sender = sender;
			this.content = content;
		}

		public String getSender() {
			return sender;
		}

		public void setSender(String sender) {
			this.sender = sender;
		}

		public String getContent() {
			return content;
		}

		public void setContent(String content) {
			this.content = content;
		}
	}
}
