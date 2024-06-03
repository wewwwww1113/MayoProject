package com.kh.springProject.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.member.model.dao.MemberDao;
import com.kh.springProject.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	
	//private MemberDao memberDao = new MemberDao();
	
	@Autowired
	private MemberDao memberDao;
	
	//sqlSession도 선언하여 spring에서 관리할 수 있도록 처리
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//로그인 메소드
	@Override
	public Member loginMember(Member m) {

		Member loginUser = memberDao.loginMember(sqlSession,m);
		
		//SqlSessionTemplate 객체를 Bean등록후 @Autowired 해줌으로
		//스프링 컨테이너가 사용후 자동으로 객체를 반납시켜주기때문에
		//close() 메소드를 사용할 필요가 없다.
		
		return loginUser;
	}
	
	//회원가입 메소드
	@Override
	public int insertMember(Member m) {
		
		//insert (DML) 트랜잭션 처리가 필요하지만 
		//스프링에서 관리하기때문에 직접 처리하지 않는다. 
		//SqlSessionTemplate이 처리함
		
//		int result = memberDao.insertMember(sqlSession,m);
//		return result;
		
		//한줄 처리 
		return memberDao.insertMember(sqlSession,m);
	}
	
	
	//정보수정 메소드
	@Override
	public int updateMember(Member m) {
		
		return memberDao.updateMember(sqlSession,m);
	}
	
	
	
	
	
	
	
	
}
