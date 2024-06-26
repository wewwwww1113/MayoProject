package com.kh.springProject.review.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewReply {
	
			private String replyNo;	//	REPLY_NO	NUMBER
			private String replyContent;	//	REPLY_CONTENT	VARCHAR2(400 BYTE)
			private String refBno;	//	REF_BNO	VARCHAR2(200 BYTE)
			private Date createDate;	//	CREATE_DATE	DATE
			private String status;	//	STATUS	VARCHAR2(1 BYTE)
	
	

}
