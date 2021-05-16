package kr.happyjob.study.scm.model;

public class WarehouseInfoModel {
  // 창고 코드
  private String warehouse_cd;
  // 창고명
  private String warehouse_nm;
  // 창고 담당자명
  private String wh_mng_nm;
  // 창고 담당자 로그인 아이디
  private String wh_mng_cd;
  // 창고 담당자 연락처
  private String tel;
  // 창고 담당자 이메일
  private String email;
  // 우편주소
  private String zip_cd;
  // 주소
  private String addr;
  // 로그인 아이디
  private String loginID;
  
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
  public String getWh_mng_cd() {
    return wh_mng_cd;
  }
  public void setWh_mng_cd(String wh_mng_cd) {
    this.wh_mng_cd = wh_mng_cd;
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
}
