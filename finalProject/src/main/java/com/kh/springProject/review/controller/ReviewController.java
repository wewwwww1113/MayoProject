package com.kh.springProject.review.controller;

import org.apache.ibatis.annotations.AutomapConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.common.template.Pagination;
import com.kh.springProject.review.model.service.ReviewService;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	//목록 페이지 이동
	@RequestMapping("list.re")
	public String boardList(@RequestParam(value="currentPage",defaultValue="1")int currentPage
			   ,Model model) {

		
		int listCount = reviewService.listCount();
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		System.out.println(listCount);
		
		
		return "";
	}
	
	

}
