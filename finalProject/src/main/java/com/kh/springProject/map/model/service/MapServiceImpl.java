package com.kh.springProject.map.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.map.model.dao.MapDao;
import com.kh.springProject.map.model.vo.Map;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MapDao mapDao;
	
	/*
	 * @Override public int listCount() { // TODO Auto-generated method stub return
	 * mapDao.listCount(sqlSession); }
	 * 
	 * @Override public ArrayList<Map> selectList(PageInfo pi) { // TODO
	 * Auto-generated method stub return mapDao.selectList(sqlSession,pi); }
	 */
//	@Override
//	public ArrayList<Map> selectList() {
//		// TODO Auto-generated method stub
//		return mapDao.selectList(sqlSession,pi);
//	}
	@Override
    public List<Map> getAllToilets(Map m) {
        return mapDao.selectAllToilets(sqlSession,m);
    }
	
	
	
	

}