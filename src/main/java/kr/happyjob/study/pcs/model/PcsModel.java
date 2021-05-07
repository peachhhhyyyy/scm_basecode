package kr.happyjob.study.pcs.model;

import java.util.Date;

public class PcsModel {
  public String purch_list_no;
  public String order_cd;
  public String supply_cd;
  public String scm_id;
  public String purch_mng_id;
  public Date direction_date;
  public Date purch_cate;
  public int purch_qty;
  public int purch_total_amt;
  public String approve_id;
  public Date desired_delivery_date;
  public int return_price;
  public int return_qty;
  public Date return_date;
  public String return_mng_id;
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
  public String getScm_id() {
    return scm_id;
  }
  public void setScm_id(String scm_id) {
    this.scm_id = scm_id;
  }
  public String getPurch_mng_id() {
    return purch_mng_id;
  }
  public void setPurch_mng_id(String purch_mng_id) {
    this.purch_mng_id = purch_mng_id;
  }
  public Date getDirection_date() {
    return direction_date;
  }
  public void setDirection_date(Date direction_date) {
    this.direction_date = direction_date;
  }
  public Date getPurch_cate() {
    return purch_cate;
  }
  public void setPurch_cate(Date purch_cate) {
    this.purch_cate = purch_cate;
  }
  public int getPurch_qty() {
    return purch_qty;
  }
  public void setPurch_qty(int purch_qty) {
    this.purch_qty = purch_qty;
  }
  public int getPurch_total_amt() {
    return purch_total_amt;
  }
  public void setPurch_total_amt(int purch_total_amt) {
    this.purch_total_amt = purch_total_amt;
  }
  public String getApprove_id() {
    return approve_id;
  }
  public void setApprove_id(String approve_id) {
    this.approve_id = approve_id;
  }
  public Date getDesired_delivery_date() {
    return desired_delivery_date;
  }
  public void setDesired_delivery_date(Date desired_delivery_date) {
    this.desired_delivery_date = desired_delivery_date;
  }
  public int getReturn_price() {
    return return_price;
  }
  public void setReturn_price(int return_price) {
    this.return_price = return_price;
  }
  public int getReturn_qty() {
    return return_qty;
  }
  public void setReturn_qty(int return_qty) {
    this.return_qty = return_qty;
  }
  public Date getReturn_date() {
    return return_date;
  }
  public void setReturn_date(Date return_date) {
    this.return_date = return_date;
  }
  public String getReturn_mng_id() {
    return return_mng_id;
  }
  public void setReturn_mng_id(String return_mng_id) {
    this.return_mng_id = return_mng_id;
  }
}