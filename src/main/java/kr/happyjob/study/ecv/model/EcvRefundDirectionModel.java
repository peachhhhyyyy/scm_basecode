package kr.happyjob.study.ecv.model;

public class EcvRefundDirectionModel {

	String submitDate;
	String customerCode;
	String customerName;
	String productName;
	int refundQty;
	int refundAmount;
	int refundTax;
	int totalRefundAmount;
	String scmManager;
	int sttCode;
	String orderCode;

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
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

	public int getRefundQty() {
		return refundQty;
	}

	public void setRefundQty(int refundQty) {
		this.refundQty = refundQty;
	}

	public int getRefundAmount() {
		return refundAmount;
	}

	public void setRefundAmount(int refundAmount) {
		this.refundAmount = refundAmount;
	}

	public int getRefundTax() {
		return refundTax;
	}

	public void setRefundTax(int refundTax) {
		this.refundTax = refundTax;
	}

	public int getTotalRefundAmount() {
		return totalRefundAmount;
	}

	public void setTotalRefundAmount(int totalRefundAmount) {
		this.totalRefundAmount = totalRefundAmount;
	}

	public String getScmManager() {
		return scmManager;
	}

	public void setScmManager(String scmManager) {
		this.scmManager = scmManager;
	}

	public int getSttCode() {
		return sttCode;
	}

	public void setSttCode(int sttCode) {
		this.sttCode = sttCode;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

}
