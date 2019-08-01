package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.ProductDAO;
import com.foodtruck.vo.ProductVO;

@Service
public class ProductService {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	// 제품 정보
	public ProductVO getProduct(String prodNo) {
		ProductDAO dao = sessionTemplate.getMapper(ProductDAO.class);
		return dao.getProduct(prodNo);
	}

	// 제품 리스트
	public List<ProductVO> getProductList(String licenseNo) {
		ProductDAO dao = sessionTemplate.getMapper(ProductDAO.class);
		return dao.getProductList(licenseNo);
	}

	// 제품 등록
	public int insertProduct(ProductVO vo) {
		ProductDAO dao = sessionTemplate.getMapper(ProductDAO.class);
		return dao.insertProduct(vo);
	}

	// 제품 수정
	public int updateProduct(ProductVO vo) {
		ProductDAO dao = sessionTemplate.getMapper(ProductDAO.class);
		return dao.updateProduct(vo);
	}

	// 제품 삭제
	public int deleteProduct(String prodNo) {
		ProductDAO dao = sessionTemplate.getMapper(ProductDAO.class);
		return dao.deleteProduct(prodNo);
	}

}
