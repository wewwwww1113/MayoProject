package com.kh.springProject.common.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.kh.springProject.common.model.vo.GoogleInfResponse;
import com.kh.springProject.common.model.vo.GoogleResponse;
import com.kh.springProject.member.model.vo.Member;

@RestController
@CrossOrigin("*")
public class LoginController {

    private final String googleClientId = "63483462058-fju3itdbk36q6m7c4pkvv3qrqoujfngc.apps.googleusercontent.com";
    private final String googleClientSecret = "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";
    private final String googleRedirectUri = "http://localhost:8080/api/v1/oauth2/google/callback";

    @RequestMapping(value="/api/v1/oauth2/google/callback", method = RequestMethod.GET)
    public String googleCallback(@RequestParam("code") String authCode) {
        System.out.println("Received auth code: " + authCode); // 디버깅 로그 추가

        RestTemplate restTemplate = new RestTemplate();

        // URL 인코딩된 데이터 생성
        MultiValueMap<String, String> googleOAuthRequestParam = new LinkedMultiValueMap<>();
        googleOAuthRequestParam.add("client_id", googleClientId);
        googleOAuthRequestParam.add("client_secret", googleClientSecret);
        googleOAuthRequestParam.add("redirect_uri", googleRedirectUri);
        googleOAuthRequestParam.add("code", authCode);
        googleOAuthRequestParam.add("grant_type", "authorization_code");

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(googleOAuthRequestParam, headers);

        // 요청 URL 및 파라미터 디버깅 로그 추가
        System.out.println("Request URL: https://oauth2.googleapis.com/token");
        System.out.println("Request Params: " + googleOAuthRequestParam);

        ResponseEntity<GoogleResponse> resultEntity = restTemplate.exchange(
                "https://oauth2.googleapis.com/token",
                HttpMethod.POST,
                request,
                GoogleResponse.class
        );

        // 응답 디버깅 로그 추가
        System.out.println("Response Status Code: " + resultEntity.getStatusCode());
        System.out.println("Response Body: " + resultEntity.getBody());

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
                // Member 객체 생성 및 설정
                Member member = new Member();
                member.setEmail(googleInfo.getEmail());
                member.setMemberNick(googleInfo.getName());
                member.setMemberId(googleInfo.getSub());
                member.setGender(googleInfo.getGender()); // 성별 정보가 있는 경우
                member.setBirthDate(googleInfo.getBirthDate()); // 생년월일 정보가 있는 경우

                // 여기서 member 객체를 데이터베이스에 저장하는 로직 추가
                // memberService.save(member);

                return "로그인 성공: " + member.getEmail();
            }
        }

        return "Unauthorized";
    }
}
