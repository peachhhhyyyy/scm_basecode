package kr.happyjob.study.pcs.model;

import java.util.Date;

public class RefundModel {
  
  private String refund_list_no; // 반품번호
  private String order_cd; // 반품코드
  private String supply_nm; // 회사명
  private String supply_cd; // 회사코드
  private String prod_nm; // 반품제품
  private String m_ct_cd; // 브랜드명(구 품목명)
  private int refund_cnt; // 반품수량
  private Date submit_date; // 반품 신청 날짜
  private Date refund_date; // 반품 완료 날짜
  
  
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
  public int getRefund_cnt() {
    return refund_cnt;
  }
  public void setRefund_cnt(int refund_cnt) {
    this.refund_cnt = refund_cnt;
  }
  public Date getSubmit_date() {
    return submit_date;
  }
  public void setSubmit_date(Date submit_date) {
    this.submit_date = submit_date;
  }
  public Date getRefund_date() {
    return refund_date;
  }
  public void setRefund_date(Date refund_date) {
    this.refund_date = refund_date;
  }
  
  
}
