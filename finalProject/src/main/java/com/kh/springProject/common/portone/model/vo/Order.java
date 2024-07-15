package com.kh.springProject.common.portone.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {
	private int orderNo;
	private String pg; // pg : 'html5_inicis',
	private String mcUid; // merchant_uid: "IMP"+makeMerchantUid,
	private String memberNo;
	private String pdName; // name : productName,
	private int amount;// amount : totalPrice,
	private String buyerName;// },
	private String buyerTel;// buyer_name : userName,
	private String buyerAddr;// buyer_tel : phone,
	private int PaidAt;
	private String receiptUrl;
	private Date orderDate;
	

}
