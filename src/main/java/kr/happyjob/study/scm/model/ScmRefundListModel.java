package kr.happyjob.study.scm.model;

public class ScmRefundListModel {

	// 반품신청목록
	String orderCode;
	String customerName;
	String productName;
	String middleCategory;
	String refundDate;
	int refundCount;
	int refundAmount;
	String state;

	// 반품지시서
	String productCode;
	String supplyName;
	String orderDate;
	String WarehouseName;
	String scmManager;
	String refundDirectionDate;
	int STTcd;
	String approver;

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getMiddleCategory() {
		return middleCategory;
	}

	public void setMiddleCategory(String middleCategory) {
		this.middleCategory = middleCategory;
	}

	public String getRefundDate() {
		return refundDate;
	}

	public void setRefundDate(String refundDate) {
		this.refundDate = refundDate;
	}

	public int getRefundCount() {
		return refundCount;
	}

	public void setRefundCount(int refundCount) {
		this.refundCount = refundCount;
	}

	public int getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(int refundAmount) {
		this.refundAmount = refundAmount;
	}

	public String getstate() {
		return state;
	}

	public void setstate(String state) {
		this.state = state;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getWarehouseName() {
		return WarehouseName;
	}

	public void setWarehouseName(String WarehouseName) {
		this.WarehouseName = WarehouseName;
	}

	public String getScmManager() {
		return scmManager;
	}

	public void setScmManager(String scmManager) {
		this.scmManager = scmManager;
	}

	public String getRefundDirectionDate() {
		return refundDirectionDate;
	}

	public void setRefundDirectionDate(String refundDirectionDate) {
		this.refundDirectionDate = refundDirectionDate;
	}

	public int getSTTcd() {
		return STTcd;
	}

	public void setSTTcd(int sTTcd) {
		STTcd = sTTcd;
	}

	public String getApprover() {
		return approver;
	}

	public void setApprover(String approver) {
		this.approver = approver;
	}

}
