package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.FoodTruckDAO;
import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.PageVO;

@Service
public class FoodTruckService {

	@Autowired
	private SqlSessionTemplate sessionTemplate;

	// 푸드트럭 정보
	public FoodTruckVO getFoodTruck(String ftruckNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getFoodTruck(ftruckNo);
	}

	// 푸드트럭에 달린 리뷰 총 갯수
	public FoodTruckVO getReviewCount(String ftruckNo)throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getReviewCount(ftruckNo);
	}
	
	// 푸드트럭에 달린 리뷰 총 합계
	public FoodTruckVO getReviewTotal(String ftruckNo)throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getReviewTotal(ftruckNo);
	}
	
	// 댓글달면 평점수정
	public void updateGrade(FoodTruckVO vo)throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		dao.updateGrade(vo);
	}	
	
	// 라이센스번호로 푸드트럭 정보 가져오기
	public FoodTruckVO getFoodTruck2(String licenseNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getFoodTruck2(licenseNo);
	}

	// 푸드트럭 리스트 가져오기
	public List<FoodTruckVO> getFoodTruckList(int pageNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getFoodTruckList(pageNo);
	}

	// 카테고리별 리스트
	public List<FoodTruckVO> getCategoryList(PageVO vo) {

		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		try {
			return dao.getCategoryList(vo);

		} catch (Exception e) {
			System.out.println("ERROR : " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	// 푸드트럭 위클리 랭킹
	public List<FoodTruckVO> getFoodTruckRank() {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		System.out.println(dao.getFoodTruckRank());
		return dao.getFoodTruckRank();
	}

	// 신규 푸드트럭
	public List<FoodTruckVO> getNewFoodTruck() {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getNewFoodTruck();
	}	

	// 푸드트럭 수정
	public int updateFoodTruck(FoodTruckVO vo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.updateTruck(vo);
	}

	// 푸드트럭 삭제
	public int deleteFoodTruck(String licenseNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.deleteTruck(licenseNo);
	}

	// 푸드트럭 전체 Count(페이징처리)
	public int getCountTruck() throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getCountTruck();
	}

	// 푸드트럭 카테고리별 Count(페이징처리)
	public int getCategoryCountTruck(int category) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getCategoryCountTruck(category);
	}

	public List<FoodTruckVO> getFoodTruckList2(int PageNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getFoodTruckList2(PageNo);
	}

	// 운영중 푸드트럭 리스트 가져오기
	public List<FoodTruckVO> getRunFoodTruckList(int pageNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getRunFoodTruckList(pageNo);
	}

	// 마감된 푸드트럭 리스트 가져오기
	public List<FoodTruckVO> getEndFoodTruckList(int pageNo) throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getEndFoodTruckList(pageNo);
	}
	// 푸드트럭 리스트 가져오기(조건이없는)
	public List<FoodTruckVO> getAllFoodTruckList(int pageNo) throws Exception{
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getAllFoodTruckList(pageNo);
	}
	// 푸드트럭 전체 리스트 Count(조건이없는&페이징처리)
	public int getAllCountTruck()throws Exception{
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getAllCountTruck();
	}
	// 운영중인푸드트럭 전체 Count(페이징처리)
	public int getRunCountTruck() throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getRunCountTruck();
	}

	// 마감된 푸드트럭 전체 Count(페이징처리)
	public int getEndCountTruck() throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getEndCountTruck();
	}
	//푸드트럭 주소 업데이트
	public int updateTruckPosition(FoodTruckVO vo) throws Exception{
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.updateTruckPosition(vo);
	}
	
	// 푸드트럭 별 리뷰 수 
	public List<FoodTruckVO> getReviewCountList()throws Exception {
		FoodTruckDAO dao = sessionTemplate.getMapper(FoodTruckDAO.class);
		return dao.getReviewCountList();
	}
	
	
}
