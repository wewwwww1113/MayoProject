package com.kh.springProject.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


/*
 * Lombok(롬복)
 * -자동 코드 생성 라이브러리
 * -반복되는 getter,setter,toString 등의 메소드 작성코드를 줄여주는 라이브러리
 * 
 * 설치방법
 * 1.라이브러리 다운후 적용(maven pom.xml dependency 주입)
 * 2.라이브러리 설치된 경로 찾아가서 jar파일 실행 후 설치
 * 3.IDE 재실행
 * 
 * Lombok 사용시 주의사항 
 * uName,pName 와 같은 앞글자가 외자인 필드명은 만들지 말것.
 * 추후 el표기법을 사용하여 필드 접근시 getter메소드 호출되는데 이때 자동완성된 형태는 getuName 과 같은 형태이기때문에 오류발생
 * 
 * */
@NoArgsConstructor //기본생성자
@AllArgsConstructor //모든 필드 매개변수로 갖는 생성자
//@Setter //setter 메소드
//@Getter //getter 메소드
//@ToString //toString 메소드
//@EqualsAndHashCode // equals와 hashcode 메소드 
@Data //@Getter @Setter @RequiredArgsConstructor @ToString @EqualsAndHashCode.  가 포함된 어노테이션
public class Member {
	private String userId;	//	USER_ID	VARCHAR2(30 BYTE)
	private String userPwd;//	USER_PWD	VARCHAR2(100 BYTE)
	private String userName;	//	USER_NAME	VARCHAR2(15 BYTE)
	private String email;//	EMAIL	VARCHAR2(100 BYTE)
	private String gender;//	GENDER	VARCHAR2(1 BYTE)
	private String age;//	AGE	NUMBER - String으로 작성해서 "" 빈문자열을 전달받을 수 있도록 처리 
	private String phone;//	PHONE	VARCHAR2(13 BYTE)
	private String address;//	ADDRESS	VARCHAR2(100 BYTE)
	private Date enrollDate;//	ENROLL_DATE	DATE
	private Date modifyDate;//		MODIFY_DATE	DATE
	private String status;//	STATUS	VARCHAR2(1 BYTE)
}
