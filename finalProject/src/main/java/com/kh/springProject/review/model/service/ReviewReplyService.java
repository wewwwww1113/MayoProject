package com.kh.springProject.review.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.review.model.dao.ReviewReplyDao;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewReplyVO;

@Service
public class ReviewReplyService {

	@Autowired
	private ReviewReplyDao reviewReplyDao;

//＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠
	//댓글 작성
	public void postReview(ReviewReplyVO reviewReplyVO) {
		
		reviewReplyDao.postReview(reviewReplyVO);

	}
//＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠
	
	
	
	//댓글 목록
	public List<ReviewReplyVO> getReview(int toiletNo) {
		// TODO Auto-generated method stub
		return reviewReplyDao.getReview(toiletNo);
	}
	
//	//좋아요 눌렀을 때
//	public void postLikeReview(int userKey, int toiletKey, int toiletLikeKey) {
//        reviewReplyDao.postLikeReview(userKey, toiletKey, toiletLikeKey);
//    }
	
	//좋아요 전체 보기
	public List<ReviewReplyLikeVO> gettLikeReview(int userNo) {
		// TODO Auto-generated method stub
		return reviewReplyDao.gettLikeReview(userNo);
	}
	
	//수정된 부분
		 public List<ReviewReplyVO> getReviewsByUserKey(int userKey) {
		        return reviewReplyDao.getReviewsByUserKey(userKey);
		    }
		 
		  // 검색 기능 추가된 부분
		    public List<ReviewReplyVO> searchReviewsByUserKey(Map<String, Object> searchParams) {
		        return reviewReplyDao.searchReviewsByUserKey(searchParams);
		    }
		    //글 삭제
		    public int deleteReviewByKey(int reviewReplyKey) {
		        return reviewReplyDao.deleteReviewByKey(reviewReplyKey);
		    }
		    //글 일괄 삭제
		    public int deleteReviewsByKey(List<Integer> reviewReplyKeys) {
		        return reviewReplyDao.deleteReviewsByKey(reviewReplyKeys);
		    }









	
	
	
}
