package com.kh.springProject.freeBoard.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder

public class fbReply {

	private int replyNo;
	private String replyContent;
	private String status;
	private String replyWriter;
	private int refBno;
	private Date createDate;
	
}
