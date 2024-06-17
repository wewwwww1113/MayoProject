package com.kh.springProject.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.springProject.member.model.service.MemberService;
import com.kh.springProject.member.model.vo.Member;

@Controller //Controller타입의 어노테이션을 붙여주면 빈 스캐닝을 통해서 자동으로 bean등록해줌
public class MemberController {
	
	
	//기존 jsp servlet 방식
	//private MemberService service = new MemberServiceImpl();
	
	/*
	 * 기존 객체 생성 방식
	 * 객체 간의 결합도가 높아진다 (소스코드의 수정이 일어날 경우 직접 변경을 해줘야함.)
	 * 서비스가 동시에 많은 횟수가 요청될 경우 그만큼 객체가 생성 될 수 있다.
	 * 
	 * Spring의 DI(Dependency Injection) 방식 
	 * 객체를 spring에서 생성하여 주입해준다 (객체간의 결합도를 낮춰줌)
	 * new 라는 생성 키워드 없이 선언문을 작성한 뒤 @Autowired 라는 어노테이션만 추가해주면 된다.
	 * 
	 * */
	
	@Autowired
	private MemberService memberService;
	
	//spring-security 에서 필요한 암호화 클래스 선언
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	
	
	// login.me 
	//기존 servlet에서는 각 매핑주소마다 별도의 servlet을 정의하여 매핑시켜야 했지만
	//spring에서는 DispatcherServlet이 모든 요청에대한 처리를 하기때문에 
	//controller에서 각 매핑주소에 맞는 메소드를 작성하면 된다.
	
	
	/*
	 * Spring에서는 파라미터를 전달 받는 방법이 request에서 받는 방법과 
	 * 어노테이션을 이용하는 방법, 어노테이션을 생략하는방법
	 * 커맨드 객체 방식으로 작성될 수 있다.
	 * 
	 * 1.HttpServletRequest를 이용하여 파라미터 전달받기 (기존 jsp/servlet 방식)
	 * 	사용하고자 하는 메소드의 매개변수로 HttpServletRequest를 작성하면 
	 * 	스프링 컨테이너가 해당 메소드를 호출할때 자동으로 해당 객체를 생성하여 주입해준다.
	 * */
	
	/*
	@RequestMapping("login.me")
	public String loginMember(HttpServletRequest request) {
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		System.out.println(userId);
		System.out.println(userPwd);
		//반환할 문자열 :보여주고자하는 뷰페이지의 경로중  WEB-INF/views/ 와 .jsp 사이에 들어가야하는 경로 또는 뷰페이지명
		//ex) WEB-INF/views/board/boardListView.jsp 라고 한다면 이때 반환해야하는 문자열은 ? 
		// 	  return "board/boardListView"; 
		return "main";//main페이지로 포워딩처리 
	}
	*/
	
	/*
	 * 2.@RequestParam 어노테이션 이용하기
	 *	request.getParameter("키)로 값을 추출했던 역할을 수행해주는 어노테이션
	 *	value속성의 값으로 jsp에서 작성했던 name속성값을 넣어주면 해당 값을 매개변수로 받아올 수 있음 
	 *	만약 넘어온 값이 비어있는 상태라면 defaultValue속성을 이용하여 기본값도 지정가능
	 * */
	/*
	@RequestMapping("login.me")
	public String loginMember(@RequestParam(value="userId",defaultValue="aaa")String userId
							 ,@RequestParam(value="userPwd")String userPwd) {
		
		System.out.println(userId);
		System.out.println(userPwd);
		
		
		return "main";
	}
	*/
	
	/*
	 * 3. @RequestParam 어노테이션을 생략하는 방법
	 *  defaultValue와 같은 추가 속성이 필요하지 않다면 
	 *  어노테이션을 생략할 수 있다. 단, 매개변수명과 view페이지의 name값은 일치시켜야한다.
	 * */
	/*
	@RequestMapping("login.me")
	public String loginMember(String userId,String userPwd) {
		
		System.out.println(userId);
		System.out.println(userPwd);
		
		//위와같이 매개변수로 받아와서 마이바티스를 이용하여 처리하려면
		//매개변수는 하나만 전달이 가능하기 때문에 한곳에 담아주는 작업이 추가적으로 필요하다
		//ex)
		Member m = new Member();
		m.setUserId(userId);
		m.setUserPwd(userPwd);
		
		//service에 전달 및 요청~~~~
		
		return "main";
	}
	*/
	
