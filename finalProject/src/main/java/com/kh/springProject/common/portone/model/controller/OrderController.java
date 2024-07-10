package com.kh.springProject.common.portone.model.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.common.portone.model.service.OrderService;
import com.kh.springProject.common.portone.model.vo.Order;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.store.model.vo.Cart;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class OrderController {
	
	@Autowired
    private OrderService orderService;
	
	/*
	 * @RequestMapping("order.do") public String Order() { return "order/orderView";
	 * }
	 */
	
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
	    // OrderService를 통해 주문 정보를 데이터베이스에 저장
	    int result = orderService.insertOrder(order);
	    // 데이터베이스에 주문 정보 저장 후, 결제 완료 페이지로 이동
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
