package com.foodtruck.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.foodtruck.service.MemberService;
import com.foodtruck.service.SellerService;
import com.foodtruck.vo.MemberVO;
import com.foodtruck.vo.SellerVO;

@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	MemberService memberService;
	@Autowired
	SellerService sellerService;

	// 로그인 폼으로 이동
	@RequestMapping("/loginform")
	public String loginform() {
		logger.info("loginform");
		return "sign/login";
	}

	// 로그인 했을때
	@RequestMapping("/login")
	public String login(@RequestParam("id") String id, @RequestParam("pw") String pw, HttpSession session,
						HttpServletRequest request, HttpServletResponse response) {
		
		MemberVO mvo = memberService.getMember(id);

		if (mvo != null) {
			
			if (mvo.getMemberPw().equals(pw)) {
				session.setAttribute("member", mvo);
				session.setAttribute("memberId", mvo.getMemberId());
				session.setAttribute("memberName", mvo.getMemberName());
				if(mvo.getMemberAuth().equals("1")) {
					session.setAttribute("memberGubun","1");
				} else if(mvo.getMemberAuth().equals("2")) {
					session.setAttribute("memberGubun","2");					 
					List<SellerVO> list=sellerService.getLicense(mvo.getMemberId());
					session.setAttribute("licenseNo", list);
				} else if(mvo.getMemberAuth().equals("3")) {
					session.setAttribute("memberGubun", "3");
				}
				request.getSession().setAttribute("member", mvo);
				return "redirect:/";
			
			} else {
				request.setAttribute("msg", "비밀번호가 틀립니다.");
				request.setAttribute("addr", "loginform");
				return "comm/msg";
			}

		} else {
			request.setAttribute("msg","아이디를 다시 확인해 주세요");
			request.setAttribute("addr", "loginform");
			return "comm/msg";
		}
	}

	// 로그아웃 했을때
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletRequest request) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원가입페이지
	@RequestMapping("/joinform")
	public String joinFormPage() {  
		return "sign/joinform";
	}

	// 회원 가입
	@RequestMapping("/join")
	public String insertMember(HttpServletRequest request, MemberVO vo) {

		String gubun[] = request.getParameterValues("gubun");

		for (String g : gubun) {
			if (g.equals("member")) {
				vo.setMemberAuth("3"); // 일반회원
			} else if (g.equals("seller")) {
				vo.setMemberAuth("2"); // 판매자
			}
		}

		memberService.insertMember(vo);

		return "redirect:/";
	}

	// ID 중복체크
	@ResponseBody
	@RequestMapping("/idCheck")
	public MemberVO memberIdCheck(HttpServletRequest request) {
		String memberId = request.getParameter("memberId");

		return memberService.getMember(memberId);
	}
	
	// 로그인 페이지에서 ID/PW 찾기 페이지로 이동
	@RequestMapping("/findAccount")
	public String accountFind(HttpServletRequest request)throws Exception {
		
		request.setAttribute("id", memberService.getMemberList());
		return "sign/findAccount";
		
	}
	
	//ID 찾기
	@ResponseBody
	@RequestMapping("/findId")
	public MemberVO findId(HttpServletRequest request){
		String memberTel = request.getParameter("memberTel");
		System.out.println("**회원 휴대폰번호**" + memberTel);
		return memberService.getId(memberTel);
	}
	
	//PW 찾기
	@ResponseBody
	@RequestMapping("/findPw")
	public MemberVO findPw(HttpServletRequest request){
		String memberTel = request.getParameter("memberTel2");
		String memberId = request.getParameter("memberId");
		System.out.println("pw찾기) 휴대폰번호 : " + memberTel + " / 회원 아이디 " + memberId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("memberTel", memberTel);
		map.put("memberId", memberId);
		
		return memberService.getPw(map);
	}
	
}

