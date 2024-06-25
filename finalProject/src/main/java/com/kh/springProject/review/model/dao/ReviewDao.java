package com.kh.springProject.review.model.dao;



import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.vo.ReviewLikes;

@Repository
public class ReviewDao {
	
	@Autowired
    private SqlSession sqlSession;

	public int reviewLikes(SqlSessionTemplate sqlSession, int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("reviewMapper.likeUp", boardNo);
	}




	

	
	
	

}
