package kr.happyjob.study.dlv.model;

public class DlvStaffNameModel {
	
	private String dlv_staff_name;
	
	private String loginID;

	public String getDlv_staff_name() {
		return dlv_staff_name;
	}

	public void setDlv_staff_name(String dlv_staff_name) {
		this.dlv_staff_name = dlv_staff_name;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	@Override
	public String toString() {
		return "DlvStaffNameModel [dlv_staff_name=" + dlv_staff_name + ", loginID=" + loginID + "]";
	}
	
	
	
}
