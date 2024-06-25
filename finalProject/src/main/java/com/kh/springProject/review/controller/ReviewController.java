package com.kh.springProject.review.controller;


import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.map.model.service.MapService;
import com.kh.springProject.map.model.vo.Map;
import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.service.ReviewService;
import com.kh.springProject.review.model.vo.ReviewLikes;



@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MapService mapService;
	
	
	
	
	
	@GetMapping("board.re")
	public ModelAndView getAllToilets(Member m, Map map, ModelAndView mv) {

		//map 전체 정보
		List<Map> t = mapService.getAllToilets(map);
    	mv.setViewName("review/reviewBoard");
    	mv.addObject("t", t);

//    	-----------------------------------------------------------------------
    	
    	// member 전체 정보
    	Member loginUser = memberService.loginMember(m);
    	
    	mv.addObject("loginUser", loginUser);
    	
//    	-----------------------------------------------------------------------
    	
    	// 검색창 기능 구현
    	
    	
    	
    	
    	
    	
    	
        return mv;
    }
	
	
	
	//좋아요 기능 구현
	@PostMapping("board.re")
	public String freeDetail(int boardNo, String userNo, Model model) {
		
		int count = reviewService.reviewLikes(boardNo);
		
		model.addAttribute("count", count );
		
		
		
		
//		ReviewLikes like = new ReviewLikes();
//		
//		like.setBoardNo(boardNo);
//		like.setUserNo(userNo);
		
		return "review/reviewBoard";
	}
	
	
	
	
	
	
	
	
	
	
	
}