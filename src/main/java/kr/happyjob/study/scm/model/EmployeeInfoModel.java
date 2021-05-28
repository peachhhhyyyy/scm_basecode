package kr.happyjob.study.scm.model;

public class EmployeeInfoModel {
  // 로그인아이디 & 사번
  public String loginID;
  // 이름
  public String name;
  // 담당업무
  public String detail_name;
  // 전화번호
  public String tel;
  // 활성화 여부
  public String out_yn;
  // 메일주소
  public String mail;
  // 우편번호
  public String zip_code;
  // 주소
  public String addr;
  // 상세주소
  public String addr_detail;
  // 입사일
  public String entry_date;

  public String getLoginID() {
    return loginID;
  }
  public void setLoginID(String loginID) {
    this.loginID = loginID;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getDetail_name() {
    return detail_name;
  }
  public void setDetail_name(String detail_name) {
    this.detail_name = detail_name;
  }
  public String getTel() {
    return tel;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
  public String getOut_yn() {
    return out_yn;
  }
  public void setOut_yn(String out_yn) {
    this.out_yn = out_yn;
  }
  public String getMail() {
    return mail;
  }
  public void setMail(String mail) {
    this.mail = mail;
  }
  public String getZip_code() {
    return zip_code;
  }
  public void setZip_code(String zip_code) {
    this.zip_code = zip_code;
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
  public String getEntry_date() {
    return entry_date;
  }
  public void setEntry_date(String entry_date) {
    this.entry_date = entry_date;
  }
}