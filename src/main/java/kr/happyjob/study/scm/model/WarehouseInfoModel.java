package kr.happyjob.study.scm.model;

public class WarehouseInfoModel {
  // 창고 코드
  private String warehouse_cd;
  // 창고명
  private String warehouse_nm;
  // 창고 담당자명
  private String wh_mng_nm;
  // 창고 담당자 로그인 아이디
  private String wh_mng_id;
  // 창고 담당자 연락처
  private String tel;
  // 창고 담당자 이메일
  private String email;
  // 우편주소
  private String zip_cd;
  // 주소
  private String addr;
  // 상세주소
  private String addr_detail;
  // 로그인 아이디
  private String loginID;
  // 활성화 여부
  private String use_yn;
  
  // 제품 코드
  private String product_cd;
  // 제품명
  private String prod_nm;
  // 품목명
  private String l_ct_nm;
  // 재고현황(개)
  private int stock;
  // 중분류 코드(for JOIN)
  private String m_ct_cd;
  // 대분류 코드(for JOIN)
  private String l_ct_cd;
  // 공급처 코드
  private String supply_cd;
  // 공급처명
  private String supply_nm;
  
  public String getLoginID() {
    return loginID;
  }
  
  public void setLoginID(String loginID) {
    this.loginID = loginID;
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
  
  public String getWh_mng_nm() {
    return wh_mng_nm;
  }
  
  public void setWh_mng_nm(String wh_mng_nm) {
    this.wh_mng_nm = wh_mng_nm;
  }
  
  public String getWh_mng_id() {
    return wh_mng_id;
  }
  
  public void setWh_mng_id(String wh_mng_id) {
    this.wh_mng_id = wh_mng_id;
  }
  
  public String getTel() {
    return tel;
  }
  
  public void setTel(String tel) {
    this.tel = tel;
  }
  
  public String getEmail() {
    return email;
  }
  
  public void setEmail(String email) {
    this.email = email;
  }
  
  public String getZip_cd() {
    return zip_cd;
  }
  
  public void setZip_cd(String zip_cd) {
    this.zip_cd = zip_cd;
  }
  
  public String getAddr() {
    return addr;
  }
  
  public void setAddr(String addr) {
    this.addr = addr;
  }
  
  public String getAddr_detail() {
    return addr_detail;
  }
  
  public void setAddr_detail(String addr_detail) {
    this.addr_detail = addr_detail;
  }
  
  public String getUse_yn() {
    return use_yn;
  }
  
  public void setUse_yn(String use_yn) {
    this.use_yn = use_yn;
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
  
  public String getM_ct_cd() {
    return m_ct_cd;
  }
  
  public void setM_ct_cd(String m_ct_cd) {
    this.m_ct_cd = m_ct_cd;
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
}
