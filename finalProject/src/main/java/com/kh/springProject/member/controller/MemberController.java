package com.kh.springProject.member.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.springProject.common.model.vo.PageInfo;
import com.kh.springProject.common.template.Pagination;
import com.kh.springProject.freeBoard.model.service.FreeBoardService;
import com.kh.springProject.freeBoard.model.vo.freeBoard;
import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.review.model.service.ReviewReplyService;
import com.kh.springProject.review.model.service.ReviewService;
import com.kh.springProject.review.model.vo.ReviewReplyVO;
import com.kh.springProject.review.model.vo.ReviewScrap;
import com.kh.springProject.tst.NaverLoginBO;

@Controller
public class MemberController {
	
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private ReviewService reviewService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;
    
    
    @Autowired
    private ReviewReplyService reviewReplyService;
    
    @Autowired
    private FreeBoardService freeBoardService;
    

    

    @Autowired
    public MemberController(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    @RequestMapping(value = "login.me", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView login(Model model, HttpSession session, Member m, ModelAndView mv,
                              @RequestParam(value = "code", required = false) String code,
                              @RequestParam(value = "state", required = false) String state, RedirectAttributes redirectAttributes) throws IOException, ParseException {
        if (code != null && state != null) {
            // 네이버 로그인 콜백 처리
            OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
            apiResult = naverLoginBO.getUserProfile(oauthToken);

            JSONParser parser = new JSONParser();
            Object obj = parser.parse(apiResult);
            JSONObject jsonObj = (JSONObject) obj;
            JSONObject responseObj = (JSONObject) jsonObj.get("response");
            String id = (String) responseObj.get("id");
            String nickname = (String) responseObj.get("nickname");
            String email = (String) responseObj.get("email");
            String gender = (String) responseObj.get("gender"); // 성별 추가

            Member naverMember = memberService.selectMemberById(id);
            if (naverMember == null) {
                // 네이버 회원 정보를 이용해 새로운 회원 가입 처리
                Member newMember = new Member();
                newMember.setMemberId(id);
                newMember.setMemberNick(nickname);
                newMember.setEmail(email);
                newMember.setGender(gender); // 성별 설정 추가
                newMember.setMemberPwd(bcryptPasswordEncoder.encode(UUID.randomUUID().toString()));

                memberService.insertMember(newMember);
                session.setAttribute("loginUser", newMember);
            } else {
                session.setAttribute("loginUser", naverMember);
            }

            redirectAttributes.addFlashAttribute("alertMsg", "로그인 성공!!");
            mv.setViewName("redirect:/");
        } else if (m.getMemberId() != null && m.getMemberPwd() != null) {
            // 일반 로그인 처리
            Member loginUser = memberService.loginMember(m);

            if (loginUser == null || !bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
                mv.addObject("errorMsg", "로그인 실패!!");
                mv.setViewName("common/errorPage");
            } else {
                session.setAttribute("loginUser", loginUser);
                redirectAttributes.addFlashAttribute("alertMsg", "로그인 성공!!");
                mv.setViewName("redirect:/");
            }
        } else {
            // 로그인 폼으로 이동
            String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
            model.addAttribute("url", naverAuthUrl);
            mv.setViewName("member/loginForm");
        }
        return mv;
    }

    @RequestMapping("logout.me")
    public String logoutMember(HttpSession session) {
        session.removeAttribute("loginUser");
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("insert.me")
    public String memberEnrollForm() {
        return "member/memberEnrollForm";
    }

    @PostMapping("insert.me")
    public ModelAndView insertMember(Member member, HttpSession session, ModelAndView mv,
                                     @RequestParam("fullEmail") String fullEmail, RedirectAttributes redirectAttributes) {
        String encPwd = bcryptPasswordEncoder.encode(member.getMemberPwd());
        member.setMemberPwd(encPwd);
        member.setEmail(fullEmail);

        int result = memberService.insertMember(member);

        if (result > 0) {
            session.setAttribute("loginUser", member);
            redirectAttributes.addFlashAttribute("alertMsg", "회원가입 성공!");
            mv.setViewName("redirect:/");
        } else {
            mv.addObject("errorMsg", "회원가입 실패");
            mv.setViewName("common/errorPage");
        }
        return mv;
    }

    @RequestMapping("mypage.me")
    public String myPage() {
        return "member/myPage";
    }

    @PostMapping("update.me")
    public String updateMember(Member m, @RequestParam("currentPwd") String currentPwd, @RequestParam(value = "newPwd", required = false) String newPwd, @RequestParam("email") String email, @RequestParam("email-domain") String emailDomain, Model model, HttpSession session, RedirectAttributes redirectAttributes) {
        Member loginUser = (Member) session.getAttribute("loginUser");

        // 이메일 결합
        m.setEmail(email + "@" + emailDomain);

        // 현재 비밀번호 확인
        if (!currentPwd.isEmpty() && !bcryptPasswordEncoder.matches(currentPwd, loginUser.getMemberPwd())) {
            redirectAttributes.addFlashAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
            return "redirect:update.me"; // 정보 수정 페이지로 다시 돌아감
        }

        // 새 비밀번호가 입력되었으면 새 비밀번호 설정
        if (newPwd != null && !newPwd.isEmpty()) {
            String encPwd = bcryptPasswordEncoder.encode(newPwd);
            m.setMemberPwd(encPwd);
        } else {
            // 비밀번호를 변경하지 않을 경우 기존 비밀번호 유지
            m.setMemberPwd(loginUser.getMemberPwd());
        }

        // 로그인 상태를 유지하기 위해 나머지 속성도 업데이트
        m.setMemberId(loginUser.getMemberId());
        m.setStatus(loginUser.getStatus());
        m.setIsAdmin(loginUser.getIsAdmin());

        int result = memberService.updateMember(m);

        if (result > 0) {
            // 업데이트 후 세션에 새로운 사용자 정보 저장
            Member updateMem = memberService.loginMember(m);
            session.setAttribute("loginUser", updateMem);
            redirectAttributes.addFlashAttribute("alertMsg", "정보수정 성공!!");
            return "redirect:update.me"; // 정보 수정 페이지로 다시 돌아감
        } else {
            redirectAttributes.addFlashAttribute("errorMsg", "정보 수정 실패!");
            return "redirect:update.me";
        }
    }


    @GetMapping("update.me")
    public String updateMemberForm() {
        return "member/update"; // 수정 페이지로 이동
    }

    @GetMapping("enrollCheckForm")
    public String enrollCheckForm() {
        return "member/enrollCheckForm";
    }

    @GetMapping("findIdPwd.me")
    public String findIdPwd() {
        return "member/findIdPwd";
    }

    @PostMapping("findId.me")
    public ModelAndView findId(@RequestParam("memberNick") String memberNick, @RequestParam("email") String email, @RequestParam("email-domain") String emailDomain, ModelAndView mv) {
        // 이메일 결합
        String fullEmail = email + "@" + emailDomain;

        // Member 객체에 필요한 정보를 설정
        Member member = new Member();
        member.setMemberNick(memberNick);
        member.setEmail(fullEmail);

        // DB에서 회원 아이디 찾기
        String foundId = memberService.findMemberId(member);

        if (foundId != null) {
            mv.addObject("foundId", foundId);
            mv.setViewName("member/showId");
        } else {
            mv.addObject("errorMsg", "아이디를 찾을 수 없습니다.");
            mv.setViewName("common/errorPage");
        }
        return mv;
    }

    @GetMapping("deleteMember.me")
    public String deleteMember() {
        return "member/deleteMember";
    }

    @PostMapping("deleteAccount.me")
    public String deleteAccount(Member member, HttpSession session, Model model) {
        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/loginForm.me";
        }

        if (!bcryptPasswordEncoder.matches(member.getMemberPwd(), loginUser.getMemberPwd())) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "member/deleteMember";
        }

        boolean isDeleted = memberService.deleteMember(loginUser.getMemberId(), member.getMemberPwd());

        if (isDeleted) {
            session.invalidate();
            return "redirect:/";
        } else {
            model.addAttribute("error", "탈퇴에 실패했습니다.");
            return "member/deleteMember";
        }
    }

    // 네이버 콜백 처리
    @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
        OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
        apiResult = naverLoginBO.getUserProfile(oauthToken);

        JSONParser parser = new JSONParser();
        Object obj = parser.parse(apiResult);
        JSONObject jsonObj = (JSONObject) obj;
        JSONObject responseObj = (JSONObject) jsonObj.get("response");
        String id = (String) responseObj.get("id");
        String nickname = (String) responseObj.get("nickname");
        String email = (String) responseObj.get("email");
        String gender = (String) responseObj.get("gender"); // 성별 추가

        Member naverMember = memberService.selectMemberById(id);
        if (naverMember == null) {
            // 네이버 회원 정보를 이용해 새로운 회원 가입 처리
            Member newMember = new Member();
            newMember.setMemberId(id);
            newMember.setMemberNick(nickname);
            newMember.setEmail(email);
            newMember.setGender(gender); // 성별 설정 추가
            newMember.setMemberPwd(bcryptPasswordEncoder.encode(UUID.randomUUID().toString()));

            memberService.insertMember(newMember);
            session.setAttribute("loginUser", newMember);
        } else {
            session.setAttribute("loginUser", naverMember);
        }

        return "redirect:/";
    }

