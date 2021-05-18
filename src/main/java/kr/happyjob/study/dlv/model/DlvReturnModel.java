package kr.happyjob.study.dlv.model;

public class DlvReturnModel {
	//반품지시서 번호
	private String refund_list_no;
	//고객명
	private String cus_name;
	//분류명
	private String l_ct_cd;
	//제품명
	private String prod_nm;
	//반품 수량
	private int refund_cnt;
	//반품 금액
	private int refund_amt;
	//창고명
	private String warehouse_nm;
	//반품 날짜 
	private String refund_date;
	//상태
	private String state;
	
	public DlvReturnModel() {
	}

	public String getRefund_list_no() {
		return refund_list_no;
	}

	public void setRefund_list_no(String refund_list_no) {
		this.refund_list_no = refund_list_no;
	}

	public String getCus_name() {
		return cus_name;
	}

	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}

	public String getM_ct_nm() {
		return l_ct_cd;
	}

	public void setM_ct_nm(String m_ct_nm) {
		this.l_ct_cd = m_ct_nm;
	}

	public String getProd_nm() {
		return prod_nm;
	}

	public void setProd_nm(String prod_nm) {
		this.prod_nm = prod_nm;
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
}

