package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.EventDAO;
import com.foodtruck.vo.EventVO;

@Service
public class EventService {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	// 등록된 이벤트 리스트
	public List<EventVO> getEventBoardList(int NpageNo) {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.getEventBoardList(NpageNo);
	}
	
	// 이벤트 상세보기
	public EventVO getEvent(int eventNo) {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.getEvent(eventNo);
	}
	
	// 이벤트 등록
	public int insertEvent(EventVO vo) {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		
		return dao.insertEvent(vo);
	}
	
	// 이벤트 수정
	public int updateEvent(EventVO vo) {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.updateEvent(vo);
	}
	
	// 조회수 	
	public int countEvent(int eventNo) {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.countEvent(eventNo);
	}
	
	// 이벤트 삭제
	public int deleteEvent(EventVO vo) {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.deleteEvent(vo);
	}
	
	// 이벤트 총갯수
	public int getCountEvent() {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.getCountEvent();
	}
	
	// menuBoard에 이벤트 진행중이면, 푸드트럭 이름 옆에 이벤트 띄워 주려고
	public List<EventVO> progressEvent() {
		EventDAO dao = sessionTemplate.getMapper(EventDAO.class);
		return dao.progressEvent();
	}

}
