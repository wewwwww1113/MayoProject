package com.kh.springProject.review.model.service;

import java.util.ArrayList;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.review.model.vo.Reply;
import com.kh.springProject.review.model.vo.Review;

public interface ReviewService {
	
	//게시글 목록과 페이징처리까지 
	
		//게시글 총 개수 조회
		int listCount();
		//게시글 목록 조회
		ArrayList<Review> selectList(PageInfo pi);//PageInfo(페이징 처리에 필요한 데이터 객체)전달
		
		//게시글 작성
		int insertBoard(Review r);
		//게시글 상세 조회
		Review selectBoard(int boardNo);
		//게시글 조회수 증가
		int increaseCount(int boardNo);
		//게시글 수정 
		int updateBoard(Review rv);
		//게시글 삭제
		int deleteBoard(int boardNo);
		
		//댓글 작성
		int insertReply(Reply reply);
		
		//댓글 목록 조회
		ArrayList<Reply> replyList(int boardNo);
		
		//게시글 조회수 top5 조회
		ArrayList<Review> selectTopList();

	
	
	

}
