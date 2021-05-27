package kr.happyjob.study.ctm.model;

public class OrderModel {
	// 제품 코드
	private String product_cd;
	// 제품명
	private String prod_nm;
	// 품목명
	private String l_ct_nm;
	// 상호명
	private String m_ct_nm;
	// 제품단가(원)
	private int price;
	// 중분류 코드(for JOIN)
	private String m_ct_cd;
	// 대분류 코드(for JOIN)
	private String l_ct_cd;
	// 제품 상세 정보
	private String detail;

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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getM_ct_cd() {
		return m_ct_cd;
	}

	public void setM_ct_cd(String m_ct_cd) {
		this.m_ct_cd = m_ct_cd;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}
}