package com.kh.springProject.review.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewReplyVO;

@Repository
public class ReviewReplyDao {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

//＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠
	
	//댓글 작성
	public void postReview( ReviewReplyVO reviewReplyVO) {
	
		Map<String,Object> map = new HashMap();
		map.put("memberNo", reviewReplyVO.getUserKey());
		map.put("content", reviewReplyVO.getContent());
		map.put("toiletNo", reviewReplyVO.getToiletNo());
		
		sqlSessionTemplate.insert("reviewMapper.test", map);
	}
	
//＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠＠
	
	//댓글 조회
	public List<ReviewReplyVO> getReview(int toiletNo) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("reviewMapper.test2", toiletNo);
	}

//	//좋아요 눌렀을 때
//	public void postLikeReview(int userKey, int toiletKey, int toiletLikeKey) {
//        Map<String, Object> map = new HashMap<>();
//        map.put("memberNo", userKey);
//        map.put("toiletNo", toiletKey);
//        map.put("toiletLikeKey", toiletLikeKey);
//
//        sqlSessionTemplate.insert("toiletLikeMapper.postLikeReview", map);
//    }
	
	//좋아요 조회
	public List<ReviewReplyLikeVO> gettLikeReview(int userNo) {
		Map<String,Object> map = new HashMap();
		map.put("userNo", userNo);
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("toiletLikeMapper.getLikeReview",userNo);
	}
	
	//추가 메소드
		 public List<ReviewReplyVO> getReviewsByUserKey(int userKey) {
		        return sqlSessionTemplate.selectList("reviewMapper.getReviewsByUserKey", userKey);
		    }


		 public List<ReviewReplyVO> searchReviewsByUserKey(Map<String, Object> searchParams) {
		        return sqlSessionTemplate.selectList("reviewMapper.searchReviewsByUserKey", searchParams);
		    }
		 
		 public int deleteReviewByKey(int reviewReplyKey) {
		        return sqlSessionTemplate.delete("reviewMapper.deleteReviewByKey", reviewReplyKey);
		    }
		 
		 public int deleteReviewsByKey(List<Integer> reviewReplyKeys) {
		        return sqlSessionTemplate.delete("reviewMapper.deleteReviewsByKey", reviewReplyKeys);
		    }

	



	}


