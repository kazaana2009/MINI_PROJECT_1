package com.foodtruck.dao;

import java.util.List;
import java.util.Map;

import com.foodtruck.vo.OrderVO;

public interface OrderDAO {

	// 주문 정보
	public OrderVO getOrder(int ordNo);

	// 주문 리스트
	public List<OrderVO> getOrderList();

	// 주문 수정
	public int updateOrder(OrderVO vo);

	// 주문 삭제
	public int deleteOrder(String ordNo);
	
	// 비회원이 주문번호 & 전화번호로 주문내역 조회
	public List<OrderVO> getNonmemberInfo(Map<String,Object> map);
	
	//사용자 이용내역
	public List<OrderVO> getMemberOrderList(String memId);
	
	//주문
	public int insertOrder(Map<String, Object> map);
	
	// 판매자 입장 / 상태 변경하기 (대기 / 조리 / 완료)
	public int cookStatChange(Map<String, Object> map);	
	
	// 새로운 예약 주문알림 갯수 표시하기
	public List<OrderVO> getNewCountRsv(String memId);
	
	// 새로운 배달 주문알림 갯수 표시하기
	public List<OrderVO> getNewCountDlv(String memId);
	
	// 새로운 예약 주문 확인
	public int checkNewOrderRsv(String memberId);
	
	// 새로운 배달 주문 확인
	public int checkNewOrderDlv(String memberId);
	
	// 사용자에게 배달시간보내기
	public OrderVO dlvTimeSend(String memberId);
	
	// 사용자가 배달시간을 확인하면 ORD_CHECK 3으로
	public int dlvTimeUpdate(String memberId);	
	
	public List<OrderVO> ordStatFind(String memberId);
	
	// 자주 시켜먹은 푸드트럭 순위 
	public List<OrderVO> getFavoriteFoodtruck(String memId);
	
	// 사용자가 주문한 정보 ordNo만 쓸거
	public List<OrderVO> getOrdNo(String memId);
}

