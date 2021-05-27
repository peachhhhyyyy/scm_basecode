package kr.happyjob.study.pcs.model;

import java.time.LocalDate;
import java.util.Date;

public class RefundDetailModel {
  
  private int purch_list_no; // 반품번호
  private String order_cd; // 반품코드
  private String supply_cd; // 회사코드(공급사)
  private String supply_nm; // 회사명(공급사)
  private String prod_nm; // 반품 제품명
  private String product_cd; // 반품 제품 코드
  private String m_ct_nm; // 상호명  
  private int return_qty; // 반품수량
  private int return_price; // 반품 금액
  private String return_mng_id; // 반품담당자
  private String return_date; // 반품 완료일
  private String purch_date; // 구매일
  private String desired_delivery_date; // 배송희망일
  private String warehouse_cd; // 창고코드
  private String addr; // 창고주소
  
  public int getPurch_list_no() {
    return purch_list_no;
  }
  public void setPurch_list_no(int purch_list_no) {
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
  public String getProduct_cd() {
    return product_cd;
  }
  public void setProduct_cd(String product_cd) {
    this.product_cd = product_cd;
  }
  public String getM_ct_nm() {
    return m_ct_nm;
  }
  public void setM_ct_nm(String m_ct_nm) {
    this.m_ct_nm = m_ct_nm;
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
  public String getReturn_date() {
    return return_date;
  }
  public void setReturn_date(String return_date) {
    this.return_date = return_date;
  }
  public String getPurch_date() {
    return purch_date;
  }
  public void setPurch_date(String purch_date) {
    this.purch_date = purch_date;
  }
  public String getDesired_delivery_date() {
    return desired_delivery_date;
  }
  public void setDesired_delivery_date(String desired_delivery_date) {
    this.desired_delivery_date = desired_delivery_date;
  }
  public String getWarehouse_cd() {
    return warehouse_cd;
  }
  public void setWarehouse_cd(String warehouse_cd) {
    this.warehouse_cd = warehouse_cd;
  }
  public String getAddr() {
    return addr;
  }
  public void setAddr(String addr) {
    this.addr = addr;
  }
  
  
}
