package com.kh.springProject.review.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.regexp.recompile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.service.ReviewReplyService;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewReplyVO;
import com.kh.springProject.review.model.vo.ReviewScrap;

import lombok.extern.slf4j.Slf4j;

@RequestMapping("/v1/review/reply")
@Controller
@Slf4j
public class ReviewReplyController  {
	@Autowired
	private ReviewReplyService reviewReplyService;
	

	 @PostMapping
	    @ResponseBody
	    public ResponseEntity<?> postReview(@RequestBody ReviewReplyVO reviewReplyVO, HttpSession session) {
	        Member member = (Member) session.getAttribute("loginUser");
	        if (member != null) {
	            reviewReplyVO.setUserKey(Integer.parseInt(member.getMemberNo()));
	            reviewReplyService.postReview(reviewReplyVO);
	            return ResponseEntity.ok("success");
	        } else {
	            return ResponseEntity.status(401).body("Unauthorized");
	        }
	    }

	
	
	//댓글 등록
	@GetMapping
	@ResponseBody
	public ResponseEntity<?> getReview(@RequestParam("toiletNo") int toiletNo){
		
		List<ReviewReplyVO> reviews=reviewReplyService.getReview(toiletNo);
		
		
		return ResponseEntity.ok(reviews);
	}
	
//	@PostMapping("/like")
//	@ResponseBody
//	public ResponseEntity<?> postLikeReview(@RequestBody ReviewReplyLikeVO reviewReplyLikeVO) {
//	    int userKey = reviewReplyLikeVO.getUserKey();
//	    int toiletKey = reviewReplyLikeVO.getToiletKey();
//	    int toiletLikeKey = reviewReplyLikeVO.getToiletLikeKey(); // 좋아요 누적 버튼 수
//
//	    // 여기서 toiletLikeKey 값을 기준으로 좋아요 누적 처리를 할 수 있음
//	    reviewReplyService.postLikeReview(userKey, toiletKey, toiletLikeKey);
//
//	    System.out.println("UserKey: " + userKey + ", ToiletKey: " + toiletKey + ", ToiletLikeKey: " + toiletLikeKey);
//	    
//	    return ResponseEntity.ok("success");
//	}
	

	
	
	
//	//좋아요 수 전체 조회
//	@GetMapping("/like")
//	@ResponseBody
//	public ResponseEntity<?> gettLikeReview( ){
//		List<ReviewReplyLikeVO> map =reviewReplyService.gettLikeReview(1);
//		System.out.println(map.toString());
//		return ResponseEntity.ok(map);
//	}
	
	
	
	//수정수정
	

    @GetMapping("/myReviews.re")
    public String myReviews(
                            @RequestParam(value = "searchType", required = false) String searchType,
                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                            Model model, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login.me";
        }

        int userKey = Integer.parseInt(loginUser.getMemberNo());
        java.util.Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("userKey", userKey);
        if ("toiletName".equals(searchType)) {
            searchParams.put("toiletName", searchKeyword);
        } else if ("reviewContent".equals(searchType)) {
            searchParams.put("reviewContent", searchKeyword);
        }

        List<ReviewReplyVO> allReviews = reviewReplyService.searchReviewsByUserKey1(searchParams);

        

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchKeyword", searchKeyword);

    
        return "review/reviewTest";
    }
	
    

    @GetMapping("/scrap")
    public String getScrapList(HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("loginUser");
        if (member == null) {
            return "redirect:/login.me";
        }
        int memberNo = Integer.parseInt(member.getMemberNo());
        List<ReviewScrap> scrapList = reviewReplyService.getScrapListByMemberNo(memberNo);
        model.addAttribute("scrapList", scrapList);
        session.setAttribute("scrapList", scrapList); // 세션에 추가
        log.info("Scrap List: " + scrapList); // 로그 추가
        return "member/scrap"; // JSP 파일 경로
    }

    // 즐겨찾기 삭제
    @PostMapping("/deleteScrap")
    public String deleteScrap(@RequestParam("scrapNo") int scrapNo) {
        reviewReplyService.deleteScrap(scrapNo);
        return "redirect:/v1/review/reply/scrap";
    }
}
