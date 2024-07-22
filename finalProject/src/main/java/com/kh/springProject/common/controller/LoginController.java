package com.kh.springProject.common.controller;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.kh.springProject.common.model.vo.GoogleInfResponse;
import com.kh.springProject.common.model.vo.GoogleResponse;
import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;

@Controller
public class LoginController {

    private final String googleClientId = "63483462058-fju3itdbk36q6m7c4pkvv3qrqoujfngc.apps.googleusercontent.com";
    private final String googleClientSecret = "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";
    private final String googleRedirectUri = "http://localhost:8080/api/v1/oauth2/google/callback";

    @Autowired
    private MemberService memberService;

    @Autowired
    private BCryptPasswordEncoder bcryptPasswordEncoder;

    @RequestMapping("/api/v1/oauth2/google/callback")
    public String googleCallback(@RequestParam("code") String authCode, Model model, HttpSession session) {
        System.out.println("Received auth code: " + authCode);

        RestTemplate restTemplate = new RestTemplate();

        MultiValueMap<String, String> googleOAuthRequestParam = new LinkedMultiValueMap<>();
        googleOAuthRequestParam.add("client_id", googleClientId);
        googleOAuthRequestParam.add("client_secret", googleClientSecret);
        googleOAuthRequestParam.add("redirect_uri", googleRedirectUri);
        googleOAuthRequestParam.add("code", authCode);
        googleOAuthRequestParam.add("grant_type", "authorization_code");

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(googleOAuthRequestParam, headers);

        ResponseEntity<GoogleResponse> resultEntity = restTemplate.exchange(
                "https://oauth2.googleapis.com/token",
                HttpMethod.POST,
                request,
                GoogleResponse.class
        );

        if (resultEntity.getStatusCode().is2xxSuccessful()) {
            String jwtToken = resultEntity.getBody().getIdToken();

            HttpHeaders infoHeaders = new HttpHeaders();
            infoHeaders.set("Authorization", "Bearer " + jwtToken);

            HttpEntity<Map<String, String>> tokenInfoRequest = new HttpEntity<>(infoHeaders);
            ResponseEntity<GoogleInfResponse> resultEntity2 = restTemplate.exchange(
                    "https://www.googleapis.com/oauth2/v3/userinfo",
                    HttpMethod.GET,
                    tokenInfoRequest,
                    GoogleInfResponse.class
            );

            if (resultEntity2.getStatusCode().is2xxSuccessful()) {
                GoogleInfResponse googleInfo = resultEntity2.getBody();
                Member member = new Member();
                member.setEmail(googleInfo.getEmail());
                member.setMemberNick(googleInfo.getName());
                member.setMemberId(googleInfo.getSub());
                member.setGender(googleInfo.getGender());
                member.setBirthDate(googleInfo.getBirthDate());

                Member existingMember = memberService.selectMemberById(member.getMemberId());
                if (existingMember == null) {
                    // 새로운 사용자 등록
                    member.setMemberPwd(bcryptPasswordEncoder.encode(UUID.randomUUID().toString()));
                    memberService.insertMember(member);
                    session.setAttribute("loginUser", member);
                } else {
                    // 기존 사용자 로그인 처리
                    session.setAttribute("loginUser", existingMember);
                }

                return "redirect:/";
            }
        }

        return "redirect:/loginFailed";
    }
}