	/*
	 * 4.커맨드 객체 방식
	 * 	 해당 메소드의 매개변수로 요청시 전달값을 담고자 하는 VO클래스타입을 세팅한뒤
	 * 	 요청시 전달값의 name속성값을 VO클래스의 담고자하는 필드명으로 작성하면
	 *   스프링 컨테이너가 해당 객체를 기본생성자로 생성 후 내부적으로 setter메소드를 이용하여
	 *   요청시 전달값을 필드에 담아주는 기능		
	 * 	
	 *   * name속성값과 담고자하는 필드명이 일치해야한다 *
	 * */
	/*
	@RequestMapping("login.me")
	public String loginMember(Member m) {
		
		System.out.println(m);
		System.out.println(m.getUserId());
		System.out.println(m.getUserPwd());
		
		return "main";
		
	}
	*/
	
	
	/*
	 * 요청 처리 후 응답데이터를 담고 응답페이지로 포워딩 또는 url 재요청(redirect) 하는 방법
	 * 
	 * 1. 스프링이 제공하는 Model객체를 이용하는 방법
	 * 	  포워딩할 응답뷰로 전달하고자 하는 데이터를 map 형식 (key-value)로 담을 수 있는 영역
	 * 	  Model 객체는 requestScope 이다
	 * 	  이때 해당 객체에 값는 메소드는 addAttribute()를 사용한다.
	 * */
	/*
	@RequestMapping("login.me")
	public String loginMember(Member m
							 ,Model model
							 ,HttpSession session) {
		
		//m에 데이터를 담아온뒤 service-dao-db 작업을 거치고 돌아와서 전달값이 있을때 
		//기존과 같이 request.setAttribute메소드를 이용하는것이 아닌 
		//model이라고 하는 객체에 담아서 처리한다.
		//매개변수에 Model 객체를 선언해주면 스프링컨테이너가 생성하여 주입해준다.
		//만약 Session필요하면 위와같이 매개변수에 선언하여 받아온다 
		
		//MemberService service = new MemberServiceImpl();
		//service.loginMember(m); 
		//위 작업을 수행한 결과가 Member loginUser 로 돌아왔을때 
		
		Member loginUser = memberService.loginMember(m); 
		
		if(loginUser == null) { //로그인 실패 
			//에러페이지로 포워딩 - model
			model.addAttribute("errorMsg","로그인 실패");
			
			// /WEB-INF/views/ 와 .jsp 사이의 경로만 작성 
			return "common/errorPage";
			
		}else {//로그인 성공
			//메인페이지로 redirect(재요청) - session
			
			//로그인 정보 세션에 담아주기
			session.setAttribute("loginUser", loginUser);
			//메세지 담기
			session.setAttribute("alertMsg", "로그인 성공!");
			
			//재요청 방식 (redirect방식)
			// "redirect:경로"
			return "redirect:/";
		}
	}
	*/
	
	/*
	 * 2.스프링에서 제공하는 ModelAndView 객체 이용하여 응답하는 방법
	 * 	 Model은 데이터를 key-value세트로 담을 수 있는 공간이라고 한다면 
	 * 	 View는 응답뷰에 대한 정보를 담을 수 있는 공간이다.
	 * 	 이 경우에는 반환타입이 String이 아닌 ModelAndView 타입이 되어야한다.
	 * 
	 * 	 Model과 View가 결합된 형태로 View객체를 단독으로 사용할수는 없다
	 * */
	
	/*
	 * 암호화 처리 전 로그인 메소드
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m
							 ,ModelAndView mv
							 ,HttpSession session) {
		
		Member loginUser = memberService.loginMember(m); 
		
		if(loginUser == null) { //로그인 실패 
			//ModelAndView 객체에 데이터를 담는 메소드는 addObject() 메소드를 사용한다.
			mv.addObject("errorMsg", "로그인 실패!!"); 
			//view페이지에 대한 정보도 담아준다 이때 사용하는 메소드는 setViewName() 메소드를 사용한다.
			mv.setViewName("common/errorPage"); //경로작성방법은 포워딩처리와 같다
		}else {//로그인 성공
			session.setAttribute("alertMsg", "로그인 성공!!");
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/"); //redirect 경로 작성방식도 동일하다
		}
		
		return mv; //데이터와 뷰페이지정보를 담아서 반환한다 
	}
	*/
	
