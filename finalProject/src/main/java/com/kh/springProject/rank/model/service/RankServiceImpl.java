package com.kh.springProject.rank.model.service;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.rank.model.dao.RankDao;
import com.kh.springProject.rank.model.vo.Rank;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewStar;

@Service
public class RankServiceImpl implements RankService{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Autowired
	private RankDao rankDao;
	

	@Override
	public List<ReviewStar> getAllStars(ReviewStar rs) {
		// TODO Auto-generated method stub
		return rankDao.selectAllStars(sqlSession,rs);
	}

	@Override
	public ArrayList<Rank> avgStar() {
		// TODO Auto-generated method stub
		return rankDao.selectAvgStar(sqlSession);
	}


}
