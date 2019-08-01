package com.foodtruck.vo;

public class LicenseVO {
	
	private String licenseNo;		// 사업자번호
	private String memId;			// 회원 아이디
	private String appStat;			// 승인여부 (Y/N)
	private String appMsg;
	// getter & setter
	
	public String getLicenseNo() {
		return licenseNo;
	}

	public void setLicenseNo(String licenseNo) {
		this.licenseNo = licenseNo;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getAppStat() {
		return appStat;
	}

	public void setAppStat(String appStat) {
		this.appStat = appStat;
	}

	public String getAppMsg() {
		return appMsg;
	}

	public void setAppMsg(String appMsg) {
		this.appMsg = appMsg;
	}
	
	
}
