package kr.happyjob.study.scm.model;

import java.util.Date;

public class ScmReturnListModel {
	//반품지시서 번호
	private String refund_list_no;
	//고객명
	private String cus_name;
	//제품명
	private String prod_nm;
	//분류명
	private String m_ct_cd;
	//반품개수
	private int return_qty;
	//scm관리자
	private String scm_id;
	//제출일자
	private Date submit_date;
	
	public ScmReturnListModel() {
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

	public int getReturn_qty() {
		return return_qty;
	}

	public void setReturn_qty(int return_qty) {
		this.return_qty = return_qty;
	}

	public String getScm_id() {
		return scm_id;
	}

	public void setScm_id(String scm_id) {
		this.scm_id = scm_id;
	}

	public Date getSubmit_date() {
		return submit_date;
	}

	public void setSubmit_date(Date submit_date) {
		this.submit_date = submit_date;
	}
	
}
