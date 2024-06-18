package com.kh.springProject.member.model.service;

import com.kh.springProject.member.model.vo.Member;

public interface MemberService {

	//로그인 기능 
	Member loginMember(Member m);
	
	//회원가입 기능
	int insertMember(Member m);
	
	//정보수정 기능
	int updateMember(Member m);
	
	//아이디찾기 기능
	String findMemberId(Member m);
}
