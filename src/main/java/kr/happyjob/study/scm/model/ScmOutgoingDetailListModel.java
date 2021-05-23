package kr.happyjob.study.scm.model;


public class ScmOutgoingDetailListModel {
	
	// 품목명 - 대분류
	private String l_ct_cd;
	// 제품명
	private String prod_nm;
	// 공급처명
	private String supply_nm;
	// 주문수량
	private String order_cnt;
	// 주문일자
	private String order_date;
	// 희망 납품일자
	private String want_receive_date;
	// 창고명
	private String warehouse_nm;
	// 요구사항
	private String request;
	
	public String getL_ct_cd() {
		return l_ct_cd;
	}
	public void setL_ct_cd(String l_ct_cd) {
		this.l_ct_cd = l_ct_cd;
	}
	public String getProd_nm() {
		return prod_nm;
	}
	public void setProd_nm(String prod_nm) {
		this.prod_nm = prod_nm;
	}
	public String getSupply_nm() {
		return supply_nm;
	}
	public void setSupply_nm(String supply_nm) {
		this.supply_nm = supply_nm;
	}
	public String getOrder_cnt() {
		return order_cnt;
	}
	public void setOrder_cnt(String order_cnt) {
		this.order_cnt = order_cnt;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getWant_receive_date() {
		return want_receive_date;
	}
	public void setWant_receive_date(String want_receive_date) {
		this.want_receive_date = want_receive_date;
	}
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	
	
}
