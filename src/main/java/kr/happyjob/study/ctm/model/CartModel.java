package kr.happyjob.study.ctm.model;

import java.util.Date;

public class CartModel {
	
	private int row_num;

	/* 제품명 */
	private String prod_nm;
	
	/* 품목명 */
	private String l_ct_nm;
	
	/* 브랜드명 */
	private String m_ct_nm;
	
	/* 가격 */
	private int price;
	
	/* 제품코드 */
	private String product_cd;

	/* 상세정보 */
	private String detail;
	
	/* 중분류코드 */
	private String m_ct_cd;
	
	/* 대분류코드 */
	private String l_ct_cd; 
	
	/* 로그인ID */
	private String loginID;
	
	/* 장바구니 개수 */
	private int shopping_cart_qty;
	
	/* 장바구니 총 가격 */
	private int totalAmount;
	
	/* 배송희망날짜 */
	private Date want_receive_date;

	/* 요구사항 */
	private String request;
	
	/* 체크된 장바구니 제품코드 리스트 */
	private String[] pdcdarr;

	public int getRow_num() {
		return row_num;
	}

	public void setRow_num(int row_num) {
		this.row_num = row_num;
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

	public String getM_ct_nm() {
		return m_ct_nm;
	}

	public void setM_ct_nm(String m_ct_nm) {
		this.m_ct_nm = m_ct_nm;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProduct_cd() {
		return product_cd;
	}

	public void setProduct_cd(String product_cd) {
		this.product_cd = product_cd;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
	
	public String getM_ct_cd() {
		return m_ct_cd;
	}

	public void setM_ct_cd(String m_ct_cd) {
		this.m_ct_cd = m_ct_cd;
	}

	public String getL_ct_cd() {
		return l_ct_cd;
	}

	public void setL_ct_cd(String l_ct_cd) {
		this.l_ct_cd = l_ct_cd;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	
	public int getShopping_cart_qty() {
		return shopping_cart_qty;
	}

	public void setShopping_cart_qty(int shopping_cart_qty) {
		this.shopping_cart_qty = shopping_cart_qty;
	}

	public int getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}

	public String[] getPdcdarr() {
		return pdcdarr;
	}

	public void setPdcdarr(String[] pdcdarr) {
		this.pdcdarr = pdcdarr;
	}
	
	public Date getWant_receive_date() {
		return want_receive_date;
	}

	public void setWant_receive_date(Date want_receive_date) {
		this.want_receive_date = want_receive_date;
	}

	public String getRequest() {
		return request;
	}

	public void setRequest(String request) {
		this.request = request;
	}
	
}