package com.kh.springProject.rank.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.map.model.service.MapService;
import com.kh.springProject.map.model.vo.Map;
import com.kh.springProject.rank.model.service.RankService;
import com.kh.springProject.review.model.vo.ReviewStar;

@Controller
public class RankController {
	
	@Autowired
	private RankService rankService;
	
	@Autowired
	private MapService mapService;
	

	@GetMapping("rank.ra")
	public ModelAndView RankList(Map m, ReviewStar rs, ModelAndView mv, HttpSession session
			,@RequestParam(required = false) Integer toiletNo ) {
	      
	    // 화장실 전체조회
	    List<Map> t = mapService.getAllToilets(m);
	    
	    // 별점 전체 조회
	    List<ReviewStar> star = rankService.getAllStars(rs);
	    
	    // toiletNo가 null이 아닌 경우에만 평균 별점 조회
	    int avg = 0;
	    if (toiletNo != null) {
	        avg = rankService.avgStar(toiletNo);
	    }
	    
	    System.out.println(t);
	    System.out.println(star);
	    System.out.println(avg);
	    
	    mv.setViewName("rank/rankForm");
	    mv.addObject("t", t);
	    mv.addObject("star", star);
	    mv.addObject("avg", avg);
	    
	    return mv;
	}

	
	
	
}
