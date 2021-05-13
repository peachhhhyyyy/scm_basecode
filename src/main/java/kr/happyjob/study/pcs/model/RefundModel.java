package kr.happyjob.study.pcs.model;

import java.util.Date;

public class RefundModel {
  
  private String purch_list_no; // 반품번호
  private String order_cd; // 반품코드
  private String supply_cd; // 회사코드(공급사)
  private String supply_nm; // 회사명(공급사)
  private String prod_nm; // 반품 제품명
  private String m_ct_cd; // 브랜드(구 품목명)
  private int return_qty; // 반품수량
  private int return_price; // 반품 금액
  private String return_mng_id; // 반품담당자
  private Date return_date; // 반품 완료 날짜
  
  
  public String getPurch_list_no() {
    return purch_list_no;
  }
  public void setPurch_list_no(String purch_list_no) {
    this.purch_list_no = purch_list_no;
  }
  public String getOrder_cd() {
    return order_cd;
  }
  public void setOrder_cd(String order_cd) {
    this.order_cd = order_cd;
  }
  public String getSupply_cd() {
    return supply_cd;
  }
  public void setSupply_cd(String supply_cd) {
    this.supply_cd = supply_cd;
  }
  public String getSupply_nm() {
    return supply_nm;
  }
  public void setSupply_nm(String supply_nm) {
    this.supply_nm = supply_nm;
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
  public int getReturn_price() {
    return return_price;
  }
  public void setReturn_price(int return_price) {
    this.return_price = return_price;
  }
  public String getReturn_mng_id() {
    return return_mng_id;
  }
  public void setReturn_mng_id(String return_mng_id) {
    this.return_mng_id = return_mng_id;
  }
  public Date getReturn_date() {
    return return_date;
  }
  public void setReturn_date(Date return_date) {
    this.return_date = return_date;
  }
  
}
