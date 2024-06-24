package com.kh.springProject.freeBoard.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.freeBoard.model.dao.FreeBoardDao;
import com.kh.springProject.freeBoard.model.vo.fbReply;
import com.kh.springProject.freeBoard.model.vo.freeBoard;

@Service
public class FreeBoardServiceImp implements FreeBoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private FreeBoardDao fboardDao;

	@Override
	public int listCount() {

		return fboardDao.listCount(sqlSession);

	}

	@Override
	public ArrayList<freeBoard> selectList(PageInfo pi) {

		return fboardDao.selectList(sqlSession, pi);
	}

	@Override
	public int insertBoard(freeBoard b) {
		
		return fboardDao.insertBoard(sqlSession,b);
	}

	@Override
	public int increaseCount(int boardNo) {
		// TODO Auto-generated method stub
		return fboardDao.increaseCount(sqlSession, boardNo);
	}

	@Override
	public freeBoard selectBoard(int boardNo) {
		return fboardDao.selectBoard(sqlSession, boardNo);
	}

	@Override
	public int updateBoard(freeBoard b) {
		return fboardDao.updateBoard(sqlSession, b);
	}

	@Override
	public int deleteBoard(int boardNo) {
		return fboardDao.deleteBoard(sqlSession, boardNo);
	}

	@Override
	public ArrayList<fbReply> replyList(int boardNo) {
		// TODO Auto-generated method stub
		return fboardDao.replyList(sqlSession, boardNo);
	}

	@Override
	public int insertReply(fbReply r) {
		return fboardDao.insertReply(sqlSession, r);
	}

	@Override
	public ArrayList<freeBoard> selectTopList() {
		// TODO Auto-generated method stub
		return fboardDao.selectTopList(sqlSession);
	}

}
