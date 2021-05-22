package kr.happyjob.study.scm.model;


public class ScmReturnDetailListModel {
	
	// SCM이름
	private String scm_nm;
	// 품목명
	private String l_ct_nm;
	// 제품명
	private String prod_nm;
	// 반품 수량
	private int refund_cnt;
	// 창고명
	private String warehouse_nm;
	// 공급처 명
	private String supply_nm;
	// 반품 신청날짜
	private String refund_date;
	// 반품 총액
	private int refund_amt;
	// 주문일자
	private String order_date;
	// 지시서 제출일자
	private String submit_date;
	// 지시서 승인자명
	private String approve_nm;
	
	public String getScm_nm() {
		return scm_nm;
	}
	public void setScm_nm(String scm_nm) {
		this.scm_nm = scm_nm;
	}
	public String getProd_nm() {
		return prod_nm;
	}
	public void setProd_nm(String prod_nm) {
		this.prod_nm = prod_nm;
	}
	public String getL_ct_nm() {
		return l_ct_nm;
	}
	public void setL_ct_nm(String l_ct_nm) {
		this.l_ct_nm = l_ct_nm;
	}
	public String getSupply_nm() {
		return supply_nm;
	}
	public void setSupply_nm(String supply_nm) {
		this.supply_nm = supply_nm;
	}
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(String refund_date) {
		this.refund_date = refund_date;
	}
	public int getRefund_cnt() {
		return refund_cnt;
	}
	public void setRefund_cnt(int refund_cnt) {
		this.refund_cnt = refund_cnt;
	}
	public int getRefund_amt() {
		return refund_amt;
	}
	public void setRefund_amt(int refund_amt) {
		this.refund_amt = refund_amt;
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
	public String getApprove_nm() {
		return approve_nm;
	}
	public void setApprove_nm(String approve_nm) {
		this.approve_nm = approve_nm;
	}
	
}
