package com.kh.springProject.csBoard.model.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.csBoard.model.dao.csDao;
import com.kh.springProject.csBoard.model.vo.csBoard;


@Service
public class csServiceImp implements csService {


	@Autowired
	private SqlSessionTemplate sqlSession;
    @Autowired
    private csDao csDao;
	@Override
	public ArrayList<csBoard> selectCsList(String category) {
		 return csDao.selectCsList(sqlSession,category);
	}
	public int incrementViewCount(int csNo) {
		// TODO Auto-generated method stub
		return csDao.incrementViewCount(sqlSession,csNo);
	}
	public ArrayList<csBoard> selectLodgingMain() {
		// TODO Auto-generated method stub
		return csDao.selectLodgingMain(sqlSession);
	}
	
	
	
	
	
	

}
