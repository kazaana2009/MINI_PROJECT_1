package com.foodtruck.dao;

import java.util.List;
import java.util.Map;

import com.foodtruck.vo.OrderDetailVO;

public interface OrderDetailDAO {

   // 주문 상세
   public OrderDetailVO getOrderDetail(int ordNo);

   // 판매자 입장에서 주문 내역 리스트
   public List<OrderDetailVO> getOrderDetailList(Map<String, Object> map);

   // 주문 상세 등록
   public int insertOrderDetail(OrderDetailVO vo);

   // 주문 상세 수정
   public int updateOrderDetail(OrderDetailVO vo);

   // 주문 상세 삭제
   public int deleteOrderDetail(String ordNo);
   
   // 주문
   public int insertOrderDetail(Map<String, Object> map);
   
   // 주문하고 주문 리스트 보여주는 거(영수증 역할) -> 비회원
   public List<OrderDetailVO> getOrderInfoList(String ordNo);
}