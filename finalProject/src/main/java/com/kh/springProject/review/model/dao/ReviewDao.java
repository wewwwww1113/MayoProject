package com.kh.springProject.review.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.review.model.vo.Reply;
import com.kh.springProject.review.model.vo.Review;

@Repository
public class ReviewDao {

	public int listCount(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("reviewMapper.listCount");
	}

	public ArrayList<Review> selectList(SqlSessionTemplate sqlSession, PageInfo pi) {

		//페이징 처리
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectList",null,rowBounds);
	}

	//조회수 증가
	public int increaseCount(SqlSessionTemplate sqlSession, int reviewNo) {
		
		return sqlSession.update("reviewMapper.increaseCount",reviewNo);
	}
	
	//상세조회
	public Review selectReview(SqlSessionTemplate sqlSession, int reviewNo) {
		
		return sqlSession.selectOne("reviewMapper.selectReview", reviewNo);

	}
	
	//게시글 작성
	public int insertReview(SqlSessionTemplate sqlSession, Review r) {
		
		System.out.println(1);
		
		return sqlSession.insert("reviewMapper.insertReview", r);
	}
	
	//게시글 수정
	public int updateReview(SqlSessionTemplate sqlSession, Review r) {
		// TODO Auto-generated method stub
		return sqlSession.update("reviewMapper.updateReview",r);
	}

	//게시글 삭제
	public int deleteReview(SqlSessionTemplate sqlSession, int reviewNo) {
		
		return sqlSession.delete("reviewMapper.deleteReview",reviewNo);

	}
	
	//댓글 목록 조회
	public ArrayList<Reply> replyList(SqlSessionTemplate sqlSession, int reviewNo) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("reviewMapper.replyList", reviewNo);

	}
	
	//댓글 등록
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		// TODO Auto-generated method stub
		return sqlSession.insert("reviewMapper.insertReply",r);

	}

}
