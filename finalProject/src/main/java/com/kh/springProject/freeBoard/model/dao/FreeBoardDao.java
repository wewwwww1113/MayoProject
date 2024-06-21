package com.kh.springProject.freeBoard.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.common.model.vo.PageInfo;
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

		return sqlSession.insert("freeMapper.insertBoard",b);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("freeMapper.increaseCount",boardNo);
	}

	public freeBoard selectBoard(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("freeMapper.selectBoard", boardNo);
	}
	

	public int updateBoard(SqlSessionTemplate sqlSession, freeBoard b) {
		// TODO Auto-generated method stub
		return sqlSession.update("freeMapper.updateBoard",b);
	}

	public int deleteBoard(SqlSessionTemplate sqlSession, int boardNo) {
		
		return sqlSession.delete("freeMapper.deleteBoard",boardNo);
	}

	public ArrayList<fbReply> replyList(SqlSessionTemplate sqlSession, int boardNo) {
		return (ArrayList)sqlSession.selectList("freeMapper.replyList", boardNo);
		}

	public int insertReply(SqlSessionTemplate sqlSession, fbReply r) {
		return sqlSession.insert("freeMapper.insertReply",r);
	}

	public ArrayList<freeBoard> selectTopList(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("freeMapper.selectTopList");
	}

}
