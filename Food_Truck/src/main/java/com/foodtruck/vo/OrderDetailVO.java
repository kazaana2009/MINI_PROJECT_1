package com.foodtruck.vo;

public class OrderDetailVO extends OrderVO {

	private String prodNo; 	 // 제품 번호
	private String ordNo; 	 // 주문 번호
	private String prodName; // 제품 이름
	private String ordReq;	 // 주문 요청사항
	private int ordQty; 	 // 수량
	private int ordPrice; 	 // 금액
	private String memId; 	 // 회원 아이디
	
	// getter & setter
	
	public String getProdNo() {
		return prodNo;
	}
	public void setProdNo(String prodNo) {
		this.prodNo = prodNo;
	}
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getOrdReq() {
		return ordReq;
	}
	public void setOrdReq(String ordReq) {
		this.ordReq = ordReq;
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
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}

}
