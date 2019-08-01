package com.foodtruck.vo;

public class SellerVO {
	private String ordNo;		 // 주문 번호
	private String ordName;		 // 주문자 이름
	private String ordTel;		 // 주문자 연락처
	private String ordDate;		 // 주문 시간
	private String ordRsvDate;	 // 예약 시간
	private String ordDlyYn;	 // 배달시간	
	private int ordStat;		 // 주문 상태
	private int cookStat;		 // 조리 상태
	private String memId;		 // 회원 아이디
	private String licenseNo;	 // 사업자 번호
	private String prodName;	 // 제품 이름
	private String ftruckName;	 // 푸드트럭 이름
	private String ordReq;		 // 요구 사항
	private String payment;		 // 결제 방식
	private int ratio;			 
	private int count;
	private String sumPrice;	 // 총가격
	private String salesDate;	 
	
	// getter & setter

	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getOrdName() {
		return ordName;
	}
	public void setOrdName(String ordName) {
		this.ordName = ordName;
	}
	public String getOrdTel() {
		return ordTel;
	}
	public void setOrdTel(String ordTel) {
		this.ordTel = ordTel;
	}
	public String getOrdDate() {
		return ordDate;
	}
	public void setOrdDate(String ordDate) {
		this.ordDate = ordDate;
	}
	public String getOrdRsvDate() {
		return ordRsvDate;
	}
	public void setOrdRsvDate(String ordRsvDate) {
		this.ordRsvDate = ordRsvDate;
	}
	public String getOrdDlyYn() {
		return ordDlyYn;
	}
	public void setOrdDlyYn(String ordDlyYn) {
		this.ordDlyYn = ordDlyYn;
	}
	public int getOrdStat() {
		return ordStat;
	}
	public void setOrdStat(int ordStat) {
		this.ordStat = ordStat;
	}
	public int getCookStat() {
		return cookStat;
	}
	public void setCookStat(int cookStat) {
		this.cookStat = cookStat;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getLicenseNo() {
		return licenseNo;
	}
	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getFtruckName() {
		return ftruckName;
	}
	public void setFtruckName(String ftruckName) {
		this.ftruckName = ftruckName;
	}
	public String getOrdReq() {
		return ordReq;
	}
	public void setOrdReq(String ordReq) {
		this.ordReq = ordReq;
	}
	public String getPayment() {
		return payment;
	}
	public void setPayment(String payment) {
		this.payment = payment;
	}
	public int getRatio() {
		return ratio;
	}
	public void setRatio(int ratio) {
		this.ratio = ratio;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(String sumPrice) {
		this.sumPrice = sumPrice;
	}
	public String getSalesDate() {
		return salesDate;
	}
	public void setSalesDate(String salesDate) {
		this.salesDate = salesDate;
	}

}
