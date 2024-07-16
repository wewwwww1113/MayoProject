package com.kh.springProject.freeBoard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.common.template.Pagination;
import com.kh.springProject.freeBoard.model.service.FreeBoardService;
import com.kh.springProject.freeBoard.model.vo.fbReply;
import com.kh.springProject.freeBoard.model.vo.freeBoard;
import com.kh.springProject.freeBoard.model.vo.Category;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FreeBoardController {

	@Autowired
	private FreeBoardService fbService;
	
	 @Autowired
	 private FreeBoardService freeBoardService;

	@RequestMapping("/list.fr")
	public String boardList(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam(value = "categoryNo", defaultValue = "0") int categoryNo, Model model) {

		int listCount;
		ArrayList<freeBoard> list;
		int pageLimit = 10;
		int boardLimit = 5;

		if (categoryNo == 0) {
			listCount = fbService.listCount();
			list = fbService.selectList(Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit));
		} else {
			listCount = fbService.cListCount(categoryNo);
			list = fbService.orderByCategory(categoryNo,
					Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit));
		}

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("categoryNo", categoryNo);

		System.out.println(list);

		return "freeboard/boardListView";
	}

	// 게시글 상세보기
	@RequestMapping("detail.fr")
	public ModelAndView selectBoard(int boardNo, ModelAndView mv) {

		// 조회수증가시키기
		int result = fbService.increaseCount(boardNo);

		// 조회수 증가가 제대로 이루어졌다면 상세조회
		if (result > 0) {
			freeBoard b = fbService.selectBoard(boardNo);
//			mv.addObject("b",b);
//			mv.setViewName("board/boardDetailView");
			// 이어쓰기 (메소드체이닝) - view 정보 등록을 마지막에 해야함
			mv.addObject("b", b).setViewName("freeboard/boardDetailView");

		} else {
			// 조회수 증가가 제대로 이루어지지 않았다면 에러메세지
//			mv.addObject("errorMsg", "상세조회 실패");
//			mv.setViewName("common/errorPage");
			mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
		}

		return mv;
	}

	// 게시글 작성 페이지 이동
	@GetMapping("insert.fr")
	public String boardEnrollForm(Model model) {

		ArrayList<Category> cgList = fbService.boardInsert();
		model.addAttribute("cgList", cgList);

		// System.out.println(cgList);

		return "freeboard/boardEnrollForm";
	}

	// 게시글 등록 메소드
	@PostMapping("insert.fr")
	public String insertBoard(freeBoard b, MultipartFile upfile, HttpSession session) {

		// 전달된 파일이 있을경우 - 파일명수정작업 후 서버로 업로드, 원본명과 수정된 파일명을 DB에 등록하기
		if (!upfile.getOriginalFilename().equals("")) {

			// 만들어놓은 파일업로드 메소드 사용하기
			String changeName = saveFile(upfile, session);

			// Board에 변경된 파일명과 원본 파일명 담아주기
			b.setOriginName(upfile.getOriginalFilename());
			b.setChangeName("resources/uploadFiles/" + changeName);

		}

		int result = fbService.insertBoard(b);

		if (result > 0) {// 게시글 작성 성공
			session.setAttribute("alertMsg", "게시글 작성 성공!");
		} else { // 게시글 작성 실패
			session.setAttribute("alertMsg", "게시글 작성 실패!");
		}

		return "redirect:/list.fr";
	}

	// 게시글 수정페이지 이동 메소드
	@GetMapping("update.fr")
	public String boardUpdateForm(int boardNo, Model model) {

		// boardNo로 db에서 해당 게시글 정보 조회해오기 (기존 상세보기시 사용했던 메소드 재활용하기)
		freeBoard b = fbService.selectBoard(boardNo);

		model.addAttribute("b", b);
		// 페이지 이동할때 전달하기
		return "freeboard/boardUpdateForm";
	}

	// 게시글 수정처리 메소드
	@PostMapping("update.fr")
	public String updateBoard(freeBoard b, MultipartFile reupfile, HttpSession session) {

		boolean flag = false; // 파일 삭제 필요시 사용할 논리값
		String deleteFile = "";// 파일 저장경로 및 변경파일명 담아놓을 변수

		// 새로운 첨부파일이 넘어온 경우(파일명이 넘어왔을때)
		if (!reupfile.getOriginalFilename().equals("")) {
			// 새로운 첨부파일이 있는경우 기존 첨부파일을 찾아서 삭제하는 작업을 해야함
			if (b.getOriginName() != null) {
				flag = true;
				deleteFile = b.getChangeName();
			}
			// 새로운 첨부파일 정보 데이터베이스에 등록,서버에 업로드
			String changeName = saveFile(reupfile, session);

			// 처리된 변경이름과 원본명을 board에 담아주기
			b.setOriginName(reupfile.getOriginalFilename());
			b.setChangeName("resources/uploadFiles/" + changeName);
		}
		/*
		 * 게시글정보인 b 에는 boardNo,boardTitle,boardContent가 들어있다
		 * 
		 * 추가적으로 고려해야하는 경우는 1.새로 첨부된 파일이 없고 기존 파일도 없을때 2.새로 첨부된 파일이 없고 기존 파일은 있을때 3.새로
		 * 첨부된 파일이 있고 기존 파일은 없을때 - 새로 전달된 파일을 서버에 저장하고 데이터베이스에도 등록 4.새로 첨부된 파일이 있고 기존
		 * 파일도 있을때 - 기존파일은 삭제 / 새로 첨부된 파일을 저장 및 등록하기
		 */
		int result = fbService.updateBoard(b);

		String msg = "";

		if (result > 0) { // 수정 성공시
			msg = "게시글 수정 성공!";
			if (flag) {
				// File(실제 파일 저장 경로)
				File f = new File(session.getServletContext().getRealPath(deleteFile));
				f.delete(); // 삭제
			}
		} else {// 수정 실패
			msg = "게시글 수정 실패!";
		}
		session.setAttribute("alertMsg", msg);
		// 수정된 게시글 상세보기 페이지로 이동
		return "redirect:/detail.fr?boardNo=" + b.getBoardNo();

	}

	// 게시글 삭제 메소드
	@PostMapping("delete.fr")
	public ModelAndView deleteBoard(int boardNo, String filePath, HttpSession session, ModelAndView mv) {

		// dml
		int result = fbService.deleteBoard(boardNo);

		if (result > 0) { // 성공시
			// 넘어온 파일 정보가 있다면 해당 파일 서버에서 삭제처리하기
			if (!filePath.equals("")) {// 넘어온 파일정보가 빈문자열이 아닐때(즉,있을때)
				new File(session.getServletContext().getRealPath(filePath)).delete();
			}

			session.setAttribute("alertMsg", "게시글 삭제 성공");
			mv.setViewName("redirect:/list.fr");
		} else {
			session.setAttribute("alertMsg", "게시글 삭제 실패");
			mv.setViewName("redirect:/detail.fr?boardNo=" + boardNo);
		}

		return mv;
	}

	// 파일 업로드 처리 메소드(재활용)
	public String saveFile(MultipartFile upfile, HttpSession session) {

		// 파일명 수정작업하기
		// 1.원본파일명 추출
		String originName = upfile.getOriginalFilename();

		// 2.시간형식 문자열로 만들기
		// 20240527162730
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());

		// 3.확장자 추출하기 파일명 뒤에서부터 . 찾아서 뒤로 잘라내기
		String ext = originName.substring(originName.lastIndexOf("."));

		// 4.랜덤값 5자리 뽑기
		int ranNum = (int) (Math.random() * 90000 + 10000);

		// 5.하나로 합쳐주기
		String changeName = currentTime + ranNum + ext;

		// 6.업로드하고자하는 물리적인 경로 알아내기 (프로젝트 내에 저장될 실제 경로 찾기)
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");

		try {
			// 7.경로와 수정 파일명을 합쳐서 파일 업로드 처리하기
			upfile.transferTo(new File(savePath + changeName));

		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return changeName;

	}

	// 댓글 목록 조회
	@ResponseBody
	@RequestMapping(value = "replyList.fr", produces = "application/json;charset=UTF-8")
	public ArrayList<fbReply> replyList(int boardNo) {

		ArrayList<fbReply> rList = fbService.replyList(boardNo);

		return rList;
	}

	// 댓글작성
	@ResponseBody
	@RequestMapping("insertReply.fr")
	public int insertReply(fbReply r) {

		System.out.println(r);

		int result = fbService.insertReply(r);

		return result;

	}

	
	@RequestMapping("category.fr")
	public String orderByCategory( @RequestParam("categoryNo") int categoryNo,
	                              @RequestParam(value = "currentPage", defaultValue = "1") int currentPage, 
	                              Model model) {

	    // Get the total count of the list for the specified category
	    int listCount = fbService.cListCount(categoryNo);
	    int pageLimit = 10;
	    int boardLimit = 5;

	    // Create PageInfo object with pagination details
	    PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

	    // Get the list of posts for the selected category and pagination info
	    ArrayList<freeBoard> list = fbService.orderByCategory(categoryNo, pi);

	    // Debugging: Print out list and categoryNo for debugging purposes
	    System.out.println("List size: " + list.size());
	    System.out.println("CategoryNo: " + categoryNo);

	    // Save data to model if list is not null
	    if (list != null) {
	        model.addAttribute("list", list);
	    } else {
	        // Handle case where list is null (optional)
	        // model.addAttribute("list", new ArrayList<freeBoard>());
	        System.out.println("List is null or empty.");
	    }

	    model.addAttribute("pi", pi);
	    model.addAttribute("CategoryNo", categoryNo);

	    // Forward to the view
	    return "freeboard/boardListView"; 
	}
	
	
	
	
}
