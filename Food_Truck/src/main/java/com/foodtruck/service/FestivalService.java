package com.foodtruck.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.foodtruck.dao.FestivalDAO;
import com.foodtruck.vo.FestivalVO;

@Service
public class FestivalService {
	
	@Autowired
	private SqlSessionTemplate sessionTemplate;
	
	//축제정보 리스트 가져오기
	public List<FestivalVO> getFestivalList() throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.getFestivalList();
	}
	
	//축제정보 insert하기
	public int IntsertFestival(FestivalVO festivalVO) throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.IntsertFestival(festivalVO);
	}
	
	//축제정보 update하기
	public int getUpdateFestival(FestivalDAO vo) throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.UpdateFestival(vo);
	}
	
	//축제정보 삭제하기
	public int deleteFestival() throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.deleteFestival();
	}
	
	//축제정보 10개씩 가져오기
	public List<FestivalVO> getFestivalList2(int npageNo) throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.getFestivalList2(npageNo);
	}
	
	//축제정보 count
	public int getcountFestival()throws Exception {
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.getcountFestival();
	}
	
	//푸드트럭 지역이름으로 행사정보 가져오기
	public List<FestivalVO> getFestivalList3(String addr) throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.getFestivalList3(addr);
	}
	
	//푸드트럭 지역이름으로 행사정보 카운드
	public int getList3Count(String addr) throws Exception{
		FestivalDAO dao=sessionTemplate.getMapper(FestivalDAO.class);
		return dao.getList3Count(addr);
	}
}
