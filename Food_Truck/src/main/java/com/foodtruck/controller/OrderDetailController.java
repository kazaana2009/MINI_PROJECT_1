package com.foodtruck.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.foodtruck.service.DeliveryDetailService;
import com.foodtruck.service.OrderDetailService;
import com.foodtruck.service.OrderService;
import com.foodtruck.service.SellerService;

@Controller
public class OrderDetailController {

	@Autowired
	private OrderDetailService orderDetailService;
	@Autowired
	private SellerService sellerService;
	@Autowired
	private DeliveryDetailService deliveryDetailService;
	@Autowired
	private OrderService orderService;

	// 배달상세내역보기
	@RequestMapping("/DeliveryDetail")
	public String DeliveryDetail(Model model, HttpSession session) {
		
		String memId = (String) session.getAttribute("memberId");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ordDate", null);
		map.put("memId", memId);
		map.put("licenseNo", null);
		
		if (memId != null) {

			model.addAttribute("dleverDetailList", deliveryDetailService.getDeliveryDetailList(map));
			model.addAttribute("licenseList", sellerService.getLicense(memId));
			orderService.checkNewOrderDlv(memId);
			
		} else {
			return "home";
		}
		
		return "nav/deliveryDetails";
	}

	// 예약내역 
	@RequestMapping("/orderDetail")
	public String orderDetailPage(Model model, HttpSession session) {

		String memId = (String) session.getAttribute("memberId");
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("ordDate", null);
		map.put("memId", memId);
		map.put("licenseNo", null);


		if (memId != null) {
			model.addAttribute("orderDetailList", orderDetailService.getOrderDetailList(map));
			model.addAttribute("licenseList", sellerService.getLicense(memId));
			orderService.checkNewOrderRsv(memId);
		} else {
			return "home";
		}
		// 주문 상세 리스트
		return "nav/orderDetail";
	}
	
	// 예약 내역 -> 사업자 번호 + 원하는 날짜 선택 했을 때, 해당 예약 내역 뽑아 올 수 있도록 비동기 처리
	@RequestMapping("/orderDetail2")
	@ResponseBody
	public ModelAndView calandLicenseNoChagneList(Model model, HttpSession session,
												  @RequestParam("ordDate") String ordDate, 
												  @RequestParam("licenseNo") String licenseNo) {

		System.out.println("선택한 날짜  : " + ordDate);
		String memId = (String)session.getAttribute("memberId");

		ModelAndView mv = new ModelAndView(new MappingJackson2JsonView());

		HashMap<String, Object> map = new HashMap<>();
		map.put("memId", memId);
		map.put("ordDate", ordDate);
		map.put("licenseNo", licenseNo);

		if (memId != null) {
			System.out.println("다시 orderdetail.jsp로 돌아갑니다.");
			mv.addObject("orderDetailList", orderDetailService.getOrderDetailList(map));
		}
		return mv;
	}
}
