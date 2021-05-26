package kr.happyjob.study.scm.model;

public class SupplierInfoModel {
  // 공급처 코드
  private String supply_cd;
  // 공급처명
  private String supply_nm;
  // 공급처 담당자명
  private String supply_mng_nm;
  // 공급처 연락처
  private String tel;
  // 공급처 담당자 연락처
  private String mng_tel;
  // 공급처 담당자 이메일
  private String email;
  // 창고 코드
  private String warehouse_cd;
  // 창고명
  private String warehouse_nm;
  // 제품 코드
  private String product_cd;
  // 제품명
  private String prod_nm;
  // 품목명
  private String l_ct_nm;
  // 재고현황(개)
  private int stock;
  // 제품단가(원)
  private int price;
  // 중분류 코드(for JOIN)
  private String m_ct_cd;
  // 대분류 코드(for JOIN)
  private String l_ct_cd;
  // 장비구매액
  private String purchase_price;
  
  public String getPurchase_price() {
    return purchase_price;
  }
  
  public void setPurchase_price(String purchase_price) {
    this.purchase_price = purchase_price;
  }
  
  public String getL_ct_cd() {
    return l_ct_cd;
  }
  
  public void setL_ct_cd(String l_ct_cd) {
    this.l_ct_cd = l_ct_cd;
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
  
  public String getSupply_mng_nm() {
    return supply_mng_nm;
  }
  
  public void setSupply_mng_nm(String supply_mng_nm) {
    this.supply_mng_nm = supply_mng_nm;
  }
  
  public String getTel() {
    return tel;
  }
  
  public void setTel(String tel) {
    this.tel = tel;
  }
  
  public String getMng_tel() {
    return mng_tel;
  }
  
  public void setMng_tel(String mng_tel) {
    this.mng_tel = mng_tel;
  }
  
  public String getEmail() {
    return email;
  }
  
  public void setEmail(String email) {
    this.email = email;
  }
  
  public String getWarehouse_cd() {
    return warehouse_cd;
  }
  
  public void setWarehouse_cd(String warehouse_cd) {
    this.warehouse_cd = warehouse_cd;
  }
  
  public String getWarehouse_nm() {
    return warehouse_nm;
  }
  
  public void setWarehouse_nm(String warehouse_nm) {
    this.warehouse_nm = warehouse_nm;
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
  
  public int getStock() {
    return stock;
  }
  
  public void setStock(int stock) {
    this.stock = stock;
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
}
