package com.foodtruck.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodtruck.service.MemberService;
import com.foodtruck.service.NoticeService;
import com.foodtruck.vo.MemberVO;
import com.foodtruck.vo.NoticeVO;

@Controller
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	@Autowired
	MemberService memberService;
	
	// 공지사항 리스트
	@RequestMapping("/noticeBoard") 
	public String getNoticeBoardList(Model model, HttpSession session, HttpServletRequest request, 
									 MemberVO mvo, @RequestParam("pageNo") int pageNo) throws Exception {

		//페이징처리
		int NpageNo = 1;
		if (pageNo != 1) {
			NpageNo = (pageNo - 1) * 10 + 1;
		}
		
		List<NoticeVO> list = noticeService.getNoticeBoardList(NpageNo);
		
		if(list != null) {
			model.addAttribute("rank", list);
		}
		
		int count=noticeService.getCountNotice();
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("pagecount", count);
		
		return "nav/noticeBoard";
	}
	
	// 공지사항 상세보기
	@RequestMapping("/detailNoticeForm")
	public String detailNoticeForm(@RequestParam("noticeNo") int noticeNo, HttpServletRequest request) {

		NoticeVO vo = noticeService.getNotice(noticeNo);
		
		request.setAttribute("vo", vo);
		noticeService.countNotice(vo.getNoticeNo()); 
		
		return "nav/detailNoticeForm";
	}
	
	
	// 공지사항 쓰는 폼으로 이동!
	@RequestMapping("/writeNoticeForm")
	public String writeNotice(HttpSession session, HttpServletRequest request) {
		return "nav/writeNoticeForm";
	}
	
	
	// 공지사항 등록 -> 디비에 넣자!
	@RequestMapping("/insertNotice")
	public String insertNotice(HttpSession session, NoticeVO vo) {
		
		String memId = (String) session.getAttribute("memberId");
		vo.setMemId(memId);
		
		noticeService.insertNotice(vo);
		return "redirect:/noticeBoard?pageNo=1";
		
	}

	
	// 공지사항 수정폼으로 이동!
	@RequestMapping("/updateNoticeForm")
	public String updateNoticeForm(HttpServletRequest request, @RequestParam("noticeNo") int noticeNo) {
		NoticeVO vo = noticeService.getNotice(noticeNo);
		request.setAttribute("notice", vo);
		return "nav/updateNoticeForm";
	}
	
	
	// 공지사항 수정 -> 디비에 넣자!
	@RequestMapping("/updateNotice")
	public String updateNotice(NoticeVO vo) {
		noticeService.updateNotice(vo);
		return "redirect:/noticeBoard?pageNo=1";
	}
	
	
	// 공지사항 삭제
	@RequestMapping("/deleteNotice")
	public String deleteNotice(NoticeVO vo) {
		noticeService.deleteNotice(vo);
		return "redirect:/noticeBoard?pageNo=1";
	}
	
}
