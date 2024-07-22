package com.kh.springProject.store.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Store {
	
		private int storeNo;
	    private String pdName;
	    private String pdDescription;
	    private String pdImage;
	    private int price;
	    private String status;
}
