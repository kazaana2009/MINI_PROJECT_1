package com.foodtruck.dao;

import java.util.List;

import com.foodtruck.vo.ReviewVO;

public interface ReviewDAO {

	// 리뷰 리스트
	public List<ReviewVO> getReviewList(String ftruckNo);

	// 리뷰 등록
	public int insertReview(ReviewVO vo);

	// 리뷰 수정
	public int updateReview(ReviewVO vo);

	// 리뷰 삭제
	public int reviewDelete(int revNo);
	
	// 리뷰 쓸 때, 먹었던 해당  푸드트럭 이름 조회
	public List<ReviewVO> getFoodTrcukName(String memId);	
}
