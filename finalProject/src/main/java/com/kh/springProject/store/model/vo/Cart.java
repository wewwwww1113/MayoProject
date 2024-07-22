package com.kh.springProject.store.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Cart {
	
		private int cartId;
	    private String memberNo;
	    private int storeNo;
	    private int quantity;
	    private Store store;
}
