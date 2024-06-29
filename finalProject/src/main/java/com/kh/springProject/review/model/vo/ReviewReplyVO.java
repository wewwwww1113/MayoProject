package com.kh.springProject.review.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewReplyVO {
	
	private int userKey;
	private int reviewReplyKey;
	private String content;
	private Date createTime;
	private Date updateTime;
	private String delYn;
	private int toiletNo;
	private String userNickName;
	

}
