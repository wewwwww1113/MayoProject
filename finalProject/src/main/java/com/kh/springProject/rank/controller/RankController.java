package com.kh.springProject.rank.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.map.model.service.MapService;
import com.kh.springProject.map.model.vo.Map;
import com.kh.springProject.rank.model.service.RankService;
import com.kh.springProject.rank.model.vo.Rank;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewStar;

@Controller
public class RankController {
	
	@Autowired
	private RankService rankService;
	
	@Autowired
	private MapService mapService;
	

	@GetMapping("rank.ra")
	public ModelAndView RankList(Map m, ReviewStar rs, HttpSession session ) {
	      
		ModelAndView mv = new ModelAndView();
		
	    // 화장실 전체조회
	    List<Map> t = mapService.getAllToilets(m);
	    
	    // 별점 전체 조회
	    List<ReviewStar> star = rankService.getAllStars(rs);
	    
	   
	   ArrayList<Rank>  avg = rankService.avgStar();
	    
	    
	    mv.setViewName("rank/rankForm");
	    mv.addObject("t", t);
	    mv.addObject("star", star);
	    mv.addObject("avg", avg);
	    
	    return mv;
	}
	@GetMapping("rank2.ra")
	@ResponseBody
	public java.util.Map<String, Object> RankList1(Map m, ReviewStar rs, HttpSession session) {
	    // 화장실 전체조회
	    List<Map> t = mapService.getAllToilets(m);
	    
	    // 별점 전체 조회
	    List<ReviewStar> star = rankService.getAllStars(rs);
	    
	    // 평균 별점 조회
	    ArrayList<Rank> avg = rankService.avgStar();
	    java.util.Map<String, Object> response = new HashMap<>();
	    response.put("toilets", t);
	    response.put("stars", star);
	    response.put("avg", avg);
	    
	    return response;
	}



	
}
