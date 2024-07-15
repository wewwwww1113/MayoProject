package com.kh.springProject.csBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kh.springProject.csBoard.model.service.csService;
import com.kh.springProject.csBoard.model.vo.csBoard;

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
	@RequestMapping(value="selectList.cs",produces = "application/json;charset=UTF-8")
	 public  ArrayList<csBoard> csSelectList(@RequestParam String category){
		
		ArrayList<csBoard> list = csService.selectCsList(category);
	        
		 System.out.println(list);
		 
		 return list;
	        
	        
	        
	        
		
		
		
	}
	
	
	
}
