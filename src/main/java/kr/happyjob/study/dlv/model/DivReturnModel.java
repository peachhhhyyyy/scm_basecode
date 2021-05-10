package kr.happyjob.study.dlv.model;

import java.util.Date;

public class DivReturnModel {
	//반품지시서 번호
	private String refund_list_no;
	//주문코드
	private String order_cd;
	//scm 관리자 id
	private String scm_id;
	//제출일자
	private Date submit_date;
	//승인자id
	private String approve_id;
	//배송사원id
	private String ship_staff_id;
	//배송담당자 아이디
	private String ship_mng_id;
	//반품완료일자
	private Date refund_date;
		
	
	public DivReturnModel() {
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

	public String getApprove_id() {
		return approve_id;
	}

	public void setApprove_id(String approve_id) {
		this.approve_id = approve_id;
	}

	public String getShip_staff_id() {
		return ship_staff_id;
	}

	public void setShip_staff_id(String ship_staff_id) {
		this.ship_staff_id = ship_staff_id;
	}

	public String getShip_mng_id() {
		return ship_mng_id;
	}

	public void setShip_mng_id(String ship_mng_id) {
		this.ship_mng_id = ship_mng_id;
	}
	
	public Date getRefund_date() {
		return refund_date;
	}

	public void setRefund_date(Date refund_date) {
		this.refund_date = refund_date;
	}
	
}

