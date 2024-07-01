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

	public void postReview(int memberNo, ReviewReplyVO reviewReplyVO) {
	
		Map<String,Object> map = new HashMap();
		map.put("memberNo", memberNo);
		map.put("content", reviewReplyVO.getContent());
		map.put("toiletNo", reviewReplyVO.getToiletNo());
		
		sqlSessionTemplate.insert("reviewMapper.test", map);
	}

	public List<ReviewReplyVO> getReview(int toiletNo) {
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("reviewMapper.test2", toiletNo);
	}

	public void postLikeReview(int memberNo, int toiletNo) {
		Map<String,Object> map = new HashMap();
		map.put("memberNo", memberNo);
		map.put("toiletNo", toiletNo);

		// TODO Auto-generated method stub
		sqlSessionTemplate.insert("toiletLikeMapper.postLikeReview",map);
	}

	public List<ReviewReplyLikeVO> gettLikeReview(int userNo) {
		Map<String,Object> map = new HashMap();
		map.put("userNo", userNo);
		// TODO Auto-generated method stub
		return sqlSessionTemplate.selectList("toiletLikeMapper.getLikeReview",userNo);
	}

}
