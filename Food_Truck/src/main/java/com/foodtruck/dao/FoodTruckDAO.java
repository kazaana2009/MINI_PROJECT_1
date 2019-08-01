package com.foodtruck.dao;

import java.util.List;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.PageVO;

public interface FoodTruckDAO {
	
	// 푸드트럭 정보
	public FoodTruckVO getFoodTruck(String ftruckNo)throws Exception;
	
	// 푸드트럭 리뷰 합계 
	public FoodTruckVO getReviewTotal(String ftruckNo)throws Exception;
	
	// 푸드트럭 리뷰 갯수
	public FoodTruckVO getReviewCount(String ftruckNo)throws Exception;
	
	// 댓글달면 평점수정
	public void updateGrade(FoodTruckVO vo)throws Exception;
	
	// 영업중 푸드트럭 정보
	public FoodTruckVO getRunFoodTruck(String ftruckNo)throws Exception;
	
	//마감중 푸드트럭 정보
	public FoodTruckVO getEndFoodTruck(String ftruckNo)throws Exception;
	
	//푸드트럭 리스트(조건이 있는)
	public List<FoodTruckVO> getFoodTruckList(int pageNo)throws Exception;
	
	//푸드트럭 리스트 (조건이 없는)
	public List<FoodTruckVO> getAllFoodTruckList(int pageNo)throws Exception;
	
	//푸드트럭 리스트(운영중)
	public List<FoodTruckVO> getRunFoodTruckList(int pageNo)throws Exception;
	
	//푸드트럭 리스트(마감)
	public List<FoodTruckVO> getEndFoodTruckList(int pageNo)throws Exception;
	
	// 카테고리별 리스트
	public List<FoodTruckVO> getCategoryList(PageVO vo)throws Exception;
	
	// 푸드트럭 위클리 랭킹
	public List<FoodTruckVO> getFoodTruckRank();

	// 신규 푸드트럭
	public List<FoodTruckVO> getNewFoodTruck();

	// 푸드트럭 수정
	public int updateTruck(FoodTruckVO vo)throws Exception;
	
	// 푸드트럭 위치 수정
	public int updateTruckPosition(FoodTruckVO vo)throws Exception;
	
	// 푸드트럭 삭제
	public int deleteTruck(String ftruckNo)throws Exception;
	
	//푸드트럭 전체count(페이징처리)
	public int getCountTruck()throws Exception;
	
	//푸드트럭 카테고리별 count(페이징처리)
	public int getCategoryCountTruck(int category)throws Exception;
	
	//??
	public List<FoodTruckVO> getFoodTruckList2(int PageNo) throws Exception;
	
	//라이센스번호로 푸드트럭 정보가져오기
	public FoodTruckVO getFoodTruck2(String licenseNo)throws Exception;
	
	//전체 푸드트럭 리스트 (조건이없는) count	
	public int getAllCountTruck() throws Exception;
	
	//운영중인 푸드트럭 count
	public int getRunCountTruck()throws Exception;
	
	//마감된 푸드트럭 count
	public int getEndCountTruck()throws Exception;
	
	// 푸드트럭 별 리뷰 수 
	public List<FoodTruckVO> getReviewCountList()throws Exception;
	
}
