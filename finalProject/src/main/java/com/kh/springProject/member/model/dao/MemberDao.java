package com.kh.springProject.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.member.model.vo.Member;

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
	    
}