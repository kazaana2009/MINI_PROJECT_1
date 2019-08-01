package com.foodtruck.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.DeliveryDetailDAO;
import com.foodtruck.vo.DeliveryDetailVO;

@Service
public class DeliveryDetailService {
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	// 배달 상세 정보
	public DeliveryDetailVO getDeliveryDetail(String ordNo) {
		DeliveryDetailDAO dao = sessionTemplate.getMapper(DeliveryDetailDAO.class);
		return dao.getDeliveryDetail(ordNo);
	}

	// 배달 상세 리스트Ʈ
	public List<DeliveryDetailVO> getDeliveryDetailList(Map<String, Object> map) {
		DeliveryDetailDAO dao = sessionTemplate.getMapper(DeliveryDetailDAO.class);
		return dao.getDeliveryDetailList(map);
	}

	// 배달 상세 등록
	public int insertDeliveryDetail(DeliveryDetailVO vo) {
		DeliveryDetailDAO dao = sessionTemplate.getMapper(DeliveryDetailDAO.class);
		return dao.insertDeliveryDetail(vo);
	}

	// 배달 상세 수정
	public int dlecookStatChange(Map<String, Object> map) {
		DeliveryDetailDAO dao = sessionTemplate.getMapper(DeliveryDetailDAO.class);
		return dao.dlecookStatChange(map);
	}

	// 배달 상세 삭제
	public int deleteDeliveryDetail(String ordNo) {
		DeliveryDetailDAO dao = sessionTemplate.getMapper(DeliveryDetailDAO.class);
		return dao.deleteDeliveryDetail(ordNo);
	}
	
	//주문 접수후 배달 시간 설정
	public int dlyTimeUpdate(Map<String, Object> map) {
		DeliveryDetailDAO dao = sessionTemplate.getMapper(DeliveryDetailDAO.class);
		return dao.dlyTimeUpdate(map);
	}

}
