package com.kh.springProject.review.model.vo;

import java.sql.Date;

public class Review {
	
	private int reviewNo; //	REVIEW_NO	NUMBER
	private String boardTitle;			//	REVIEW_TITLE	VARCHAR2(100 BYTE)
	private String boardWriter;			//	REVIEW_WRITER	VARCHAR2(4000 BYTE)
	private String boardContent;			//	REVIEW_CONTENT	VARCHAR2(4000 BYTE)
	private String originName;			//	ORIGIN_NAME	VARCHAR2(100 BYTE)
	private String changeName;			//	CHANGE_NAME	VARCHAR2(100 BYTE)
	private int count;			//	COUNT	NUMBER
	private Date createDate;			//	CREATE_DATE	DATE
	private String status;			//	STATUS	VARCHAR2(1 BYTE)
	
	//댓글 목록 조회할 때
	// private ArrayList<Reply> rList;
	
	
	
	
	
	
	
	

}
