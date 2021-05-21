package kr.happyjob.study.scm.model;


public class ScmOutgoingListModel {
	
	// 배송지시서 번호(index)
	private String ship_list_no;
	// 고객명 
	private String cus_nm;
	// SCM 담당자 이름 
	private String scm_nm;
	// 주문일자
	private String order_date;
	// 지시서 제출일자
	private String submit_date;
	// 품목명 
	private String l_ct_nm;
	// 제품명 
	private String prod_nm;
	// 공급처명 
	private String supply_nm;
	// 주문 개수 
	private String order_cnt;
	// 창고명 
	private String warehouse_nm;
	// 희망 배송 일자
	private String want_receive_date;
	// 요청사항 
	private String request;
	
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
	public String getL_ct_nm() {
		return l_ct_nm;
	}
	public void setL_ct_nm(String l_ct_nm) {
		this.l_ct_nm = l_ct_nm;
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
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getWant_receive_date() {
		return want_receive_date;
	}
	public void setWant_receive_date(String want_receive_date) {
		this.want_receive_date = want_receive_date;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	
}
