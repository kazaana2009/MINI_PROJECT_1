package com.foodtruck.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.foodtruck.vo.EventVO;

@Controller
@RequestMapping("/android")
public class AndroidSellerController {
	/* EVENT COUNT */
	@RequestMapping(value = "/seller/", method = RequestMethod.PUT)
	public ResponseEntity<String> androidEventCount(@RequestBody EventVO vo) throws Exception {
		
		if (true) {
			return new ResponseEntity<String>(HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}

	}
	// 판매자
	/* 주문확인 */
	/* 종료 */
	/* 주문거부 */
	/* 위치변경 */
	/* 매출통계 및 매출관리 */
}
