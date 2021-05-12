package kr.happyjob.study.dlv.model;

public class DlvReturnDetailModel {
	//주문코드
	private String order_cd;
	//반품코드
	private String refund_list_no;
	//제품명
	private String prod_nm;
	//카테고리명
	private String m_ct_nm;
	//반품수량
	private int refund_cnt;
	//고객명
	private String cus_name;
	//고객연락처
	private int cus_tel;
	//담당자 이름
	private String emp_name;
	//담당자 주소
	private String emp_addr;
	//배송사원 이름
	private String dlv_name;
	//배송사원 연락처
	private int dlv_tel;
	//창고명
	private String warehouse_nm;
	//상태
	private String state;
	//적요
	private String request;
	
	public DlvReturnDetailModel() {
	}
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
		return m_ct_nm;
	}
	public void setM_ct_nm(String m_ct_nm) {
		this.m_ct_nm = m_ct_nm;
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
	public int getCus_tel() {
		return cus_tel;
	}
	public void setCus_tel(int cus_tel) {
		this.cus_tel = cus_tel;
	}
	public String getEmp_name() {
		return emp_name;
	}
	public void setEmp_name(String emp_name) {
		this.emp_name = emp_name;
	}
	public String getEmp_addr() {
		return emp_addr;
	}
	public void setEmp_addr(String emp_addr) {
		this.emp_addr = emp_addr;
	}
	public String getDlv_name() {
		return dlv_name;
	}
	public void setDlv_name(String dlv_name) {
		this.dlv_name = dlv_name;
	}
	public int getDlv_tel() {
		return dlv_tel;
	}
	public void setDlv_tel(int dlv_tel) {
		this.dlv_tel = dlv_tel;
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
