package kr.happyjob.study.dlv.model;

import java.util.Date;

public class DlvReturnModel {
	//반품지시서 번호
	private String refund_list_no;
	//주문코드
	private String order_cd;
	//scm 관리자 id
	private String supply_nm;
	//scm 관리자 코드
	private String supply_cd;
	//제품명
	private String prod_nm;
	//품목명
	private String m_ct_cd;
	//수량
	private String refund_cnt;
	//반품 날짜
	private String refund_date;
	//반품 금액
	private String refund_amt;
	//창고명
	private String warehouse_nm;
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
	public String getOrder_cd() {
		return order_cd;
	}
	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}
	public String getSupply_nm() {
		return supply_nm;
	}
	public void setSupply_nm(String supply_nm) {
		this.supply_nm = supply_nm;
	}
	public String getSupply_cd() {
		return supply_cd;
	}
	public void setSupply_cd(String supply_cd) {
		this.supply_cd = supply_cd;
	}
	public String getProd_nm() {
		return prod_nm;
	}
	public void setProd_nm(String prod_nm) {
		this.prod_nm = prod_nm;
	}
	public String getM_ct_cd() {
		return m_ct_cd;
	}
	public void setM_ct_cd(String m_ct_cd) {
		this.m_ct_cd = m_ct_cd;
	}
	public String getRefund_cnt() {
		return refund_cnt;
	}
	public void setRefund_cnt(String refund_cnt) {
		this.refund_cnt = refund_cnt;
	}
	public String getRefund_date() {
		return refund_date;
	}
	public void setRefund_date(String refund_date) {
		this.refund_date = refund_date;
	}
	public String getRefund_amt() {
		return refund_amt;
	}
	public void setRefund_amt(String refund_amt) {
		this.refund_amt = refund_amt;
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
}

