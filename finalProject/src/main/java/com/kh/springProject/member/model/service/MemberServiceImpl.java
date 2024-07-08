package com.kh.springProject.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.member.model.dao.MemberDao;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.vo.ReviewReplyVO;
import com.kh.springProject.review.model.vo.ReviewScrap;


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
	
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	 @Override
	    public int getReviewCountByUser(String memberNo) {
	        return memberDao.getReviewCountByUser(sqlSession, memberNo);
	    }

	    @Override
	    public List<ReviewReplyVO> getReviewsByUser(String memberNo, PageInfo pi) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("memberNo", memberNo);
	        params.put("startRow", (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1);
	        params.put("endRow", pi.getCurrentPage() * pi.getBoardLimit());

	        return memberDao.getReviewsByUser(sqlSession, params);
	    }
	    


	

	}
