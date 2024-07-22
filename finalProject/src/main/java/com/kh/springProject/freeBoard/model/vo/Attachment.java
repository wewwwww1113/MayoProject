package com.kh.springProject.freeBoard.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Attachment {


	private int fileNo;
	private String fileName;
	private String changeName;
	private String filePath;
	private Date uploadDate;
	private String fileLevel;
	private String status;
	private int refNo;
	
	
	
}
