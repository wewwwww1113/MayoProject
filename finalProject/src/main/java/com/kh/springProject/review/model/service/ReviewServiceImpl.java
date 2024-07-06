package com.kh.springProject.review.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.review.model.dao.ReviewDao;
import com.kh.springProject.review.model.vo.Reply;
import com.kh.springProject.review.model.vo.Review;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;

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
		
		return reviewDao.selectList(sqlSession,pi);
	}

	//게시글 작성
	@Override
	public int insertReview(Review r) {
		
		return reviewDao.insertReview(sqlSession,r);

	}

	//게시글 상세 조회
	@Override
	public Review selectReview(int reviewNo) {
		
		return reviewDao.selectReview(sqlSession,reviewNo);


	}

	//게시글 조회수 증가
	@Override
	public int increaseCount(int reviewNo) {
		// TODO Auto-generated method stub
		return reviewDao.increaseCount(sqlSession, reviewNo);
	}

	//게시글 수정
	@Override
	public int updateReview(Review r) {
	
		return reviewDao.updateReview(sqlSession,r);

	}

	//게시글 삭제
	@Override
	public int deleteReview(int reviewNo) {
		
		return reviewDao.deleteReview(sqlSession, reviewNo);

	}

	//댓글 작성
	@Override
	public int insertReply(Reply r) {
	
		return reviewDao.insertReply(sqlSession,r);

	}

	//댓글 목록 조회
	@Override
	public ArrayList<Reply> replyList(int reviewNo) {
		// TODO Auto-generated method stub
		return reviewDao.replyList(sqlSession,reviewNo);
	}

	@Override
	public ArrayList<Review> selectTopList() {
		// TODO Auto-generated method stub
		return null;
	}


	//토탈
	@Override
	public int postLikeReview(ReviewReplyLikeVO like) {
		// TODO Auto-generated method stub
		return reviewDao.insertLike(sqlSession,like);
	}

	//각각
	@Override
	public int personLike(ReviewReplyLikeVO like) {
		// TODO Auto-generated method stub
		return reviewDao.personLike(sqlSession,like);
	}

	
	
	//----------------------------------------
	
	@Override
	public int scrapCheck(String memberNo, int toiletNo) {
		// TODO Auto-generated method stub
		return reviewDao.scrapCheck(sqlSession,memberNo, toiletNo);
	}

	@Override
	public int scrap(String memberNo, int toiletNo) {
		// TODO Auto-generated method stub
		return reviewDao.scrap(sqlSession,memberNo,toiletNo);
	}

	@Override
	public int scrapCancel(String memberNo, int toiletNo) {
		// TODO Auto-generated method stub
		return reviewDao.scrapCancel(sqlSession,memberNo,toiletNo);
	}

	@Override
	public void updateStar(String memberNo, int toiletNo, int starCnt) {
		reviewDao.updateStar(sqlSession, memberNo, toiletNo, starCnt);
	}

}
