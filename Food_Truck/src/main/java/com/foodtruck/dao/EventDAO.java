package com.foodtruck.dao;

import java.util.List;

import com.foodtruck.vo.EventVO;

public interface EventDAO {
	
	// 등록된 이벤트 리스트
	public List<EventVO> getEventBoardList(int NpageNo);
	
	// 이벤트 상세보기
	public EventVO getEvent(int eventNo);
	
	// 이벤트 등록
	public int insertEvent(EventVO vo);
	
	// 이벤트 수정
	public int updateEvent(EventVO vo);
	
	// 조회수 
	public int countEvent(int eventNo);
	
	// 이벤트 삭제
	public int deleteEvent(EventVO vo);
	
	// 이벤트 총갯수
	public int getCountEvent();
	
	// menuBoard에 이벤트 진행중이면, 푸드트럭 이름 옆에 이벤트 띄워 주려고
	public List<EventVO> progressEvent();
	
}
