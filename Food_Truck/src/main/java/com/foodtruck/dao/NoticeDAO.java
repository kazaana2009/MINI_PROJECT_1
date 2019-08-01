package com.foodtruck.dao;

import java.util.List;

import com.foodtruck.vo.NoticeVO;

public interface NoticeDAO {
	
	// 공시지사항 게시물가져오기
	public List<NoticeVO> getNoticeBoardList(int pageNo);
	
	// 공지사항 상세보기
	public NoticeVO getNotice(int noticeNo);
	
	// 공지사항 등록
	public int insertNotice(NoticeVO vo);
	
	// 공지사항 수정
	public int updateNotice(NoticeVO vo);
	
	// 공지사항 조회수
	public int countNotice(int noticeNo);
	
	// 공지사항 삭제
	public int deleteNotice(NoticeVO vo);
	
	//공지사항 페이징 전체 개시물 count 가져오기
	public int getCountNotice() throws Exception;
	 

}
