package kr.happyjob.study.scm.model;


public class ScmReturnListModel {
	
	// 반품지시서 번호(index)
	private String refund_list_no;
	// 고객명 
	private String cus_nm;
	// 품목명 
	private String l_ct_nm;
	// 제품명 
	private String prod_nm;
	// 반품 개수 
	private String return_cnt;
	// SCM 담당자 이름 
	private String scm_nm;
	// 제출일자 
	private String submit_date;
	// 창고명 
	private String warehouse_nm;
	// 반품 총금액 
	private String refund_amt;
	// 승인ID(임원ID)
	private String approve_nm;
	// 공급처명 
	private String supply_nm;
	
	public String getRefund_list_no() {
		return refund_list_no;
	}
	public void setRefund_list_no(String refund_list_no) {
		this.refund_list_no = refund_list_no;
	}
	public String getCus_nm() {
		return cus_nm;
	}
	public void setCus_nm(String cus_nm) {
		this.cus_nm = cus_nm;
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
	public String getReturn_cnt() {
		return return_cnt;
	}
	public void setReturn_cnt(String return_cnt) {
		this.return_cnt = return_cnt;
	}
	public String getScm_nm() {
		return scm_nm;
	}
	public void setScm_nm(String scm_nm) {
		this.scm_nm = scm_nm;
	}
	public String getSubmit_date() {
		return submit_date;
	}
	public void setSubmit_date(String submit_date) {
		this.submit_date = submit_date;
	}
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getRefund_amt() {
		return refund_amt;
	}
	public void setRefund_amt(String refund_amt) {
		this.refund_amt = refund_amt;
	}
	public String getApprove_nm() {
		return approve_nm;
	}
	public void setApprove_nm(String approve_nm) {
		this.approve_nm = approve_nm;
	}
	public String getSupply_nm() {
		return supply_nm;
	}
	public void setSupply_nm(String supply_nm) {
		this.supply_nm = supply_nm;
	}
	
}
