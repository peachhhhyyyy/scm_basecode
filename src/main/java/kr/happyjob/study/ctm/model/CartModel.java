package kr.happyjob.study.ctm.model;

public class CartModel {

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
	
	
}