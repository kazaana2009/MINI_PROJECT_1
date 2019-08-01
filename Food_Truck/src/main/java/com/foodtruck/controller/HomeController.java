package com.foodtruck.controller;



import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.foodtruck.service.FoodTruckService;
import com.foodtruck.vo.FoodTruckVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private FoodTruckService foodTruckService;

	/** 
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model,Model model2) {
		
		List<FoodTruckVO> list = foodTruckService.getFoodTruckRank();
		List<FoodTruckVO> nlist = foodTruckService.getNewFoodTruck();
		if(list != null) {
			model.addAttribute("rank", list);
			model2.addAttribute("newTruck", nlist);
		}
//		logger.info("index"); 
		
		
		return "home";
	}
}
