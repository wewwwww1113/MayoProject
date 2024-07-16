package com.kh.springProject.member.model.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.vo.ReviewReplyVO;
import com.kh.springProject.review.model.vo.ReviewScrap;

public interface MemberService {

	//로그인 기능 
	Member loginMember(Member m);
	
	//회원가입 기능
	int insertMember(Member m);
	
	//정보수정 기능
	int updateMember(Member m);
	
	//아이디찾기 기능
	String findMemberId(Member m);

	//회원 탈퇴 기능
	boolean deleteMember(String memberId, String memberPwd);

	//리뷰 - 멤버 아이디
	int reviewMemberNo(Member mem);

	//소셜 로그인 기능
	Member selectMemberById(String memberId);
	
	 // 내가 쓴 리뷰 관리 기능
    int getReviewCountByUser(String memberNo);
     
    // 내가 쓴 리뷰 관리 기능
    List<ReviewReplyVO> getReviewsByUser(String memberNo, PageInfo pi);
	

}
