package com.foodtruck.dao;

import java.util.List;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.PageVO;
import com.foodtruck.vo.SearchPageVO;

public interface SearchDAO {

	public List<FoodTruckVO> getFoodTruckList(SearchPageVO vo) throws Exception;

	public int getCategoryCountTruck(String searchStr) throws Exception;
	
	

}
