package com.kh.springProject.member.controller;

import java.io.IOException;
import java.util.UUID;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;
import com.kh.springProject.tst.NaverLoginBO;

@Controller
public class MemberController {
    private NaverLoginBO naverLoginBO;
    private String apiResult = null;

    @Autowired
    private MemberService memberService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    @Autowired
    public MemberController(NaverLoginBO naverLoginBO) {
        this.naverLoginBO = naverLoginBO;
    }

    @RequestMapping(value = "login.me", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView login(Model model, HttpSession session, Member m, ModelAndView mv,
                              @RequestParam(value = "code", required = false) String code,
                              @RequestParam(value = "state", required = false) String state) throws IOException, ParseException {
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

            mv.setViewName("redirect:/");
        } else if (m.getMemberId() != null && m.getMemberPwd() != null) {
            // 일반 로그인 처리
            Member loginUser = memberService.loginMember(m);

            if (loginUser == null || !bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
                mv.addObject("errorMsg", "로그인 실패!!");
                mv.setViewName("common/errorPage");
            } else {
                session.setAttribute("alertMsg", "로그인 성공!!");
                session.setAttribute("loginUser", loginUser);
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
                                     @RequestParam("fullEmail") String fullEmail) {
        String encPwd = bcryptPasswordEncoder.encode(member.getMemberPwd());
        member.setMemberPwd(encPwd);
        member.setEmail(fullEmail);

        int result = memberService.insertMember(member);

        if (result > 0) {
            session.setAttribute("alertMsg", "회원가입 성공!");
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
    public String updateMember(Member m, Model model, HttpSession session) {
        int result = memberService.updateMember(m);

        if (result > 0) {
            Member updateMem = memberService.loginMember(m);
            session.setAttribute("loginUser", updateMem);
            session.setAttribute("alertMsg", "정보수정 성공!!");
            return "redirect:mypage.me";
        } else {
            model.addAttribute("errorMsg", "정보 수정 실패!");
            return "common/errorPage";
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
    public ModelAndView findId(Member member, ModelAndView mv) {
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

    @GetMapping("/myReviews.me")
    public String myReviews() {
        return "member/myReviews";
    }
}
