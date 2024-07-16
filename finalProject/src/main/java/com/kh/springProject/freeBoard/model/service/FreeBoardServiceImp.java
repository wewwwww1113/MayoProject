package com.kh.springProject.freeBoard.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.freeBoard.model.dao.FreeBoardDao;
import com.kh.springProject.freeBoard.model.vo.Category;
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
	public int cListCount(int categoryNo) {
		
		return fboardDao.cListCount(sqlSession,categoryNo);
	}

	@Override
	public ArrayList<freeBoard> orderByCategory(int categoryNo, PageInfo pi) {
	
		  return fboardDao.orderByCategory(sqlSession, categoryNo, pi);
	}

	@Override
	public ArrayList<Category> boardInsert() {
		// TODO Auto-generated method stub
		return fboardDao.boardInsert(sqlSession);
	}

	@Override
	public int listCountByCategory(int categoryNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
    public List<freeBoard> searchPostsByUserKey(Map<String, Object> searchParams) {
        return fboardDao.searchPostsByUserKey(sqlSession, searchParams);
    }

    @Override
    public int deletePostsByKey(List<Integer> postKeys) {
        return fboardDao.deletePostsByKey(sqlSession, postKeys);
    }

	@Override
	public List<freeBoard> searchBoard(String type, String searchContent) {
		  return fboardDao.searchBoard(sqlSession,type, searchContent);
	}

	@Override
	public int getSearchCount(String searchOption, String searchContent) {
		// TODO Auto-generated method stub
		return fboardDao.getSearchCount(sqlSession,searchOption,searchContent);
	}


}
