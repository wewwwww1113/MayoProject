package com.kh.springProject.review.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReviewLikes {
    
	private int likeNo; // 일련번호 
    
    
    private String userNo; // 회원 일련번호
    
    
    private int boardNo; // 화장실 일련번호
    
    
    private int createDt; // 날짜
	
    
    
    
}
