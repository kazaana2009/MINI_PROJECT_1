package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.AdminDAO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.MinquiryReplyVO;

@Service
public class AdminService {

	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	
	// 1:1 Q&A 댓글 등록
	public int insertMinquryReply(MinquiryReplyVO vo) {
		AdminDAO dao = sessionTemplate.getMapper(AdminDAO.class);
		return dao.insertMinquryReply(vo);
	}
	
	//푸드트럭 신청 list
	public List<LicenseVO> getRequestList(int NpageNo){
		AdminDAO dao = sessionTemplate.getMapper(AdminDAO.class);
		return dao.getRequestList(NpageNo);
	}
	
	//푸드트럭 신청 count
	public int getRequestCount() {
		AdminDAO dao = sessionTemplate.getMapper(AdminDAO.class);
		return dao.getRequestCount();
	}
	
	//푸드트럭 등록 최종 승인 업데이트
	public int appFoodtruck(LicenseVO vo) throws Exception {
		AdminDAO dao = sessionTemplate.getMapper(AdminDAO.class);
		return dao.appFoodtruck(vo);
	}
	
}