    @GetMapping("loginForm.me")
    public String loginForm() {
        return "member/loginForm";
    }
    
    private static final Logger logger = LoggerFactory.getLogger(MemberController.class);


    @GetMapping("/myReviews.me")
    public String myReviews(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                            @RequestParam(value = "searchType", required = false) String searchType,
                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                            Model model, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login.me";
        }

        int userKey = Integer.parseInt(loginUser.getMemberNo());
        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("userKey", userKey);
        if ("toiletName".equals(searchType)) {
            searchParams.put("toiletName", searchKeyword);
        } else if ("reviewContent".equals(searchType)) {
            searchParams.put("reviewContent", searchKeyword);
        }

        List<ReviewReplyVO> allReviews = reviewReplyService.searchReviewsByUserKey(searchParams);

        int listCount = allReviews.size();
        int pageLimit = 10;
        int boardLimit = 10;

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int endRow = startRow + pi.getBoardLimit();
        endRow = endRow > listCount ? listCount : endRow;

        List<ReviewReplyVO> reviewList = allReviews.subList(startRow, endRow);

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("pi", pi);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchKeyword", searchKeyword);

        return "member/myReviews";
    }

    @PostMapping("/deleteReview.me")
    public String deleteReview(@RequestParam("selectedReviews") List<Integer> reviewReplyKeys, HttpSession session, Model model) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login.me";
        }

        int result = reviewReplyService.deleteReviewsByKey(reviewReplyKeys);

        if (result > 0) {
            session.setAttribute("alertMsg", "선택한 리뷰가 삭제되었습니다.");
        } else {
            session.setAttribute("alertMsg", "리뷰 삭제에 실패했습니다.");
        }

        return "redirect:/myReviews.me";
    }

    @GetMapping("/review/reviewTest")
    public String reviewTest(@RequestParam("toiletNo") int toiletNo, Model model) {
        // 해당 toiletNo에 대한 필요한 데이터를 가져와서 모델에 추가하는 로직
        model.addAttribute("toiletNo", toiletNo);
    
        return "review/reviewTest";
    }
    @GetMapping("statistics.me")
    public String statistics(Model model, HttpSession session, @RequestParam(defaultValue = "1") int currentPage) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/loginForm.me";
        }

        List<ReviewReplyVO> reviewList = reviewReplyService.getReviewsByUserKey(Integer.parseInt(loginUser.getMemberNo()));
        int listCount = reviewList.size();
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 10);

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("reviewList", reviewList);
        model.addAttribute("pi", pi);

        return "member/statistics";
    }
    
    @GetMapping("scrap.me")
    public String scrap() {
        return "member/scrap";
    }
    
    @GetMapping("/myPosts.me")
    public String myPosts(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
                          @RequestParam(value = "searchType", required = false) String searchType,
                          @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                          Model model, HttpSession session) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login.me";
        }

        String userKey = loginUser.getMemberId(); // 수정: MemberId는 문자열
        Map<String, Object> searchParams = new HashMap<>();
        searchParams.put("userKey", userKey);
        if ("boardTitle".equals(searchType)) {
            searchParams.put("boardTitle", searchKeyword);
        } else if ("boardContent".equals(searchType)) {
            searchParams.put("boardContent", searchKeyword);
        }

        List<freeBoard> allPosts = freeBoardService.searchPostsByUserKey(searchParams);

        int listCount = allPosts.size();
        int pageLimit = 10;
        int boardLimit = 10;

        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);

        int startRow = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int endRow = startRow + pi.getBoardLimit();
        endRow = endRow > listCount ? listCount : endRow;

        List<freeBoard> postList = allPosts.subList(startRow, endRow);

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("postList", postList);
        model.addAttribute("pi", pi);
        model.addAttribute("searchType", searchType);
        model.addAttribute("searchKeyword", searchKeyword);

        return "member/myWrite";
    }
    
    @PostMapping("/deletePost.me")
    public String deletePost(@RequestParam("selectedPosts") List<Integer> postKeys, HttpSession session, RedirectAttributes redirectAttributes) {
        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login.me";
        }

        int result = freeBoardService.deletePostsByKey(postKeys);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("alertMsg", "선택한 글이 삭제되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("alertMsg", "글 삭제에 실패했습니다.");
        }

        return "redirect:/myPosts.me";
    }
    
    @GetMapping("/boardDetailView")
    public String boardDetailView(@RequestParam("boardNo") int boardNo, Model model) {
        freeBoard board = freeBoardService.selectBoard(boardNo);
        model.addAttribute("b", board);
        return "freeBoard/boardDetailView";
    }
}