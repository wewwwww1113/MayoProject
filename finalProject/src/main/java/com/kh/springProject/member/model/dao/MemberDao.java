package com.kh.springProject.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.springProject.member.model.vo.Member;


//Repository 저장소
//주로 DB(저장소) 와 관련된 작업을 수행하는 역할로 사용(DAO)
@Repository
public class MemberDao {

	//로그인 메소드
	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		
		Member loginMember = sqlSession.selectOne("memberMapper.loginMember",m);
		
		return loginMember;
	}
	
	//회원가입 메소드
	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.insert("memberMapper.insertMember",m);
	}
	
	//정보수정 메소드
	public int updateMember(SqlSessionTemplate sqlSession, Member m) {
		
		return sqlSession.update("memberMapper.updateMember", m);
	}

}
