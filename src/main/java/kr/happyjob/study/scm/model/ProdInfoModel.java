package kr.happyjob.study.scm.model;

public class ProdInfoModel {
  /* 제품코드 */
  private String product_cd;

  /* 제품명 */
  private String prod_nm;
  
  /* 중분류(품목)명 */
  private String m_ct_nm;
  
  /* 공급처명 */
  private String supply_nm;
  
  /* 창고명 */
  private String warehouse_nm;
  
  /* 장비구매가 */
  private int purchase_price;
  
  /* 단가*/
  private int price;
  
  /* 중분류코드 */
  private String m_ct_cd;
  
  /* 공급처코드 */
  private String supply_cd;
  
  /* 창고코드 */
  private String warehouse_cd;
  
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

  public String getM_ct_nm() {
    return m_ct_nm;
  }

  public void setM_ct_nm(String m_ct_nm) {
    this.m_ct_nm = m_ct_nm;
  }

  public String getSupply_nm() {
    return supply_nm;
  }

  public void setSupply_nm(String supply_nm) {
    this.supply_nm = supply_nm;
  }

  public String getWarehouse_nm() {
    return warehouse_nm;
  }

  public void setWarehouse_nm(String warehouse_nm) {
    this.warehouse_nm = warehouse_nm;
  }

  public int getPurchase_price() {
    return purchase_price;
  }

  public void setPurchase_price(int purchase_price) {
    this.purchase_price = purchase_price;
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

  public String getSupply_cd() {
    return supply_cd;
  }

  public void setSupply_cd(String supply_cd) {
    this.supply_cd = supply_cd;
  }

  public String getWarehouse_cd() {
    return warehouse_cd;
  }

  public void setWarehouse_cd(String warehouse_cd) {
    this.warehouse_cd = warehouse_cd;
  }

}
