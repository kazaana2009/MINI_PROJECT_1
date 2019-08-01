
package com.foodtruck.vo;

public class OrderVO {
	
	private String ordNo;		// 주문번호
	private String ordName;		// 주문자 이름
	private String ordTel;		// 주문자 연락처
	private String ordDate;		// 주문 시간
	private String ordRsvDate;	// 예약 시간(시)
	private String ordDlyYn;	// 배달 여부(Y/N)
	private int ordStat;		// 주문 상태
	private int cookStat;		// 조리 상태
	private String memId;		// 회원 아이디
	private String licenseNo;	// 사업자 번호
	private int ordQty;			// 상품 수량
	private int ordPrice;		// 상품 가격
	private int sumPrice;		// 주문 총 합계 
	private String ordReq;		// 요구사항
	private String prodName;	// 상품 이름
	private String ftruckName;	// 푸드트럭 이름
	private int newCount;		// 새로운 주문갯수
	private String ordCheck;	// 새로들어온 주문 확인(Y/N)
	private int payment;		// 결제방식
	private String dlvAddr1;	// 배달 주소 1
	private String dlvAddr2;	// 배달 주소 2
	private int favoriteCount;	// 관심있는 푸드트럭 갯수
	private int rank;			// 순위
	private String ftruckNo;	// 푸드트럭 번호
	private String dlvDate;		// 배달시간
	
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
	public int getOrdQty() {
		return ordQty;
	}
	public void setOrdQty(int ordQty) {
		this.ordQty = ordQty;
	}
	public int getOrdPrice() {
		return ordPrice;
	}
	public void setOrdPrice(int ordPrice) {
		this.ordPrice = ordPrice;
	}
	public int getSumPrice() {
		return sumPrice;
	}
	public void setSumPrice(int sumPrice) {
		this.sumPrice = sumPrice;
	}
	public String getOrdReq() {
		return ordReq;
	}
	public void setOrdReq(String ordReq) {
		this.ordReq = ordReq;
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
	public int getNewCount() {
		return newCount;
	}
	public void setNewCount(int newCount) {
		this.newCount = newCount;
	}
	public String getOrdCheck() {
		return ordCheck;
	}
	public void setOrdCheck(String ordCheck) {
		this.ordCheck = ordCheck;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	
	public String getDlvAddr1() {
		return dlvAddr1;
	}
	public void setDlvAddr1(String dlvAddr1) {
		this.dlvAddr1 = dlvAddr1;
	}
	public String getDlvAddr2() {
		return dlvAddr2;
	}
	public void setDlvAddr2(String dlvAddr2) {
		this.dlvAddr2 = dlvAddr2;
	}
	public int getFavoriteCount() {
		return favoriteCount;
	}
	public void setFavoriteCount(int favoriteCount) {
		this.favoriteCount = favoriteCount;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public String getFtruckNo() {
		return ftruckNo;
	}
	public void setFtruckNo(String ftruckNo) {
		this.ftruckNo = ftruckNo;
	}
	public String getDlvDate() {
		return dlvDate;
	}
	public void setDlvDate(String dlvDate) {
		this.dlvDate = dlvDate;
	}
}
