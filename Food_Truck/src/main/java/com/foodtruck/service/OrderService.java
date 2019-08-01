package com.foodtruck.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.OrderDAO;
import com.foodtruck.vo.LicenseVO;
import com.foodtruck.vo.OrderVO;

@Service
public class OrderService {
	@Autowired
	private SqlSessionTemplate sessionTemplate;

	// 주문 정보
	public OrderVO getOrder(int ordNo) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getOrder(ordNo);
	}

	// 주문 리스트
	public List<OrderVO> getOrderList() {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getOrderList();
	}

	// 주문 수정
	public int updateOrder(OrderVO vo) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.updateOrder(vo);
	}

	// 주문 삭제
	public int deleteOrder(String ordNo) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.deleteOrder(ordNo);
	}
	
	
	// 비회원이 주문번호 & 전화번호로 주문내역 조회
	public List<OrderVO> getNonmemberInfo(Map<String,Object> map) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getNonmemberInfo(map);
	}
	   
	// 사용자 이용내역
	public List<OrderVO> getMemberOrderList(String memberId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getMemberOrderList(memberId);
	}
	
	// 주문
	public int insertOrder(Map<String, Object> map) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.insertOrder(map);
	}
	
	// 판매자 입장 / 상태 변경하기 (대기 / 조리 / 완료)
	public int cookSataChange(Map<String, Object> map) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.cookStatChange(map);
	}	
	
	// 새로운 예약 주문알림 갯수 표시하기
	public List<OrderVO> getNewCountRsv(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getNewCountRsv(memId);
	}	
	
	// 새로운 배달 주문알림 갯수 표시하기
	public List<OrderVO> getNewCountDlv(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getNewCountDlv(memId);
	}
	
	// 새로운 예약 주문 확인
	public int checkNewOrderRsv(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.checkNewOrderRsv(memId);
	}
	
	// 새로운 배달 주문 확인
	public int checkNewOrderDlv(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.checkNewOrderDlv(memId);
	}	

	// 사용자에게 배달시간 보내기
	public OrderVO dlvTimeSend(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.dlvTimeSend(memId);
	}

	// 사용자가 배달시간을 확인하면 ORD_CHECK 3으로
	public int dlvTimeUpdate(String memberId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.dlvTimeUpdate(memberId);
	}	
	
	public List<OrderVO> ordStatFind(String memberId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.ordStatFind(memberId);
	}
	
	// 자주 시켜먹은 푸드트럭 순위
	public List<OrderVO> getFavoriteFoodtruck(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getFavoriteFoodtruck(memId);
	}
	
	// 사용자가 주문한 정보 ordNo만 쓸거
	public List<OrderVO> getOrdNo(String memId) {
		OrderDAO dao = sessionTemplate.getMapper(OrderDAO.class);
		return dao.getOrdNo(memId);
	}	
}
