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

	public void postReview(int memberNo, ReviewReplyVO reviewReplyVO) {
		// TODO Auto-generated method stub
		
		reviewReplyDao.postReview(memberNo,reviewReplyVO);
	}

	public List<ReviewReplyVO> getReview(int toiletNo) {
		// TODO Auto-generated method stub
		return reviewReplyDao.getReview(toiletNo);
	}

	public void postLikeReview(int userNo, int toiletNo) {
		// TODO Auto-generated method stub
		reviewReplyDao.postLikeReview(userNo,toiletNo);
	}

	public List<ReviewReplyLikeVO> gettLikeReview(int userNo) {
		// TODO Auto-generated method stub
		return reviewReplyDao.gettLikeReview(userNo);
	}
	


	
	
	
}
