package com.kh.springProject.common.portone.model.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.common.portone.model.service.OrderService;
import com.kh.springProject.common.portone.model.vo.Order;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {
	
	@Autowired
    private OrderService orderService;
	
	@PostMapping("/insertPay.or")
	@ResponseBody
	public int insertOrder(@RequestParam("pg") String pg,
	                       @RequestParam("merchantUid") String merchantUid,
	                       @RequestParam("memberNo") String memberNo,
	                       @RequestParam("amount") int amount,
	                       @RequestParam("buyerName") String buyerName,
	                       @RequestParam("buyerAddr") String buyerAddr,
	                       @RequestParam("buyerTel") String buyerTel,
	                       @RequestParam("paidAt") int paidAt,
	                       @RequestParam("receiptUrl") String receiptUrl,
	                       @RequestParam("pdName") String pdName,
	                       HttpServletRequest request) {

	    // Order 객체 생성 및 데이터 설정
	    Order order = new Order();
	    order.setPg(pg);
	    order.setMcUid(merchantUid);
	    order.setMemberNo(memberNo);
	    order.setPdName(pdName); 
	    order.setAmount(amount);
	    order.setBuyerName(buyerName);
	    order.setBuyerTel(buyerTel);
	    order.setBuyerAddr(buyerAddr);
	    order.setPaidAt(paidAt);
	    order.setReceiptUrl(receiptUrl); 
	    
	    int result = orderService.insertOrder(order);
	    
	    if (result > 0) {
	        request.setAttribute("orderNo", order.getOrderNo()); // 주문 번호를 결제 완료 페이지로 전달
	        return 1; // 결제 완료 페이지로 이동
	    } else {
	        return 0; // 결제 오류 페이지로 이동 또는 오류 처리
	    }
	}
	
	
	@GetMapping("/pay.or/{mcUid}") // {mcUid}를 URI 변수로 사용
	@ResponseBody
	public ModelAndView responsePage(@PathVariable("mcUid") String mcUid, ModelAndView mv) {
	    Order order = orderService.getOrder(mcUid);
	    mv.addObject("order", order);
	    mv.setViewName("order/payment"); // 주문 정보를 보여줄 뷰로 이동
	    return mv;
	}
	

	
	
	
	
	
}
