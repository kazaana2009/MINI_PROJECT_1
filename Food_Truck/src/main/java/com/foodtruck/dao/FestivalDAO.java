package com.foodtruck.dao;

import java.util.List;

import com.foodtruck.vo.FestivalVO;

public interface FestivalDAO {
	
	//축제정보 리스트 가져오기
	public List<FestivalVO> getFestivalList() throws Exception;
	
	//축제정보 insert하기
	public int IntsertFestival(FestivalVO festivalVO) throws Exception;
	
	//축제정보 update하기
	public int UpdateFestival(FestivalDAO vo) throws Exception;
	
	//축제정보 삭제하기
	public int deleteFestival() throws Exception;
	
	//축제정보 count
	public int getcountFestival() throws Exception;
	
	//축제정보 10개씩 가져오기
	public List<FestivalVO> getFestivalList2(int npageNo) throws Exception;
	
	//푸드트럭 지역이름으로 행사정보 가져오기
	public List<FestivalVO> getFestivalList3(String addr)throws Exception;
	
	//푸드트럭 지역이름으로 행사정보 카운드
	public int getList3Count(String addr)throws Exception;
}
