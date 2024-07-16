package com.kh.springProject.csBoard.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.csBoard.model.vo.csBoard;

@Repository
public class csDao {

	public ArrayList<csBoard> selectCsList(SqlSessionTemplate sqlSession,String category) {

		return (ArrayList)sqlSession.selectList("csMapper.selectList",category);
		
	}

	public int incrementViewCount(SqlSessionTemplate sqlSession,int csNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("csMapper.incrementViewCount", csNo);
	}

	public ArrayList<csBoard> selectLodgingMain(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("csMapper.selectLodgingMain");
	}

}
