package com.foodtruck.dao;

import java.util.List;


import com.foodtruck.vo.FoodTruckVO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.MInquiryVO;
import com.foodtruck.vo.ProductVO;
import com.foodtruck.vo.SellerVO;

public interface SellerDAO {
	
	// 푸드트럭 정보
	public FoodTruckVO getFoodTruck(String licenseNo);
	
	// 오늘의 주문 내역 리스트
	public List<SellerVO> getTodayOrderList(String licenseNo);
	
	// 오늘의 배달 내역 리스트
	public List<SellerVO> getTodayDlvList(String licenseNo);
	
	// 오늘의 예약 내역 리스트
	public List<SellerVO> getTodayRsvList(String licenseNo);
	
	// 총 주문 리스트
	public List<SellerVO> getOrderList(String licenseNo);
	
	// 오늘의 매출건수
	public List<SellerVO> getTodayPayment(String licenseNo);
	
	// 판매자의 라이센스 번호 가져오기
	public List<SellerVO> getLicense(String memberId);
	
	//판매자의 푸드트럭 승인 flg
	public List<SellerVO> getLicense2(String memberId);
	
	// 푸드트럭 리스트
	public List<FoodTruckVO> getFoodTruckList(String licenseNo);
	
	// 푸드트럭 등록
	public int insertFoodTruck(FoodTruckVO vo);
	
	//푸드트럭 마감
	public int closeFoodTruck(FoodTruckVO vo);
	
	//푸드트럭 운영
	public int openFoodTruck(FoodTruckVO vo);
	
	// 매출 등록
	public int insertPrice(SellerVO vo);
	
	// 매출 수정
	public int updatePrice(SellerVO vo);
	
	// 매출 조회
	public List<SellerVO> getPrice(String licenseNo);
	
	// 매출 중복 체크
	public SellerVO getPrice1(String licenseNo);
	
	// 라이센스 등록
	public int insertLicense(LicenseVO vo);
	
	// id로 라이센스 번호 가져오기
	public List<LicenseVO> getInfo(LicenseVO vo);

	// 1:1 문의 insert하기
	public int insertSinquiry();

	// 1:1문의 list가져오기
	public List<MInquiryVO> getSinquiryList(int NpageNo);

	// 1:1문의 total count가져오기
	public int getSinquiryListcount();
		
	//lisenceNo로 푸드트럭 정보가져오기
	public FoodTruckVO getFoodtruckDtail(String licenseNo);
	
	// 푸드트럭별 상품 리스트 
	public List<ProductVO> getProductList(String licenseNo);
	
	
	public List<SellerVO> getDate(String licenseNo);
	
	//푸드트럭신청후 반려된 메시지 리스트
	public List<LicenseVO> getCheckList(String memid);
	
	//푸드트럭 신청 거절후 수정 버튼 클릭시 모달창에 가져오는 푸드트럭 정보 가져오기
	public FoodTruckVO getFoodTruckInfo(String memId) throws Exception;
	
	//푸드트럭 신청 거절후 수정 버튼 클릭시 모달창에 가져오는 푸드트럭 정보 가져오기->수정요청(license Table)
	public int fixUpdate(LicenseVO vo);
	
	//푸드트럭 신청 거절후 수정 버튼 클릭시 모달창에 가져오는 푸드트럭 정보 가져오기->수정요청(FoodTruck Table)
	public int fixUpdateFoodtruck(FoodTruckVO vo);
}
