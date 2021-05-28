package kr.happyjob.study.ctm.model;

import java.util.Date;

public class OrderListModel {
	// 제품 코드
	private String product_cd;
	// 제품명
	private String prod_nm;
	// 품목명
	private String l_ct_nm;
	// 상호명
	private String m_ct_nm;
	// 총 구매금액(부가세별도)
	private int amount;
	// 총 세금
	private int tax;
	// 주문 번호
	private String order_cd;
	// 주문 수량
	private int order_cnt;
	// 주문 날짜
	private String order_date;
	// 희망 배송 날짜
	private String want_receive_date;
	// 상태
	private String state;
	// 중분류 코드(for JOIN)
	private String m_ct_cd;
	// 대분류 코드(for JOIN)
	private String l_ct_cd;
	

	public String getL_ct_cd() {
		return l_ct_cd;
	}

	public void setL_ct_cd(String l_ct_cd) {
		this.l_ct_cd = l_ct_cd;
	}

	public String getM_ct_nm() {
		return m_ct_nm;
	}

	public void setM_ct_nm(String m_ct_nm) {
		this.m_ct_nm = m_ct_nm;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getTax() {
		return tax;
	}

	public void setTax(int tax) {
		this.tax = tax;
	}

	public String getOrder_cd() {
		return order_cd;
	}

	public void setOrder_cd(String order_cd) {
		this.order_cd = order_cd;
	}

	public int getOrder_cnt() {
		return order_cnt;
	}

	public void setOrder_cnt(int order_cnt) {
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

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getProduct_cd() {
		return product_cd;
	}

	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
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

	public String getM_ct_cd() {
		return m_ct_cd;
	}

	public void setM_ct_cd(String m_ct_cd) {
		this.m_ct_cd = m_ct_cd;
	}
}