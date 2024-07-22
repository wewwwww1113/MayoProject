package com.kh.springProject.csBoard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.springProject.csBoard.model.service.csService;
import com.kh.springProject.csBoard.model.vo.csBoard;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class csController {

	@Autowired
	private csService csService;

	// 페이지 이동
	@GetMapping("list.cs")
	public String csList() {

		return "customerService/customerServiceView";

	}

	@ResponseBody
	@RequestMapping(value = "selectList.cs", produces = "application/json;charset=UTF-8")
	public ArrayList<csBoard> csSelectList(@RequestParam String category) {

		ArrayList<csBoard> list = csService.selectCsList(category);

	//System.out.println(list);

		return list;

	}

	 // Ajax 요청으로 조회수 증가 처리
	@ResponseBody
	@RequestMapping(value = "incrementViewCount", method = RequestMethod.POST)
	public String incrementViewCount(@RequestParam("csNo") int csNo) {
	    System.out.println(csNo);
		int result = csService.incrementViewCount(csNo);
	    
	    if (result > 0) {
	        return "조회수 증가 성공";
	    } else {
	        return "조회수 증가 실패";
	    }
	}

	@ResponseBody
	@GetMapping(value = "/list.cs", produces = "application/json;charset=UTF-8")
	public ArrayList<csBoard> getLodgings() {

		ArrayList<csBoard> list = csService.selectLodgingMain();
	//	System.out.println(list);
		return list;

	}
}
