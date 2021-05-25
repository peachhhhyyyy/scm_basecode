package kr.happyjob.study.scm.model;


public class ScmOutgoingListModel {
	
	// 배송지시서 번호(index)
	private String ship_list_no;
	// 주문코드
	private String order_cd;
	// 고객명 
	private String cus_nm;
	// SCM 담당자 이름 
	private String scm_nm;
	// 주문일자
	private String order_date;
	// 지시서 제출일자
	private String submit_date;
	
	public String getShip_list_no() {
		return ship_list_no;
	}
	public void setShip_list_no(String ship_list_no) {
		this.ship_list_no = ship_list_no;
	}
	public String getCus_nm() {
		return cus_nm;
	}
	public void setCus_nm(String cus_nm) {
		this.cus_nm = cus_nm;
	}
	public String getScm_nm() {
		return scm_nm;
	}
	public void setScm_nm(String scm_nm) {
		this.scm_nm = scm_nm;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	
}
