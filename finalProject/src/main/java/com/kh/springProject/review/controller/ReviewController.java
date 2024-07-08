package com.kh.springProject.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.common.template.Pagination;
import com.kh.springProject.map.model.service.MapService;
import com.kh.springProject.map.model.vo.Map;
import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.service.ReviewService;
import com.kh.springProject.review.model.vo.Reply;
import com.kh.springProject.review.model.vo.Review;
import com.kh.springProject.review.model.vo.ReviewReplyLikeVO;
import com.kh.springProject.review.model.vo.ReviewReplyVO;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MapService mapService;
	
	
//	@GetMapping("test.re")
//    public String findIdPwd() {
//        return "review/reviewTest";
//    }
	
	// ★★★★★★★★★★★★★★문제 해결해야 함★★★★★★★★★★★★★★★★★
	// loginUser가 null 값으로 처리되고 있는 상황
//	@RequestMapping(value = "test.re", method = RequestMethod.GET)
//    public String loginMember(Member m, Model model) {
//
//		Member loginUser = memberService.loginMember(m);
//        
//		model.addAttribute("loginUser", loginUser);
//		
//		log.debug("Login user: {}", loginUser);
//		
//        System.out.println(loginUser);
//
//      
//        return "review/reviewTest";
//    }
	// ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
	
	
	
	
	@RequestMapping(value = "test.re", method = RequestMethod.GET)

    public ModelAndView getAllToilets(Map m, ModelAndView mv) {
    	List<Map> t = mapService.getAllToilets(m);
    	
    	
    	mv.setViewName("review/reviewTest");
    	
    	mv.addObject("t", t);
    	
        return mv;
    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	//목록 페이지 이동
	@RequestMapping("list.re")
	public String boardList(@RequestParam(value="currentPage",defaultValue="1")int currentPage
			   ,Model model) {

		
		int listCount = reviewService.listCount();
		int pageLimit = 10;
		int boardLimit = 5;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		
		//게시글 목록 조회하기
		ArrayList<Review> list = reviewService.selectList(pi);
		
		model.addAttribute("pi",pi);
		model.addAttribute("list",list);
		
		
		return "review/reviewListView";
	}
	
	//게시글 상세보기
	@RequestMapping("detail.re")
	public ModelAndView selectBoard(int reviewNo
			,ModelAndView mv) {
		
		//조회수 증가
		int result = reviewService.increaseCount(reviewNo);
		
		//조회수 증가가 제대로 이루어졌다면 상세조회 
				if(result>0) {
					Review r = reviewService.selectReview(reviewNo);
					
					mv.addObject("r",r).setViewName("review/reviewDetailView");
					
					
				}else {
					//조회수 증가가 제대로 이루어지지 않았다면 에러메세지 
					mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
				}


		return mv;
		
		
	}

	
	
	
	//게시글 작성 페이지 이동
	@GetMapping("insert.re")
	public String reviewEnrollForm() {
		
		return "review/reviewEnrollForm";
	}

	
	
	
	
	
	
	//게시글 등록 메소드
		@PostMapping("insert.re")
		public String insertReview(Review r
								 ,MultipartFile upfile
								 ,HttpSession session) {
			
			if(!upfile.getOriginalFilename().equals("")) {

				
				//만들어놓은 파일업로드 메소드 사용하기 
				String changeName = saveFile(upfile,session);
				
				//Review에 변경된 파일명과 원본 파일명 담아주기
				r.setOriginName(upfile.getOriginalFilename());
				r.setChangeName("resources/uploadFiles/"+changeName);

			}
			
			int result = reviewService.insertReview(r);
			
			if(result>0) {//게시글 작성 성공
				session.setAttribute("alertMsg", "게시글 작성 성공!");
			}else { //게시글 작성 실패
				session.setAttribute("alertMsg", "게시글 작성 실패!");
			}
			
			return "redirect:/list.re";
		}


		
		
		//게시글 수정페이지 이동 메소드
		@GetMapping("update.re")
		public String reviewUpdateForm(int reviewNo
																		,Model model) {
			
			Review r = reviewService.selectReview(reviewNo);

			model.addAttribute("r",r);

			return "review/reviewUpdateForm";
			
		}

		
		//게시글 수정처리 메소드
		@PostMapping("update.re")
		public String updateReview(Review r
								 ,MultipartFile reupfile
								 ,HttpSession session) {
			
			boolean flag = false; //파일 삭제 필요시 사용할 논리값
			String deleteFile = "";//파일 저장경로 및 변경파일명 담아놓을 변수
			
			//새로운 첨부파일이 넘어온 경우(파일명이 넘어왔을때) 
			if(!reupfile.getOriginalFilename().equals("")) {
				//새로운 첨부파일이 있는경우 기존 첨부파일을 찾아서 삭제하는 작업을 해야함
				if(r.getOriginName()!=null) {
					flag = true;
					deleteFile = r.getChangeName();
				}
				//새로운 첨부파일 정보 데이터베이스에 등록,서버에 업로드 
				String changeName = saveFile(reupfile,session);
				
				//처리된 변경이름과 원본명을 board에 담아주기
				r.setOriginName(reupfile.getOriginalFilename());
				r.setChangeName("resources/uploadFiles/"+changeName);
			}
			/*
			 * 게시글정보인 b 에는 boardNo,boardTitle,boardContent가 들어있다 
			 * 
			 * 추가적으로 고려해야하는 경우는
			 * 1.새로 첨부된 파일이 없고 기존 파일도 없을때
			 * 2.새로 첨부된 파일이 없고 기존 파일은 있을때
			 * 3.새로 첨부된 파일이 있고 기존 파일은 없을때 - 새로 전달된 파일을 서버에 저장하고 데이터베이스에도 등록
			 * 4.새로 첨부된 파일이 있고 기존 파일도 있을때 - 기존파일은 삭제 / 새로 첨부된 파일을 저장 및 등록하기 
			 * */
			int result = reviewService.updateReview(r);
			
//			System.out.println(result);
			
			String msg = "";
			
			if(result>0) { //수정 성공시
				msg = "게시글 수정 성공!";
				if(flag) {
					//File(실제 파일 저장 경로)
					File f = new File(session.getServletContext().getRealPath(deleteFile));
					f.delete(); //삭제
				}
			}else {//수정 실패 
				msg = "게시글 수정 실패!";
			}
			session.setAttribute("alertMsg", msg);
			//수정된 게시글 상세보기 페이지로 이동 
			return "redirect:/detail.re?reviewNo="+r.getReviewNo();
			
		}

		
		//게시글 삭제 메소드
		@PostMapping("delete.re")
		public ModelAndView deleteReview(int reviewNo
								 ,String filePath
								 ,HttpSession session
								 ,ModelAndView mv) {
			
			//dml 
			int result = reviewService.deleteReview(reviewNo);
			
			if(result>0) { //성공시 
				//넘어온 파일 정보가 있다면 해당 파일 서버에서 삭제처리하기 
				if(!filePath.equals("")) {//넘어온 파일정보가 빈문자열이 아닐때(즉,있을때)
					new File(session.getServletContext().getRealPath(filePath)).delete();
				}
				
				session.setAttribute("alertMsg", "게시글 삭제 성공");
				mv.setViewName("redirect:/list.re");
			}else {
				session.setAttribute("alertMsg", "게시글 삭제 실패");
				mv.setViewName("redirect:/detail.re?reviewNo="+reviewNo);
			}
			
			return mv;
		}
		
		
		//파일 업로드 처리 메소드(재활용)
		public String saveFile(MultipartFile upfile
							  ,HttpSession session) {
			
			//파일명 수정작업하기 
			//1.원본파일명 추출
			String originName = upfile.getOriginalFilename();
			
			//2.시간형식 문자열로 만들기 
			//20240527162730
			String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			//3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기 
			String ext = originName.substring(originName.lastIndexOf("."));
			
			//4.랜덤값 5자리 뽑기 
			int ranNum = (int)(Math.random()*90000+10000);
			
			//5.하나로 합쳐주기 
			String changeName = currentTime+ranNum+ext;
			
			//6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
			String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
			
			try {
				//7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
				upfile.transferTo(new File(savePath+changeName));
				
				
			} catch (IllegalStateException | IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		
			
			return changeName;
			
			
		}

			
		
		//댓글 목록 조회
		@ResponseBody
		@RequestMapping(value="replyList.re",produces="application/json;charset=UTF-8")
		public ArrayList<Reply> replyList(int reviewNo) {
			
			ArrayList<Reply> rList = reviewService.replyList(reviewNo);
			
			return rList;
		}
		
		

		//댓글작성
		@ResponseBody
		@RequestMapping("insertReply.re")
		public int insertReply(Reply r) {
			
			System.out.println(r);
			
			int result = reviewService.insertReply(r);
			
			return result;
		}

		
		
		@PostMapping("/like")
		public String postLike(Model model, HttpServletRequest request) {
		    // HttpServletRequest를 통해 파라미터 추출
		    int toiletKey = Integer.parseInt(request.getParameter("toiletKey"));
		    int userKey = Integer.parseInt(request.getParameter("userKey"));
		    int toiletLikeKey = Integer.parseInt(request.getParameter("toiletLikeKey"));

		    ReviewReplyLikeVO like = new ReviewReplyLikeVO();
		    like.setToiletKey(toiletKey);
		    like.setUserKey(userKey);
		    like.setToiletLikeKey(toiletLikeKey);

		    
		    
		    int result = reviewService.postLikeReview(like);
		    model.addAttribute("result", result);
		    
		    System.out.println("누적 좋아요 횟수 : " + result);
		    
		    int person = reviewService.personLike(like);
		   
		    model.addAttribute("person",person);
		    
		    System.out.println("유저가 누른 개인 좋아요 횟수  :" +person);
		    
		    
		    
		    
		    
		    return "review/reviewTest";
		}
		
		
		
		
		//---------------------------------------------------------------------------
		
		// 스크랩
		@PostMapping(value="/scrap")
		@ResponseBody
		public HashMap<String, Object> scrap(@RequestBody HashMap<String, Object> paramMap, HttpSession session) throws Exception{
			Member member	= (Member) session.getAttribute("loginUser");
			HashMap<String, Object> map = new HashMap<>();
			String memberNo = member.getMemberNo();
			int toiletNo	= Integer.parseInt(paramMap.get("toiletNo").toString());
			int count		= reviewService.scrapCheck(memberNo, toiletNo);
			if (count == 0) {
				reviewService.scrap(memberNo, toiletNo);
				map.put("msg", "스크랩 완료");
				map.put("cnt", 1);
			}else {
				reviewService.scrapCancel(memberNo, toiletNo);
				map.put("msg", "스크랩 취소");
				map.put("cnt", 0);
			}

			return map;
		}
		
		// 평점 Update
		@PostMapping(value="/updateStar")
		@ResponseBody
		public HashMap<String, Object> updateStar(@RequestBody HashMap<String, Object> paramMap, HttpSession session) throws Exception{
			Member member	= (Member) session.getAttribute("loginUser");
			HashMap<String, Object> map = new HashMap<>();
			String memberNo = member.getMemberNo();
			int toiletNo	= Integer.parseInt(paramMap.get("toiletNo").toString());
			int starCnt		= Integer.parseInt(paramMap.get("starCnt").toString());
			reviewService.updateStar(memberNo, toiletNo, starCnt);			
			map.put("msg", "평점이 수정되었습니다.");

			return map;
		}
		
		
		
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
}
