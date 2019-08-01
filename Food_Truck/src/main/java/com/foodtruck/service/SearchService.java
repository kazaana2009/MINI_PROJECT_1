package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.SearchDAO;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.SearchPageVO;

@Service
public class SearchService {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	public List<FoodTruckVO> getFoodTruckList(SearchPageVO vo) throws Exception{
		SearchDAO dao = sessionTemplate.getMapper(SearchDAO.class);
		return dao.getFoodTruckList(vo);
	}

	public int getCategoryCountTruck(String searchStr) throws Exception{
		SearchDAO dao = sessionTemplate.getMapper(SearchDAO.class);
		return dao.getCategoryCountTruck(searchStr);
	}

}
