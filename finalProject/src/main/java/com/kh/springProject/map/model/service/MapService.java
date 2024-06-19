package com.kh.springProject.map.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.map.model.vo.Map;

public interface MapService {
	
	
	/*
	 * int listCount();
	 * 
	 * ArrayList<Map> selectList(PageInfo pi);
	 */

	List<Map> getAllToilets(Map m);

}