package com.foodtruck.dao;

import java.util.List;

import com.foodtruck.vo.ProductVO;

public interface ProductDAO {

	// 제품 정보
	public ProductVO getProduct(String prodNo);

	// 제품 리스트
	public List<ProductVO> getProductList(String licenseNo);

	// 제품 등록
	public int insertProduct(ProductVO vo);

	// 제품 수정
	public int updateProduct(ProductVO vo);

	// 제품 삭제
	public int deleteProduct(String prodNo);
	
	// 판매자 관리의 제품 리스트 출력하기
	public List<ProductVO> getProductList2(String licenseNo);
}
