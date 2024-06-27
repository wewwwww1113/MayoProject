package com.kh.springProject.csBoard.model.vo;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class csBoard {
	
	
	private int csNo;
	private String csQuestion;
	private String answer;
	private String category;
	private int count;
	
	
	
	
	
	
	
}
