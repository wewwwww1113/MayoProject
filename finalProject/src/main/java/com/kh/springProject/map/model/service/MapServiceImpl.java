package com.kh.springProject.map.model.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.map.model.dao.MapDao;
import com.kh.springProject.map.model.vo.Map;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MapDao mapDao;
	
	@Override
    public List<Map> getAllToilets(Map m) {
        return mapDao.selectAllToilets(sqlSession,m);
    }

}