package com.kh.springProject.review.model.service;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.map.model.vo.Map;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.dao.ReviewDao;
import com.kh.springProject.review.model.vo.ReviewLikes;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private ReviewDao reviewDao;


	@Override
	public int reviewLikes(int boardNo) {
		// TODO Auto-generated method stub
		return reviewDao.reviewLikes(sqlSession,boardNo);
	}


	
	
	

}
