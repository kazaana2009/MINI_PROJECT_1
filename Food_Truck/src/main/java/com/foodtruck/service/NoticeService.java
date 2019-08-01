package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.MemberDAO;
import com.foodtruck.dao.NoticeDAO;
import com.foodtruck.vo.NoticeVO;

@Service
public class NoticeService {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	// 공시지사항 게시물가져오기
	public List<NoticeVO> getNoticeBoardList(int pageNo) {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.getNoticeBoardList(pageNo);
	}
	
	// 공지사항 상세보기
	public NoticeVO getNotice(int noticeNo) {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.getNotice(noticeNo);
	}
	
	// 공지사항 등록
	public int insertNotice(NoticeVO vo) {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.insertNotice(vo);
	}
	
	// 공지사항 수정	
	public int updateNotice(NoticeVO vo) {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.updateNotice(vo);
	}

	// 공지사항 조회수
	public int countNotice(int noticeNo) {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.countNotice(noticeNo);
	}
	
	// 공지사항 삭제
	public int deleteNotice(NoticeVO vo) {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.deleteNotice(vo);
	}
	
	//공지사항 페이징 전체 개시물 count 가져오기
	public int getCountNotice() throws Exception {
		NoticeDAO dao = sessionTemplate.getMapper(NoticeDAO.class);
		return dao.getCountNotice();
	}

}
