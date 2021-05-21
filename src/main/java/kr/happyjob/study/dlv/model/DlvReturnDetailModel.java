package kr.happyjob.study.dlv.model;

public class DlvReturnDetailModel {
	//주문코드
	private String order_cd;
	//반품코드
	private String refund_list_no;
	//카테고리명
	private String l_ct_cd;
	//제품명
	private String prod_nm;
	//반품수량
	private int refund_cnt;
	//고객명
	private String cus_name;
	//고객연락처
	private String cus_tel;
	//고객주소
	private String cus_addr;
	//배송사원 이름
	private String staff_name;
	//배송사원 연락처
	private String staff_tel;
	//SCM 명
	private String scm_name;
	//창고명
	private String warehouse_nm;
	//상태
	private String state;
	//적요
	private String request;
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getRefund_list_no() {
		return refund_list_no;
	}
	public void setRefund_list_no(String refund_list_no) {
		this.refund_list_no = refund_list_no;
	}
	public String getProd_nm() {
		return prod_nm;
	}
	public void setProd_nm(String prod_nm) {
		this.prod_nm = prod_nm;
	}
	public String getM_ct_nm() {
		return l_ct_cd;
	}
	public void setM_ct_nm(String m_ct_nm) {
		this.l_ct_cd = m_ct_nm;
	}
	public int getRefund_cnt() {
		return refund_cnt;
	}
	public void setRefund_cnt(int refund_cnt) {
		this.refund_cnt = refund_cnt;
	}
	public String getCus_name() {
		return cus_name;
	}
	public void setCus_name(String cus_name) {
		this.cus_name = cus_name;
	}
	public String getCus_tel() {
		return cus_tel;
	}
	public void setCus_tel(String cus_tel) {
		this.cus_tel = cus_tel;
	}
	public String getCus_addr() {
		return cus_addr;
	}
	public void setCus_addr(String cus_addr) {
		this.cus_addr = cus_addr;
	}
	public String getStaff_name() {
		return staff_name;
	}
	public void setStaff_name(String staff_name) {
		this.staff_name = staff_name;
	}
	public String getStaff_tel() {
		return staff_tel;
	}
	public void setStaff_tel(String staff_tel) {
		this.staff_tel = staff_tel;
	}
	public String getScm_name() {
		return scm_name;
	}
	public void setScm_name(String scm_name) {
		this.scm_name = scm_name;
	}
	public String getWarehouse_nm() {
		return warehouse_nm;
	}
	public void setWarehouse_nm(String warehouse_nm) {
		this.warehouse_nm = warehouse_nm;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getRequest() {
		return request;
	}
	public void setRequest(String request) {
		this.request = request;
	}
	
	
}
