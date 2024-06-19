package com.kh.springProject.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;

@Controller
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    @RequestMapping(value = "login.me", method = RequestMethod.POST)
    public ModelAndView loginMember(Member m, ModelAndView mv, HttpSession session) {
        Member loginUser = memberService.loginMember(m);

        if (loginUser == null || !bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) {
            mv.addObject("errorMsg", "로그인 실패!!");
            mv.setViewName("common/errorPage");
        } else {
            session.setAttribute("alertMsg", "로그인 성공!!");
            session.setAttribute("loginUser", loginUser);
            mv.setViewName("redirect:/");
        }
        return mv;
    }

    @RequestMapping("logout.me")
    public String logoutMember(HttpSession session) {
        session.removeAttribute("loginUser");
        return "redirect:/";
    }

    @GetMapping("insert.me")
    public String memberEnrollForm() {
        return "member/memberEnrollForm";
    }

    @PostMapping("insert.me")
    public ModelAndView insertMember(Member member, HttpSession session, ModelAndView mv) {
        String encPwd = bcryptPasswordEncoder.encode(member.getMemberPwd());
        member.setMemberPwd(encPwd);

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

    @RequestMapping("update.me")
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

    @GetMapping("loginForm.me")
    public String loginForm() {
        return "member/loginForm";
    }
    
    @GetMapping("/enrollCheckForm")
    public String enrollCheckForm() {
        return "member/enrollCheckForm";
    }
    
    @GetMapping("findIdPwd.me")
    public String findIdPwd() {
        return "member/findIdPwd";
    }
    @RequestMapping(value = "findId.me", method = RequestMethod.POST)
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
    
    @GetMapping("deleteMember")
    public String deleteMember() {
        return "member/deleteMember";
    }
    @RequestMapping(value = "/deleteAccount.me", method = RequestMethod.POST)
    public String deleteAccount(Member member, HttpSession session, Model model) {
        Member loginUser = (Member) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/loginForm.me";
        }

        // 비밀번호 확인
        if (!bcryptPasswordEncoder.matches(member.getMemberPwd(), loginUser.getMemberPwd())) {
            model.addAttribute("error", "비밀번호가 일치하지 않습니다.");
            return "member/deleteMember";
        }

        boolean isDeleted = memberService.deleteMember(loginUser.getMemberId(), member.getMemberPwd());

        if (isDeleted) {
            session.invalidate();
            return "redirect:/"; // 메인 페이지로 리다이렉트
        } else {
            model.addAttribute("error", "탈퇴에 실패했습니다.");
            return "member/deleteMember";
        }
    }
}

    

   