package kr.happyjob.study.scm.model;

public class DeliveryInfoModel {
	/*
	 * 배송지시서 필요한 목록들 SCM관리자 제출일자 주문일자 희망납품일자 기업고객명 제품명 품목명 주문수량 요구사항
	 */
	private String scmManager;
	private String orderCode;
	private String orderDate;
	private String submitDate;
	private String wantReceiveDate;
	private String customerName;
	private String productName;
	private String middleCategory;
	private int orderCount;
	private String customerRequest;
	private String supplyName;
	private int productStock;
	private String warehouseCode;

	public String getScmManager() {
		return scmManager;
	}

	public void setScmManager(String scmManager) {
		this.scmManager = scmManager;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public String getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(String orderDate) {
		this.orderDate = orderDate;
	}

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getWantReceiveDate() {
		return wantReceiveDate;
	}

	public void setWantReceiveDate(String wantReceiveDate) {
		this.wantReceiveDate = wantReceiveDate;
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

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public String getCustomerRequest() {
		return customerRequest;
	}

	public void setCustomerRequest(String customerRequest) {
		this.customerRequest = customerRequest;
	}

	public String getsupplyName() {
		return supplyName;
	}

	public void setsupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public int getProductStock() {
		return productStock;
	}

	public void setProductStock(int productStock) {
		this.productStock = productStock;
	}

	public String getWarehouseCode() {
		return warehouseCode;
	}

	public void setWarehouseCode(String warehouseCode) {
		this.warehouseCode = warehouseCode;
	}

}
