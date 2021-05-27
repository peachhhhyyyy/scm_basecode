package kr.happyjob.study.scm.model;

public class EmployeeInfoModel {
  public String loginID;
  public String name;
  public String user_type;
  public String tel;
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
  public String getUser_type() {
    return user_type;
  }
  public void setUser_type(String user_type) {
    this.user_type = user_type;
  }
  public String getTel() {
    return tel;
  }
  public void setTel(String tel) {
    this.tel = tel;
  }
}