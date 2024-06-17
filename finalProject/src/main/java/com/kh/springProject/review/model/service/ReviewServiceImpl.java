package com.kh.springProject.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.review.model.dao.ReviewDao;
import com.kh.springProject.review.model.vo.Reply;
import com.kh.springProject.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private ReviewDao reviewDao;
	
	
	//게시글 총 개수 조회
	@Override
	public int listCount() {
		
		return reviewDao.listCount(sqlSession);
	}
	
	//게시글 목록 조회
	@Override
	public ArrayList<Review> selectList(PageInfo pi) {
		// TODO Auto-generated method stub
		return null;
	}

	//게시글 작성
	@Override
	public int insertBoard(Review r) {
		// TODO Auto-generated method stub
		return 0;
	}

	//게시글 상세 조회
	@Override
	public Review selectBoard(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	//게시글 조회수 증가
	@Override
	public int increaseCount(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	//게시글 수정
	@Override
	public int updateBoard(Review rv) {
		// TODO Auto-generated method stub
		return 0;
	}

	//게시글 삭제
	@Override
	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	//댓글 작성
	@Override
	public int insertReply(Reply reply) {
		// TODO Auto-generated method stub
		return 0;
	}

	//댓글 목록 조회
	@Override
	public ArrayList<Reply> replyList(int boardNo) {
		// TODO Auto-generated method stub
		return null;
	}

	//게시글 조회수 top5 조회
	@Override
	public ArrayList<Review> selectTopList() {
		// TODO Auto-generated method stub
		return null;
	}

}
