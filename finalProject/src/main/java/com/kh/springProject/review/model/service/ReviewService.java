package com.kh.springProject.review.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.review.model.vo.Reply;
import com.kh.springProject.review.model.vo.Review;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewReplyVO;

public interface ReviewService {
	
	//게시글 목록과 페이징처리까지 
	
		//게시글 총 개수 조회
		int listCount();
		//게시글 목록 조회
		ArrayList<Review> selectList(PageInfo pi);//PageInfo(페이징 처리에 필요한 데이터 객체)전달
		
		//게시글 작성
		int insertReview(Review r);
		//게시글 상세 조회
		Review selectReview(int reviewNo);
		//게시글 조회수 증가
		int increaseCount(int reviewNo);
		//게시글 수정 
		int updateReview(Review rv);
		//게시글 삭제
		int deleteReview(int reviewNo);
		
		//댓글 작성
		int insertReply(Reply r);
		
		//댓글 목록 조회
		ArrayList<Reply> replyList(int reviewNo);
		
		//게시글 조회수 top5 조회
		ArrayList<Review> selectTopList();
		
		
		//토탈추가
		int postLikeReview(ReviewReplyLikeVO like);
		
		
		
		//각게시물
		int personLike(ReviewReplyLikeVO like);
		
		//-----------------------------------------------
		
		
		int scrapCheck(String memberNo, int toiletNo);
		int scrap(String memberNo, int toiletNo);
		int scrapCancel(String memberNo, int toiletNo);
		
		// 평정 수정
		void updateStar(String memberNo, int toiletNo, int starCnt);
		
	
	

}
