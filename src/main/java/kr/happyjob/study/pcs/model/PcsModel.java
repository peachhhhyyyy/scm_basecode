package kr.happyjob.study.pcs.model;

import java.util.Date;

public class PcsModel {
  public String purch_list_no;
  public String prod_nm;
  public String l_ct_cd;
  public int purch_qty;
  public int purch_total_amt;
  public Date desired_delivery_date;
  public String warehouse_nm;
  public String purch_mng_id;
  public String warehouse_cd;
  public String supply_nm;
  public String getPurch_list_no() {
    return purch_list_no;
  }
  public void setPurch_list_no(String purch_list_no) {
    this.purch_list_no = purch_list_no;
  }
  public String getProd_nm() {
    return prod_nm;
  }
  public void setProd_nm(String prod_nm) {
    this.prod_nm = prod_nm;
  }
  public String getL_ct_cd() {
    return l_ct_cd;
  }
  public void setL_ct_cd(String l_ct_cd) {
    this.l_ct_cd = l_ct_cd;
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
  public Date getDesired_delivery_date() {
    return desired_delivery_date;
  }
  public void setDesired_delivery_date(Date desired_delivery_date) {
    this.desired_delivery_date = desired_delivery_date;
  }
  public String getWarehouse_nm() {
    return warehouse_nm;
  }
  public void setWarehouse_nm(String warehouse_nm) {
    this.warehouse_nm = warehouse_nm;
  }
  public String getPurch_mng_id() {
    return purch_mng_id;
  }
  public void setPurch_mng_id(String purch_mng_id) {
    this.purch_mng_id = purch_mng_id;
  }
  public String getWarehouse_cd() {
    return warehouse_cd;
  }
  public void setWarehouse_cd(String warehouse_cd) {
    this.warehouse_cd = warehouse_cd;
  }
  public String getSupply_nm() {
    return supply_nm;
  }
  public void setSupply_nm(String supply_nm) {
    this.supply_nm = supply_nm;
  }
}