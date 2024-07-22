package com.kh.springProject.map.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.kh.springProject.map.model.service.MapService;
import com.kh.springProject.map.model.vo.Map;


@Controller
public class MapController {

    @Autowired
    private MapService mapService;
    
    @RequestMapping("/map")
    public String showMap() {
        return "map/testView"; // /WEB-INF/views/map/testView.jsp로 매핑
    }
    
    @ResponseBody
	@RequestMapping(value = "list.ma", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Map> getAllToilets(Map m) {
    	List<Map> list = mapService.getAllToilets(m);
    	
        return list;
    }
}