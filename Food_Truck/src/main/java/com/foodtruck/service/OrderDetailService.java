package com.foodtruck.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.OrderDetailDAO;
import com.foodtruck.vo.OrderDetailVO;

@Service
public class OrderDetailService {
   @Autowired
   private SqlSessionTemplate sessionTemplate;

   //주문 상세
   public OrderDetailVO getOrderDetail(int ordNo) {
      OrderDetailDAO dao = sessionTemplate.getMapper(OrderDetailDAO.class);
      return dao.getOrderDetail(ordNo);
   }

   //판매자 입장에서 주문 내역 리스트
   public List<OrderDetailVO> getOrderDetailList(Map<String, Object> map) {
      OrderDetailDAO dao = sessionTemplate.getMapper(OrderDetailDAO.class);
      return dao.getOrderDetailList(map);
   }
   
   //주문 상세 수정
   public int updateOrderDetail(OrderDetailVO vo) {
      OrderDetailDAO dao = sessionTemplate.getMapper(OrderDetailDAO.class);
      return dao.updateOrderDetail(vo);
   }

   // 주문 상세 삭제
   public int deleteOrderDetail(String ordNo) {
      OrderDetailDAO dao = sessionTemplate.getMapper(OrderDetailDAO.class);
      return dao.deleteOrderDetail(ordNo);
   }
   
   // 주문 상세 등록
   public int insertOrderDetail(Map<String, Object> map) {
	   OrderDetailDAO dao = sessionTemplate.getMapper(OrderDetailDAO.class);
	   return dao.insertOrderDetail(map);
   }
   
	// 주문하고 주문 리스트 보여주는 거(영수증 역할) -> 비회원
	public List<OrderDetailVO> getOrderInfoList(String ordNo) {
		OrderDetailDAO dao = sessionTemplate.getMapper(OrderDetailDAO.class);
		return dao.getOrderInfoList(ordNo);
	}

}