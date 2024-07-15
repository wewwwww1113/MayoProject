package com.kh.springProject.map.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.map.model.vo.Map;

@Repository
public class MapDao {
	
	public List<Map> selectAllToilets(SqlSessionTemplate sqlSession,Map m) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapMapper.selectAllToilets",m);
	}

}