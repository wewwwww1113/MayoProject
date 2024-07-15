package com.kh.springProject.freeBoard.model.dao;

import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.freeBoard.model.vo.Category;
import com.kh.springProject.freeBoard.model.vo.fbReply;
import com.kh.springProject.freeBoard.model.vo.freeBoard;

@Repository
public class FreeBoardDao {

	public int listCount(SqlSessionTemplate sqlSession) {

		return sqlSession.selectOne("freeMapper.listCount");
	}

	public ArrayList<freeBoard> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {
		// 페이징 처리를 위한 RowBounds 객체 생성

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("freeMapper.selectList", null, rowBounds);
	}

	public int insertBoard(SqlSessionTemplate sqlSession, freeBoard b) {

		return sqlSession.insert("freeMapper.insertBoard", b);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("freeMapper.increaseCount", boardNo);
	}

	public freeBoard selectBoard(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("freeMapper.selectBoard", boardNo);
	}

	public int updateBoard(SqlSessionTemplate sqlSession, freeBoard b) {
		// TODO Auto-generated method stub
		return sqlSession.update("freeMapper.updateBoard", b);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {

		return sqlSession.delete("freeMapper.deleteBoard", boardNo);
	}

	public ArrayList<fbReply> replyList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList) sqlSession.selectList("freeMapper.replyList", boardNo);
	}

	public int insertReply(SqlSessionTemplate sqlSession, fbReply r) {
		return sqlSession.insert("freeMapper.insertReply", r);
	}

	public int cListCount(SqlSessionTemplate sqlSession, int categoryNo) {

		return sqlSession.selectOne("freeMapper.cListCount", categoryNo);
	}

	public ArrayList<freeBoard> orderByCategory(SqlSessionTemplate sqlSession, int categoryNo, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("freeMapper.orderByCategory", categoryNo, rowBounds);
	}

	public ArrayList<Category> boardInsert(SqlSessionTemplate sqlSession) {

		return (ArrayList) sqlSession.selectList("freeMapper.boardInsert");
	}

	public List<freeBoard> selectSearchList(SqlSessionTemplate sqlSession, freeBoard freeBoard) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("freeMapper.selectSearchList", freeBoard);
	}

	public List<freeBoard> searchBoard(SqlSessionTemplate sqlSession, String type, String searchContent) {

		Map<String, Object> params = new HashMap<>();
		params.put("type", type);
		params.put("searchContent", searchContent);
		return sqlSession.selectList("freeMapper.searchBoard", params);
	}

	public int getSearchCount(SqlSessionTemplate sqlSession, String searchOption, String searchContent) {
		  
		
		String type;
	        switch (searchOption) {
	            case "writer":
	                type = "BOARD_WRITER";
	                break;
	            case "title":
	                type = "BOARD_TITLE";
	                break;
	            default:
	                type = "BOARD_WRITER";
	        }

		return sqlSession.selectOne("freeMapper.getSearchCount", type);

	}
}