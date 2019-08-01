package com.foodtruck.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.foodtruck.service.EventService;
import com.foodtruck.service.FoodTruckService;
import com.foodtruck.service.MemberService;
import com.foodtruck.service.SellerService;
import com.foodtruck.vo.EventVO;
import com.foodtruck.vo.MemberVO;

@Controller
public class EventController {

	@Autowired
	EventService eventService;
	@Autowired
	MemberService memberService;
	@Autowired
	FoodTruckService foodtruckService;
	@Autowired
	SellerService sellerService;

	// 이벤트 페이지
	@RequestMapping("/eventBoard")
	public String getEventBoardList(Model model, HttpSession session, HttpServletRequest request, 
									@RequestParam("pageNo") int pageNo) {
		// 페이징처리
		int NpageNo = 1;
		if (pageNo != 1) {
			NpageNo = (pageNo - 1) * 10 + 1;
		}
		
		int count = eventService.getCountEvent();
		List<EventVO> list = eventService.getEventBoardList(NpageNo);

		if (list != null) {
			model.addAttribute("rank", list);
		}
		
		request.setAttribute("pageNo", pageNo);
		request.setAttribute("pagecount", count);
		return "nav/eventBoard";
	}

	// 이벤트 상세보기
	@RequestMapping("/detailEventForm")
	public String detailEventForm(@RequestParam("eventNo") int eventNo, HttpServletRequest request) {
	
		EventVO vo = eventService.getEvent(eventNo);
		request.setAttribute("vo", vo);
		eventService.countEvent(vo.getEventNo());
		return "nav/detailEventForm";
		
	}

	// 이벤트 등록하기
	@RequestMapping("/writeEventForm")
	public String writeEvent(HttpServletRequest request, HttpSession session) {
		
		String memId = (String) session.getAttribute("memberId");
		request.setAttribute("licenseList", sellerService.getLicense(memId));
		
		return "nav/writeEventForm";
		
	}

	// 이벤트 등록폼에서 넘어온 값들 디비에 저장
	@RequestMapping("/insertEvent")
	public String insertEvent(HttpSession session, EventVO vo,
							  @RequestParam(value = "licenseNo", required = false) String licenseNo,
							  @RequestParam(value = "eventReg2", required = false) String eventReg2) {

		MemberVO mvo = (MemberVO) session.getAttribute("member");
		System.out.println("eventReg2" + eventReg2);
			
		// 이벤트 해당 시간내에만 보여주기 위해서
		String addHourTime = "";
		Date date = new Date();
		SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.HOUR, Integer.parseInt(eventReg2));
		addHourTime = sdformat.format(cal.getTime());
		System.out.println(addHourTime);
			
		vo.setEventReg2(addHourTime);
		vo.setMemId(mvo.getMemberId()); 
		vo.setLicenseNo(licenseNo);
			
		eventService.insertEvent(vo);
		return "redirect:/eventBoard?pageNo=1";
			
	}
	
	// 수정하기 눌렀을 떄, 수정폼
	@RequestMapping("/updateEventForm")
	public String updateEventForm(HttpServletRequest request, @RequestParam("eventNo") int eventNo, HttpSession session) {

		EventVO vo = eventService.getEvent(eventNo);
		request.setAttribute("event", vo);
		return "nav/updateEventForm";
		
	}

	// 수정폼에서 넘어온 값들 디비에 저장
	@RequestMapping("/updateEvent")
	public String updateEvent(EventVO vo) {
		
		eventService.updateEvent(vo);
		System.out.println("update Controller");
		return "redirect:/eventBoard?pageNo=1";
		
	}

	// 이벤트 삭제
	@RequestMapping("/deleteEvent")
	public String deleteEvent(EventVO vo) {
		
		eventService.deleteEvent(vo);
		return "redirect:/eventBoard?pageNo=1";
		
	}
}
