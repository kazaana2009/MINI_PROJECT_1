package com.foodtruck.vo;

public class DeliveryDetailVO extends OrderDetailVO{
	
	private String ordNo;		// 주문 번호
	private int dlvState;		// 배달 상태
	private String dlvAddr;		// 배달 주소
	private String dlvDate;		// 배달 시간
	
	// getter & setter
	
	public String getOrdNo() {
		return ordNo;
	}
	public void setOrdNo(String ordNo) {
		this.ordNo = ordNo;
	}
	public String getDlvAddr() {
		return dlvAddr;
	}
	public void setDlvAddr(String dlvAddr) {
		this.dlvAddr = dlvAddr;
	}
	public String getDlvDate() {
		return dlvDate;
	}
	public void setDlvDate(String dlvDate) {
		this.dlvDate = dlvDate;
	}
	public int getDlvState() {
		return dlvState;
	}
	public void setDlvState(int dlvState) {
		this.dlvState = dlvState;
	}
	
}
