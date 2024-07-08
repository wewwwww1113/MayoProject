package com.kh.springProject.member.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.vo.ReviewReplyVO;
import com.kh.springProject.review.model.vo.ReviewScrap;

@Repository
public class MemberDao {

    public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
        return sqlSession.selectOne("memberMapper.loginMember", m);
    }

    public int insertMember(SqlSessionTemplate sqlSession, Member m) {
        return sqlSession.insert("memberMapper.insertMember", m);
    }

    public int updateMember(SqlSessionTemplate sqlSession, Member m) {
        return sqlSession.update("memberMapper.updateMember", m);
    }

	public String findMemberId(SqlSessionTemplate sqlSession, Member m) {
		 return sqlSession.selectOne("memberMapper.findMemberId", m);
		
	}


	 public boolean deleteMember(SqlSessionTemplate sqlSession, String memberId) {
	        int result = sqlSession.delete("memberMapper.deleteMember", memberId);
	        return result > 0;
	    }
	 
	 
	 public Member selectMemberById(SqlSessionTemplate sqlSession, String memberId) {
		    return sqlSession.selectOne("memberMapper.selectMemberById", memberId);
		}

	public Member getMemberByUsername(SqlSessionTemplate sqlSession, String memberNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.findMemberNo",memberNo);
	}

	public int MemberId(SqlSessionTemplate sqlSession, Member mem) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("memberMapper.reviewMemberId",mem);
	}
	
	  private static final Logger logger = LoggerFactory.getLogger(MemberDao.class);

	  public int getReviewCountByUser(SqlSessionTemplate sqlSession, String memberNo) {
	        return sqlSession.selectOne("memberMapper.getReviewCountByUser", memberNo);
	    }

	    public List<ReviewReplyVO> getReviewsByUser(SqlSessionTemplate sqlSession, Map<String, Object> params) {
	        return sqlSession.selectList("memberMapper.getReviewsByUser", params);
	    }
	    

	

	    
}