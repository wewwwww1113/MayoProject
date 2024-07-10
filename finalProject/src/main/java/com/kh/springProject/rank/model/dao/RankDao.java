package com.kh.springProject.rank.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.rank.model.vo.Rank;
import com.kh.springProject.review.model.vo.ReviewStar;

@Repository
public class RankDao {

	public List<ReviewStar> selectAllStars(SqlSessionTemplate sqlSession, ReviewStar rs) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("rankMapper.selectAllStars", rs);
	}
	//평균 별점
	public ArrayList<Rank> selectAvgStar(SqlSessionTemplate sqlSession) {
		// TODO Auto-generated method stub
		return (ArrayList)sqlSession.selectList("rankMapper.avgStar") ;
	}

}
