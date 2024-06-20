package com.kh.springProject.rank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.rank.model.service.RankService;

@Controller
public class RankController {
	
	@Autowired
	private RankService rankService;
	
	//페이지 이동
	@GetMapping("list2.ra")
	public String RankList() {
		
		return "rank/rankForm2";
	}
	
//	//게시글 상세보기
//	@RequestMapping("detail.ra")
//	public ModelAndView selectRank(int reviewNo, ModelAndView mv) {
//		
//		
//	}
	
	
	
	
	
	
}
