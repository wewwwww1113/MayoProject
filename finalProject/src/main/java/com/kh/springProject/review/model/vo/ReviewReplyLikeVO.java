package com.kh.springProject.review.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewReplyLikeVO {
	
	private int userKey;
	private int reviewReplyKey;
	private int tolietKey;
	private int tolietLikeKey;
	

}
