package com.foodtruck.vo;

public class FestivalVO {
	
	private String fesNo;			//축제 번호
	private String fesAddr;			//주소
	private String fesName;			//제목
	private String fesTel;			//전화번호
	private String fesSdate;		//시작일
	private String fesEdate;		//종료일
	private String fesImg2;			//썸네일 이미지
	private String fesImg;			//대표 이미지
	private String fesLatitude;		//위도
	private String fesLongitude;	//경도
	private String fesId;			//콘텐츠ID (상세정보조회 필수)
	private String fesContent;		//축제 내용
	
	// getter & setter
	
	public String getFesNo() {
		return fesNo;
	}
	public void setFesNo(String fesNo) {
		this.fesNo = fesNo;
	}
	public String getFesAddr() {
		return fesAddr;
	}
	public void setFesAddr(String fesAddr) {
		this.fesAddr = fesAddr;
	}
	public String getFesName() {
		return fesName;
	}
	public void setFesName(String fesName) {
		this.fesName = fesName;
	}
	public String getFesTel() {
		return fesTel;
	}
	public void setFesTel(String fesTel) {
		this.fesTel = fesTel;
	}
	public String getFesSdate() {
		return fesSdate;
	}
	public void setFesSdate(String fesSdate) {
		this.fesSdate = fesSdate;
	}
	public String getFesEdate() {
		return fesEdate;
	}
	public void setFesEdate(String fesEdate) {
		this.fesEdate = fesEdate;
	}
	public String getFesImg2() {
		return fesImg2;
	}
	public void setFesImg2(String fesImg2) {
		this.fesImg2 = fesImg2;
	}
	public String getFesImg() {
		return fesImg;
	}
	public void setFesImg(String fesImg) {
		this.fesImg = fesImg;
	}
	public String getFesLatitude() {
		return fesLatitude;
	}
	public void setFesLatitude(String fesLatitude) {
		this.fesLatitude = fesLatitude;
	}
	public String getFesLongitude() {
		return fesLongitude;
	}
	public void setFesLongitude(String fesLongitude) {
		this.fesLongitude = fesLongitude;
	}
	public String getFesId() {
		return fesId;
	}
	public void setFesId(String fesId) {
		this.fesId = fesId;
	}
	public String getFesContent() {
		return fesContent;
	}
	public void setFesContent(String fesContent) {
		this.fesContent = fesContent;
	}
}
