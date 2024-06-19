package com.kh.springProject.map.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.map.model.vo.Map;

@Repository
public class MapDao {
	

	/*
	 * public int listCount(SqlSessionTemplate sqlSession) { // TODO Auto-generated
	 * method stub return sqlSession.selectOne("mapMapper.listCount"); }
	 */

	/*
	 * public ArrayList<Map> selectList(SqlSessionTemplate sqlSession, PageInfo pi)
	 * {
	 * 
	 * // 페이징 처리 int limit = pi.getBoardLimit(); int offset = (pi.getCurrentPage() -
	 * 1) * limit;
	 * 
	 * RowBounds rowBounds = new RowBounds(offset, limit);
	 * 
	 * return (ArrayList) sqlSession.selectList("mapMapper.selectList", null,
	 * rowBounds); }
	 */



	public List<Map> selectAllToilets(SqlSessionTemplate sqlSession,Map m) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapMapper.selectAllToilets",m);
	}

}