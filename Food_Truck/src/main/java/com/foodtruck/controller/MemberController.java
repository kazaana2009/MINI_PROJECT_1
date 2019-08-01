package com.foodtruck.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodtruck.service.MemberService;
import com.foodtruck.service.OrderService;
import com.foodtruck.service.SellerService;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.MInquiryVO;
import com.foodtruck.vo.MemberVO;
import com.foodtruck.vo.MinquiryReplyVO;
import com.foodtruck.vo.OrderVO;

@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	@Autowired
	SellerService sellerService;
	@Autowired
	OrderService orderService;
	
	// 1:1 문의 페이지 이동
	@RequestMapping("/inquiryPage")
	public String inquiryPage(HttpSession session,HttpServletRequest request) {
		
		String memId = (String)session.getAttribute("memberId");
		String gubun = (String)session.getAttribute("memberGubun");
		
		if(memId == null) {
			return "redirect:/loginform";
		}
		
		if(gubun.equals("2")) {
			LicenseVO vo=new LicenseVO();
			vo.setMemId(memId);
			List<LicenseVO> list=sellerService.getInfo(vo);
			request.setAttribute("list", list);
		}else if(gubun.equals("3")){
			List<OrderVO> list = orderService.getOrdNo(memId);		// 사용자가 주문한 정보 ordNo만 쓸거
			request.setAttribute("list", list);
		}
		
		return "member/inquiry";
	}	
	
	//1:1문의하기
	@RequestMapping("/inquriy")
	public String memberinquriy(MInquiryVO vo,HttpSession session,HttpServletRequest request,@RequestParam(value="ordNo",required=false)String ordNo) {	
		String memId = (String)session.getAttribute("memberId");
		String gubun = (String)session.getAttribute("memberGubun");
		vo.setMemId(memId);
		
		if(gubun == "2") {
			memberService.insertInquiry2(vo);
			
		} else if(gubun == "3"){
			if(ordNo == "") {
				vo.setLicenseNo("");
				vo.setQaScCategory1(vo.getQaSelCategory1());
				vo.setQaScCategory2(vo.getQaSelCategory2());
				vo.setQaScTitle(vo.getQaSelTitle());
				vo.setQaScContent(vo.getQaSelContent());
				vo.setQaScTel(vo.getQaSelTel());
				memberService.insertInquiry2(vo);
			}else {
				memberService.insertInquiry(vo); //사용자가 판매자한테 
			}
		}
		return "redirect:/";
	}

	// 회원으로 로그인 했을 때 나의주문 -> 나의 설정
	@RequestMapping("/memberInfo")
	public String memberInfo(HttpSession session, HttpServletRequest request) {
		
		String memId = (String) session.getAttribute("memberId");
		MemberVO vo = memberService.getMember(memId);
		
		request.setAttribute("memberInfo", vo);
		return "member/memberInfo";
	}
	
	// 수정 클릭 했을 때, 암호입력(true / false 결과)
	@RequestMapping("/memberInfoUpdateGet")
	public String memberInfoUpdate(HttpSession session,HttpServletRequest request) {
		
		String memId = (String) session.getAttribute("memberId");
		MemberVO vo = memberService.getMember(memId);
		request.setAttribute("memberInfo", vo);
		return "member/memberInfoUpdate";
	}
	
	// 회원 수정 폼 -> 수정 완료
	@RequestMapping("/memberInfoUpdate")
	public String memberInfoUpdate(MemberVO vo) {
		memberService.updateMember(vo);
		return "redirect:/memberInfo";
	}
	
	// 관심있는 푸드트럭 5개 까지 보여주고 / 바로 주문할 수 있또로로오오오옥!
	@RequestMapping("/favoriteFoodtruck")
	public String favoriteFoodtruckPage(HttpSession session, HttpServletRequest request) {
		
		String memId = (String) session.getAttribute("memberId");
		List<OrderVO> list = orderService.getFavoriteFoodtruck(memId);

		request.setAttribute("list", list);
			
		return "nav/favoriteFoodtruck";
	}
	
	//사용자 문의 내역 리스트
	@RequestMapping("/memberQaInfoList") 
	public String memberQaInfoList(HttpSession session,HttpServletRequest request) {
		
		String memId = (String)session.getAttribute("memberId");
		String memGubun = (String)session.getAttribute("memberGubun");
		String gubun = request.getParameter("gubun");
		
		if(memId == null) {
			return "redirect:/loginform";
		}
		
		if(memGubun == "3") {
			if(gubun == null) {
				request.setAttribute("qalist",memberService.getMemberQaSelInfoList(memId));	// 사용자가 판매자에게 문의한 리스트 
			}else {
				request.setAttribute("qalist", memberService.getMemberQaScInfoList(memId));// 사용자가 관리자에게 문의한 리스트
			}
		} else if(memGubun == "2"){
			if(gubun != null) {
				request.setAttribute("qalist", memberService.getSellerQaSelInfoList(memId));
				return "member/sellerQnA";
			}
			request.setAttribute("qalist", memberService.getMemberQaScInfoList(memId));// 판매자가 관리자에게 문의한 리스트
		}
		
		return "member/memberQaInfoList";
	}
	
	//사용자 문의 내역 상세보기 (판매자)
	@RequestMapping("/memberQaSelInfo")
	public String memberQaSelInfo(HttpServletRequest request) {
		
		int qaSelNo = Integer.parseInt(request.getParameter("qaSelNo"));
		
		MInquiryVO vo = memberService.getMemberQaSelInfo(qaSelNo);
		System.out.println(vo.getQaSelCategory1());
		System.out.println(vo.getQaSelCategory2());
		request.setAttribute("qaInfo", vo);
		MinquiryReplyVO vo2 = memberService.getMemberQaSelReply(qaSelNo);
		request.setAttribute("qaReply", vo2);
		
		
		
		return "member/memberQaInfo";
	}	
	
	// 사용자  문의 내역 상세보기(관리자)
	@RequestMapping("/memberQaScInfo")
	public String memberQaScInfo(HttpServletRequest request) {
		
		int qaScNo = Integer.parseInt(request.getParameter("qaScNo"));
		
		MInquiryVO vo = memberService.getMemberQaScInfo(qaScNo);

		request.setAttribute("qaInfo", vo);
		MinquiryReplyVO rvo = memberService.getMemberQaScReply(qaScNo);
		request.setAttribute("qaReply", rvo);
		
		return "member/memberQaInfo";
	}
	
	
	// 사용자가 문의한 문의 내역 상세보기 ( 판매자가 ) 
	@RequestMapping("/sellerQnAReply")
	public String sellerQnAReply(HttpServletRequest request) {
		
		int qaSelNo = Integer.parseInt(request.getParameter("qaSelNo"));
		MInquiryVO vo = memberService.getMemberQaSelInfo(qaSelNo);
		request.setAttribute("qaInfo", vo);
		MinquiryReplyVO rvo = memberService.getMemberQaSelReply(qaSelNo);
		request.setAttribute("qaReply", rvo);
		
		return "member/sellerQnAInfo";
	}
	
	// 사용자 문의 답변 ( 판매자 ) 
	@RequestMapping("/qaScInsert")
	public String qaScInsert(HttpServletRequest request,MinquiryReplyVO vo) {
		
		if(memberService.qaScReplyInsert(vo) != 0 ) {		// 답변이 성공하면
			memberService.qaSelStatUpdate(vo.getQaSelNo());  // 고객문의 테이블 답변여부 N -> Y 로 수정
		}
		return "redirect:/memberQaInfoList?gubun=1";				// 문의 내역 폼으로 
	}
}
