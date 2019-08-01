package com.foodtruck.dao;

import java.util.List;
import java.util.Map;

import com.foodtruck.vo.DeliveryDetailVO;

public interface DeliveryDetailDAO {

   // 배달상세 정보
   public DeliveryDetailVO getDeliveryDetail(String prodNo);

   // 배달상세 리스트
   public List<DeliveryDetailVO> getDeliveryDetailList(Map<String, Object> map);

   // 배달상세 등록
   public int insertDeliveryDetail(DeliveryDetailVO vo);

   // 배달상세 수정
   public int dlecookStatChange(Map<String, Object> map);

   // 배달상세 삭제
   public int deleteDeliveryDetail(String prodNo);
   
   //주문 접수후 배달시간 조정
   public int dlyTimeUpdate(Map<String, Object> map);
}