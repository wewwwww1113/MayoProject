package com.kh.springProject.csBoard.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Message {
	  private String sender;
      private String content;
      private String type;
      
	
}
