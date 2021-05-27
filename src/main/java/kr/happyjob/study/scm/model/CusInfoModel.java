package kr.happyjob.study.scm.model;

public class CusInfoModel {
	
	// 회사명
	private String company_nm;
	// 회사 매니저명
	private String company_mng_nm;
	// 매니저 연락처
	private String mng_tel;
	// 기업 활성화 여부
	private String active;
	
	public String getCompany_nm() {
		return company_nm;
	}
	public void setCompany_nm(String company_nm) {
		this.company_nm = company_nm;
	}
	public String getCompany_mng_nm() {
		return company_mng_nm;
	}
	public void setCompany_mng_nm(String company_mng_nm) {
		this.company_mng_nm = company_mng_nm;
	}
	public String getMng_tel() {
		return mng_tel;
	}
	public void setMng_tel(String mng_tel) {
		this.mng_tel = mng_tel;
	}
	public String getActive() {
		return active;
	}
	public void setActive(String active) {
		this.active = active;
	}
	
	
}