	//암호화 처리 후 로그인 메소드 
	//암호화된 비밀번호와 사용자가 입력한 비밀번호를 판별하여 로그인 처리하기 
	@RequestMapping("login.me")
	public ModelAndView loginMember(Member m
							 ,ModelAndView mv
							 ,HttpSession session) {
		
		//사용자가 입력한 아이디를 통해서 해당 회원이 존재하는지 판별 후 회원정보 조회해오기
		//조회해온 데이터중 비밀번호에 있는 암호문을 복호화한 데이터가 사용자가 입력한 평문과 동일하다면
		//로그인 처리 (성공)
		//복호화한 데이터가 평문과 일치하지 않는다면 로그인 실패 
		//이때 사용하게될 메소드는 bcryptPasswordEncoder.matches(평문,암호문) 메소드 이용
		//평문과 복호화한 암호문이 일치하면 true 일치하지 않으면 false를 반환하는 메소드
		//단 복호화한 데이터를 돌려주지는 않는다 (내부적으로 판별작업만 수행해줌)
		
		Member loginUser = memberService.loginMember(m);
		//위에 조회해온 loginUser는 사용자가 입력한 아이디만으로 조회해온 데이터이기때문에 
		//만약 비밀번호가 맞지 않더라도 조회가 되어있다.
		//matches 메소드를 이용하여 사용자에게 성공 실패 화면 선택해주기
		
		if(loginUser == null || !bcryptPasswordEncoder.matches(m.getMemberPwd(), loginUser.getMemberPwd())) { //로그인 실패 
			//ModelAndView 객체에 데이터를 담는 메소드는 addObject() 메소드를 사용한다.
			mv.addObject("errorMsg", "로그인 실패!!"); 
			//view페이지에 대한 정보도 담아준다 이때 사용하는 메소드는 setViewName() 메소드를 사용한다.
			mv.setViewName("common/errorPage"); //경로작성방법은 포워딩처리와 같다
		}else {//로그인 성공
			session.setAttribute("alertMsg", "로그인 성공!!");
			session.setAttribute("loginUser", loginUser);
			mv.setViewName("redirect:/"); //redirect 경로 작성방식도 동일하다
		}
		return mv; //데이터와 뷰페이지정보를 담아서 반환한다 
		
	}
	
	
	//로그아웃 메소드
	@RequestMapping("logout.me")
	public String logoutMember(HttpSession session) {
		
		session.removeAttribute("loginUser");
		
		return "redirect:/";
	}
	
	
	//회원가입페이지로 이동 메소드 (get방식)
	@GetMapping("insert.me")
	public String memberEnrollForm() {
		//회원가입 페이지로 단순 이동처리
		return "member/memberEnrollForm";
	}
	
	//회원정보 등록 메소드 (post방식)
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
	
	
	//마이페이지 이동 메소드
	@RequestMapping("mypage.me")
	public String myPage() {
		//마이페이지로 이동 하는 메소드 
		return "member/myPage";
	}
	
	
	//정보수정 메소드
	@RequestMapping("update.me")
	public String updateMember(Member m
							  ,Model model
							  ,HttpSession session) {
		
		//DML(update) 
		int result = memberService.updateMember(m);
		
		//성공시 갱신된 정보로 마이페이지 이동하기
		if(result>0) { //성공
			//세션에 등록되어있는 회원정보를 갱신해야한다(변경전 정보가 담겨있음) 
			//갱신된 정보 조회하기(기존에 작성해둔 로그인(select) 기능 이용하기
			Member updateMem = memberService.loginMember(m);
			session.setAttribute("loginUser", updateMem);//세션에 갱신하기
			session.setAttribute("alertMsg", "정보수정 성공!!");
			
			//마이페이지 재요청하기(매핑주소)
			return "redirect:mypage.me";
			
		}else {
			//실패시 에러페이지 이동
			model.addAttribute("errorMsg", "정보 수정 실패!");
			return "common/errorPage";
			
		}
		
	}
	
	
	
	
	
	
	
	
	
}
