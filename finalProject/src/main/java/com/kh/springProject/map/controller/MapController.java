package com.kh.springProject.map.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.common.template.Pagination;
import com.kh.springProject.map.model.service.MapService;
import com.kh.springProject.map.model.vo.Map;


@Controller
//@RequestMapping("/api")
public class MapController {

    @Autowired
    private MapService mapService;
	
	/*
	 * //vo 조회용
	 * 
	 * @RequestMapping("list.ma") public String
	 * MapList(@RequestParam(value="currentPage",defaultValue="1")int currentPage
	 * ,Model model) {
	 * 
	 * int listCount = mapService.listCount(); int pageLimit = 10; int boardLimit =
	 * 5;
	 * 
	 * PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit,
	 * boardLimit);
	 * 
	 * ArrayList<Map> list = mapService.selectList(pi);
	 * 
	 * model.addAttribute("pi",pi); model.addAttribute("list",list);
	 * 
	 * System.out.println(pi); System.out.println(list);
	 * 
	 * return "rank/rankForm3";
	 * 
	 * }
	 */
    @ResponseBody
	@RequestMapping(value = "list.ma", produces = MediaType.APPLICATION_JSON_VALUE)
//    @GetMapping(value = "list.ma", produces = MediaType.APPLICATION_JSON_VALUE)
//    @GetMapping("/list.ma")
    public List<Map> getAllToilets(Map m) {
    	List<Map> list = mapService.getAllToilets(m);
    	System.out.println(list);
        return list;
    }
}