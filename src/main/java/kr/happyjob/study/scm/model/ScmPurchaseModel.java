package kr.happyjob.study.scm.model;

import java.util.Date;

public class ScmPurchaseModel {
  // 발주번호
  public int purch_list_no;
  // 제품명
  public String prod_nm;
  // 중분류 (품목명)
  public String m_ct_cd;
  // 공급사이름
  public String supply_nm;
  // 발주수량
  public int purch_qty;
  // 장비구매액
  public int purchase_price;
  // 발주총금액
  public int purch_total_amt;
  // 합계금액
  public int price;
  // SCM담당자명
  public String scm_id;
  // 발주지시날짜
  public Date direction_date;
  // 승인자
  public String approve_id;
  public int getPurch_list_no() {
    return purch_list_no;
  }
  public void setPurch_list_no(int purch_list_no) {
    this.purch_list_no = purch_list_no;
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
  public String getSupply_nm() {
    return supply_nm;
  }
  public void setSupply_nm(String supply_nm) {
    this.supply_nm = supply_nm;
  }
  public int getPurch_qty() {
    return purch_qty;
  }
  public void setPurch_qty(int purch_qty) {
    this.purch_qty = purch_qty;
  }
  public int getPurchase_price() {
    return purchase_price;
  }
  public void setPurchase_price(int purchase_price) {
    this.purchase_price = purchase_price;
  }
  public int getPurch_total_amt() {
    return purch_total_amt;
  }
  public void setPurch_total_amt(int purch_total_amt) {
    this.purch_total_amt = purch_total_amt;
  }
  public int getPrice() {
    return price;
  }
  public void setPrice(int price) {
    this.price = price;
  }
  public String getScm_id() {
    return scm_id;
  }
  public void setScm_id(String scm_id) {
    this.scm_id = scm_id;
  }
  public Date getDirection_date() {
    return direction_date;
  }
  public void setDirection_date(Date direction_date) {
    this.direction_date = direction_date;
  }
  public String getApprove_id() {
    return approve_id;
  }
  public void setApprove_id(String approve_id) {
    this.approve_id = approve_id;
  }
}
