package com.kh.springProject.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.springProject.member.model.dao.MemberDao;
import com.kh.springProject.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {

    @Autowired
    private MemberDao memberDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public Member loginMember(Member m) {
        return memberDao.loginMember(sqlSession, m);
    }

    @Override
    public int insertMember(Member m) {
        return memberDao.insertMember(sqlSession, m);
    }

    @Override
    public int updateMember(Member m) {
        return memberDao.updateMember(sqlSession, m);
    }

	@Override
	public String findMemberId(Member m) {
		return memberDao.findMemberId(sqlSession, m);
		
	}

	public boolean deleteMember(String memberId, String memberPwd) {
		
		return memberDao.deleteMember(sqlSession, memberId);
	}


	@Override
	public Member selectMemberById(String memberId) {
        return memberDao.selectMemberById(sqlSession,memberId);
    }
	
	
	@Override
	public int reviewMemberNo(Member mem) {
		// TODO Auto-generated method stub
		return memberDao.MemberId(sqlSession, mem);
	}

	

	

	}
