package com.kh.springProject.review.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewScrap {
	
	private int scrapNo;
	private int memberNo;
	private int toiletNo;
	private String toiletName;
    private String toiletAddress;

}
