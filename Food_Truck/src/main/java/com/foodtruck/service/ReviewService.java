package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.foodtruck.dao.ReviewDAO;

import com.foodtruck.vo.ReviewVO;

@Service
public class ReviewService {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	// 리뷰 리스트
	public List<ReviewVO> getReviewList(String ftruckNo) {
		ReviewDAO dao = sessionTemplate.getMapper(ReviewDAO.class);
		return dao.getReviewList(ftruckNo);
	}

	// 리뷰 등록
	public int insertReview(ReviewVO vo) {
		ReviewDAO dao = sessionTemplate.getMapper(ReviewDAO.class);
		return dao.insertReview(vo);
	}

	// 리뷰 수정
	public int updateReview(ReviewVO vo) {
		ReviewDAO dao = sessionTemplate.getMapper(ReviewDAO.class);
		return dao.updateReview(vo);
	}

	// 리뷰 삭제
	public int reviewDelete(int revNo) {
		ReviewDAO dao = sessionTemplate.getMapper(ReviewDAO.class);
		return dao.reviewDelete(revNo);
	}
	
	// 리뷰 쓸 때, 먹었던 해당 푸드트럭 이름 조회
	public List<ReviewVO> getFoodTrcukName(String memId) {
		ReviewDAO dao = sessionTemplate.getMapper(ReviewDAO.class);
		return dao.getFoodTrcukName(memId);
	}	
}
