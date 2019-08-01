package com.foodtruck.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.foodtruck.service.FoodTruckService;
import com.foodtruck.service.ReviewService;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.ReviewVO;

@Controller
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	@Autowired
	FoodTruckService foodtruckService;
	
	// 리뷰 등록
	@RequestMapping("/reviewRegit")
	public String reviewRegit(HttpSession session, ReviewVO rvo, HttpServletRequest request) throws Exception {
		
		String memId = (String) session.getAttribute("memberId");
		rvo.setMemId(memId);
		
		
		if(reviewService.insertReview(rvo) != 0) {
			FoodTruckVO vo = foodtruckService.getReviewCount(rvo.getFtruckNo());	// 푸드트럭 전체 리뷰 갯수
			FoodTruckVO vo2 = foodtruckService.getReviewTotal(rvo.getFtruckNo());	// 푸드트럭 전체 평점 합계
			double count = vo.getCount();
			double total = vo2.getTotal();
			double avg = (total/count);
			System.out.println("평점 총 합 " + total  + "총 갯수" + count);
			System.out.println("평균" + avg);
			FoodTruckVO vo3 = foodtruckService.getFoodTruck(rvo.getFtruckNo());		// 푸드트럭번호로 전체정보 vo3에 담기
			vo3.setFtruckGrade(avg);	// vo3에 평점값만 평균값으로 set
			foodtruckService.updateGrade(vo3);	// 수정
			request.setAttribute("msg", "고객님의 소중한 리뷰가 등록되었습니다.");
		    request.setAttribute("addr", "memberOrderInfo");
		    return "comm/msg";
		}else {
			request.setAttribute("msg", "리뷰가 등록되지 않았습니다.");
		    request.setAttribute("addr", "memberOrderInfo");
		    return "comm/msg";
		}
	}
	
	@ResponseBody
	@RequestMapping("/reviewDelete")
	public void reviewDelete(HttpServletRequest request) {
		
		int revNo = Integer.parseInt(request.getParameter("revNo"));
		reviewService.reviewDelete(revNo);
		
	}	
}
